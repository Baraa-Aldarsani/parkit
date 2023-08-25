// ignore_for_file: depend_on_referenced_packages, avoid_print, deprecated_member_use
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:parking/controller/date_time_controller.dart';
import 'package:parking/controller/subscription/subscription_controller.dart';
import 'package:parking/model/car_model.dart';
import 'package:parking/model/favorite_model.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../helper/constant.dart';
import '../../model/archive_model.dart';
import '../../model/location_model.dart';
import '../../model/subscription_garage_model.dart';
import '../../view/parking_ticket_view.dart';
import '../../view/parking_view.dart';
import 'package:latlong2/latlong.dart' as lat;
import '../services/services_controller.dart';
import '../user/user_controller.dart';
import 'location_services.dart';

class LocationController extends GetxController with StateMixin {
  RxInt selectedIndexButtons = 0.obs;
  RxInt selectedIndexText = 0.obs;
  RxInt selectedQualities = RxInt(-1);
  var isFavorite = false.obs;
  RxInt floor = 1.obs;

  int get updateFloor => floor.value;
  var locationNon = <LocationModel>[].obs;
  var locations = <LocationModel>[].obs;
  var favorite = <FavoriteModel>[].obs;
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  late MapController mapController;
  RxBool serviceEnabled = false.obs;
  RxBool isLoading = false.obs;
  final DateTimeController _timeController = Get.put(DateTimeController());

  @override
  void onInit() {
    super.onInit();
    fetchLocationsAvailible();
    fetchLocationsNonAvailible();
    favoriteGarage();
    change(Colors.blue, status: RxStatus.success());
    mapController = MapController();
    getCurrentLocation();
    Geolocator.getServiceStatusStream().listen((event) {
      serviceEnabled.value = !serviceEnabled.value;
    });
  }

  void changeColor(int index) {
    selectedIndexButtons.value = index;
    selectedIndexText.value = index;
    update();
  }

  void changeQualities(int index) {
    selectedQualities.value = index;
    update();
  }

  String getStatusQualities(int index) {
    return selectedQualities.value == index ? 'select' : 'noSelect';
  }

  Widget getStatusQualities1(int index, String parking) {
    String status = 'noSelect';
    status = selectedQualities.value == index ? 'select' : 'noSelect';
    return status == 'noSelect'
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 200,
              height: 60,
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: darkblue),
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  color: lightgreen),
              alignment: Alignment.center,
              child: Text(
                parking,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 200,
              height: 60,
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: darkblue),
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  color: darkblue),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    parking,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    Icons.check_box,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          );
  }

  Color getColorButtons(int index) {
    return selectedIndexButtons.value == index ? darkblue : Colors.white;
  }

  Color getColorText(int index) {
    return selectedIndexButtons.value == index ? Colors.white : darkblue;
  }

  void increase(int index) {
    floor.value = index + 1;
    update();
  }

  void showParkingDetails(LocationModel location) {
    Get.bottomSheet(
      ParkingDetailScreen(location: location),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void toggleFavorite(String locationName, int id) async {
    var location = locations.firstWhere((l) => l.name == locationName);
    location.favorite = !location.favorite;
    if (location.favorite == true) {
      await addFavoriteGarage(id);
    } else {
      await removeFavoriteGarage(id);
    }
    location.favoriteIcon.value = Icon(
      location.favorite ? Icons.favorite : Icons.favorite_border_outlined,
      size: 35,
      color: location.favorite ? red : deepdarkblue,
    );
  }

  double totalPrice(double price) {
    double totalHours = _timeController.dateTime2.hour.toDouble() -
        _timeController.dateTime1.hour.toDouble();
    RxDouble totalPrice = 0.0.obs;
    for (double i = 0; i < totalHours; i++) {
      totalPrice.value += price;
    }
    return totalPrice.value;
  }

  final UserController user = Get.put(UserController());

  Future<void> checkPayment(
      LocationModel location,
      CarModel car,
      int duration,
      List time,
      int day,
      String mounth,
      int year,
      List parkingSpot,
      int carId,
      int parkingId,
      int floorId) {
    double finalPrice =
        totalPrice(location.price) + totalPrice(location.price) / 10;
    if (user.user.value.wallet!.price >= finalPrice) {
      return AwesomeDialog(
        context: Get.context!,
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        title: 'Successful!',
        desc: 'Successfully made payment for your parking',
        titleTextStyle: TextStyle(
            color: darkblue, fontSize: 20, fontWeight: FontWeight.bold),
        btnOkText: "Ticket",
        btnCancelColor: red,
        btnOkColor: deepdarkblue,
        btnCancelOnPress: () {},
        btnOkOnPress: () async {
          await addReservation(location, carId, parkingId, floorId, time);
          Get.to(ParkingTicketView(
            location: location,
            car: car,
            duration: duration,
            time: time,
            day: day,
            mounth: mounth,
            year: year,
            parkingSpot: parkingSpot,
          ));
        },
      ).show();
    } else {
      return AwesomeDialog(
        context: Get.context!,
        dialogType: DialogType.info,
        animType: AnimType.rightSlide,
        title: 'The wallet is empty',
        desc: 'The wallet must be charged to be able to book a recipe',
        titleTextStyle: TextStyle(
            color: darkblue, fontSize: 20, fontWeight: FontWeight.bold),
        btnCancelColor: red,
        btnOkColor: deepdarkblue,
        btnCancelOnPress: () {},
        btnOkOnPress: () {},
      ).show();
    }
  }

  Future<void> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    serviceEnabled.value = await Geolocator.isLocationServiceEnabled();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      await _requestLocationPermission();
    } else if (!serviceEnabled.value) {
      _showLocationSettingsDialog();
    } else {
      isLoading.value = true;
      try {
        Position position = await Geolocator.getCurrentPosition();
        latitude.value = position.latitude;
        longitude.value = position.longitude;
        moveCameraToCurrentLocation();
      } catch (e) {
        print("Error getting current location: $e");
      }
      isLoading.value = false;
    }
  }

  void moveCameraToCurrentLocation() {
    final currentLatLng = lat.LatLng(latitude.value, longitude.value);
    mapController.move(currentLatLng, 18.0);
  }

  Future<void> _requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();
    if (status.isGranted) {
      getCurrentLocation();
    }
  }

  void _showLocationSettingsDialog() {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: const Icon(Icons.location_on, size: 70),
          title: const Text('Activate location identification'), 
          content: const Text(
            'Location identification must be activated to use this application. Would you like to open the locator settings',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Get.back();
                await Geolocator.openLocationSettings();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void isLoadingFun() {
    isLoading.value = !isLoading.value;
  }

  RxString initSub = 'monthly'.obs;
  RxDouble selectedSubscriptionPrice = 0.0.obs;
  Rx<double> totalPriceSub = Rx<double>(0.0);
  final SubscriptionController subscription = Get.put(SubscriptionController());

  void updateSelectedSubscription(String type) {
    initSub.value = type;
    selectedSubscriptionPrice.value = subscription.subscription
        .firstWhere(
          (sub) => sub.type == type,
          orElse: () => SubscriptionGarageModel(price: 0.0, id: 0, type: ''),
        )
        .price;
  }

  int numberOftype = 0;

  void showSubscriptionDialog(int id) {
    List<String> subscriptionTypes = subscription.subscription
        .map((subscription) => subscription.type)
        .toSet()
        .toList();
    TextEditingController numController = TextEditingController();
    GlobalKey<FormState> formstate = GlobalKey<FormState>();
    AwesomeDialog(
      context: Get.context!,
      dialogType: DialogType.INFO,
      animType: AnimType.SCALE,
      title: 'Subscribe to Garage',
      desc: 'Choose a subscription plan to get started.',
      body: Column(
        children: [
          const SizedBox(height: 10),
          Text(
            "Subscribe to Garage",
            style: TextStyle(
                color: darkblue, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          Obx(
            () => Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                  border: Border.all(width: 1.5, color: Colors.grey.shade400),
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: DropdownButton<String>(
                value: initSub.value,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                icon: const Icon(Icons.subscript),
                isExpanded: true,
                underline: Container(),
                onChanged: (String? newValue) {
                  initSub.value = newValue!;
                  updateSelectedSubscription(newValue);
                },
                items: subscriptionTypes
                    .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Obx(
            () => Form(
              key: formstate,
              child: TextFormField(
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'please enter a duration';
                  }
                },
                keyboardType: TextInputType.number,
                controller: numController,
                decoration: InputDecoration(
                  labelText: 'Number of ${initSub.value}',
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Obx(() => Text(
              "The subscription price is for 1 ${initSub.value} : \$${selectedSubscriptionPrice.value}")),
          const SizedBox(height: 15),
          Obx(() {
            double subscriptionPrice = selectedSubscriptionPrice.value;
            numController.addListener(() {
              int numberOfMonths = int.tryParse(numController.text) ?? 1;
              totalPriceSub.value = subscriptionPrice * numberOfMonths;
            });
            numberOftype = int.tryParse(numController.text) ?? 1;
            return Text(
              'Total Price: \$ ${totalPriceSub.value.toStringAsFixed(2)}',
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: darkblue),
            );
          }),
        ],
      ),
      titleTextStyle:
          TextStyle(color: darkblue, fontSize: 20, fontWeight: FontWeight.bold),
      btnCancelColor: red,
      btnOkColor: deepdarkblue,
      btnCancelText: 'Cancel',
      btnCancelOnPress: () {
        numController.clear();
        totalPriceSub.value = 0;
      },
      btnOkText: 'Subscribe',
      btnOkOnPress: () async {
        if (formstate.currentState!.validate()) {
          // print(user.user.value.wallet!.price);
          // print(totalPriceSub.value);
          if (user.user.value.wallet!.price >= totalPriceSub.value) {
            await subscription.addSubscription(id, numberOftype, initSub.value);
            numController.clear();
            totalPriceSub.value = 0;
          } else {
            AwesomeDialog(
              context: Get.context!,
              dialogType: DialogType.info,
              animType: AnimType.rightSlide,
              title: 'Please top up your balance',
              desc: 'The wallet must be charged to be able to book a recipe',
              titleTextStyle: TextStyle(
                  color: darkblue, fontSize: 20, fontWeight: FontWeight.bold),
              btnCancelColor: red,
              btnOkColor: deepdarkblue,
              btnCancelOnPress: () {},
              btnOkOnPress: () {},
            ).show();
            numController.clear();
            totalPriceSub.value = 0;
          }
        }
      },
    ).show();
  }

  void showCustomDialog(LocationModel location) {
    final ServicesController servicesController = Get.put(ServicesController());
    AwesomeDialog(
      context: Get.context!,
      dialogType: DialogType.question,
      body: Column(
        children: [
          const SizedBox(height: 25),
          ElevatedButton(
            onPressed: () {
              servicesController.getServicesForGarage(location.id);
            },
            style: ElevatedButton.styleFrom(
              primary: lightgreen,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: Text(
              'Services',
              style: TextStyle(color: deepdarkblue, fontSize: 18),
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              showSubscriptionDialog(location.id);
            },
            style: ElevatedButton.styleFrom(
              primary: deepdarkblue,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: Text(
              'Subscription',
              style: TextStyle(color: lightgreen, fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    ).show();
  }

  Future<void> fetchLocationsAvailible() async {
    try {
      final List<LocationModel> fetchlocations =
          await LocationService.fetchLocationsAvail();
      locations.assignAll(fetchlocations);
      update();
    } catch (e) {
      print('Error fetching locations: $e');
    }
  }

  Future<void> fetchLocationsNonAvailible() async {
    try {
      final List<LocationModel> fetchlocations =
          await LocationService.fetchLocationsNonAvail();
      locationNon.assignAll(fetchlocations);
      update();
    } catch (e) {
      print('Error fetching locations: $e');
    }
  }

  Future<void> favoriteGarage() async {
    try {
      final List<FavoriteModel> fetchfavorite =
          await LocationService.getFavorite();
      favorite.assignAll(fetchfavorite);
      update();
    } catch (e) {
      print('Error get favorite Garages: $e');
    }
  }

  Future<void> addFavoriteGarage(int id) async {
    try {
      await LocationService.addFavorite(id);
    } catch (e) {
      print('Error add favorite Garage: $e');
    }
  }

  Future<void> removeFavoriteGarage(int id) async {
    try {
      await LocationService.removeFavorite(id);
    } catch (e) {
      print('Error add favorite Garage: $e');
    }
  }

  Future<void> addReservation(LocationModel location, int carId, int parkingId,
      int floorId, List time) async {
    try {
      await LocationService.addReservationUser(
          location, carId, parkingId, floorId, time);
    } catch (e) {
      print('Error add reservation : $e');
    }
  }

  Future<void> addTimeReservation(ArchiveModel1 model1,int hour) async{
    try{
      await LocationService.addTime(model1,hour);
      AwesomeDialog(
        context: Get.context!,
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        title: 'Successful!',
        desc: 'Successfully made payment for your parking',
        titleTextStyle: TextStyle(
            color: darkblue, fontSize: 20, fontWeight: FontWeight.bold),
        btnOkText: "Ok",
        btnOkColor: Colors.green,
        btnOkOnPress: (){},
      ).show();
    }catch(e){
      print('Error add Time reservation : $e');
    }
  }
}
