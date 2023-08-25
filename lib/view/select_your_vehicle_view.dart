// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking/controller/car/car_controller.dart';
import 'package:parking/view/book_parking_details.dart';
import 'package:parking/view/cars/add_car_view.dart';

import '../helper/constant.dart';
import '../model/car_model.dart';
import '../model/location_model.dart';

class SelectYourVehicleView extends StatelessWidget {
  final LocationModel? location;
  CarModel? car;

  SelectYourVehicleView({Key? key, this.location}) : super(key: key);
  final CarController _carController = Get.put(CarController());
  int carId = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                        Get.back();
                        _carController.selectedCar.value = -1;
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 35,
                  ),
                ),
                const Text(
                  "Select Your Vehicle",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
            FutureBuilder(
                future: _carController.fetchCars(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Expanded(
                        child: Center(child: CircularProgressIndicator()));
                  } else if (snapshot.hasError) {
                    return const Text("");
                  } else {
                    return  Obx(
                      () => Expanded(
                          child: ListView.separated(
                            itemCount: _carController.cars.length,
                            itemBuilder: (BuildContext context, int index) {
                              car = _carController.cars[index];
                              return Obx(
                                () => Container(
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: _carController.cars[index].isSelected
                                          ? Border.all(width: 2.5, color: darkblue)
                                          : null,
                                      borderRadius:
                                          const BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: RadioListTile(
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                      activeColor: darkblue,
                                      secondary: SizedBox(
                                        width: 90,
                                        child: CachedNetworkImage(
                                          imageUrl: _carController.cars[index].imageCar,
                                          placeholder: (context, url) => const CircularProgressIndicator(),
                                          errorWidget: (context, url, error) => const Icon(Icons.error),
                                        ),
                                      ),
                                      title: Text(
                                        _carController.cars[index].name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      subtitle: Text(
                                        _carController.cars[index].number.toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      value: _carController.cars[index].id,
                                      onChanged: (val) {
                                        _carController.updateSelectedCar(val!);
                                        car = _carController.cars.firstWhere((car) => car.id == val);
                                        carId = _carController.cars[index].id;
                                      },
                                      groupValue: _carController.selectedCar.value,
                                    ),
                                  ),
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) =>
                                const SizedBox(
                              height: 15,
                            ),
                          ),
                        ),
                    );
                  }
                }),
            Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: lightgreen),
              child: MaterialButton(
                onPressed: () {
                  Get.to(AddCarScreen());
                },
                child: Text(
                  "Add new vehicle",
                  style: TextStyle(
                    fontSize: 18,
                    color: darkblue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 0.1),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: lightgreen),
        padding:
            const EdgeInsets.only(left: 15, right: 15, bottom: 13, top: 10),
        child: _buildButtons(),
      ),
    );
  }

  Widget _buildButtons() {
    return _buildMaterialButton(
      label: 'Continue',
      backgroundColor: deepdarkblue,
      textColor: lightgreen,
      onPressed: (){
        if(carId != -1){
          Get.to(BookParkingDetails(
            location: location,
            car: car,
            carId: carId,
          ));
        }
      }
    );
  }

  Widget _buildMaterialButton({
    required String label,
    required Color backgroundColor,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return MaterialButton(
      height: 60,
      // minWidth: 180,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: BorderSide(color: backgroundColor),
      ),
      color: backgroundColor,
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
