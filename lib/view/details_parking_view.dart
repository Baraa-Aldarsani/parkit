import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:parking/helper/constant.dart';
import 'package:parking/model/location_model.dart';
import 'package:parking/view/select_your_vehicle_view.dart';
import '../controller/garage/location_controller.dart';
import '../controller/services/services_controller.dart';
import '../controller/subscription/subscription_controller.dart';
import 'long_text_view.dart';

class DetailsParkingView extends StatelessWidget {
  final LocationModel? location;
  final LocationController _controller = Get.put(LocationController());
  final SubscriptionController sub = Get.put(SubscriptionController());
  DetailsParkingView({Key? key, this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> open = location!.time_open.split(':');
    List<String> close = location!.time_close.split(':');
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 35),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 35,
                    ),
                  ),
                  const Text(
                    "Parking Details",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 200,
                child: _buildParkingImage(),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Parking Lot of ${location!.name}",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        location!.street,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () => _controller.toggleFavorite(
                        location!.name, location!.id),
                    icon: Obx(() => location!.favoriteIcon.value),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text("Country : ${location!.country}",
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(width: 38),
                  Text("City : ${location!.city}",
                      style: const TextStyle(fontSize: 18))
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDetailContainer(
                    icon: Icon(
                      Icons.location_on,
                      color: darkblue,
                      size: 20,
                    ),
                    label: '2 KM',
                    width: 95,
                  ),
                  _buildDetailContainer(
                    icon: Icon(
                      Icons.timer,
                      color: darkblue,
                      size: 20,
                    ),
                    label:
                        '${open[0]}:${open[1]} AM - ${close[0]}:${close[1]} PM',
                    width: 190,
                  ),
                  _buildDetailContainer(
                    label: 'valet',
                    width: 80,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              LongTextView(
                text: location!.description,
              ),
              const SizedBox(height: 20),
              _buildPriceContainer(),
            ],
          ),
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Transform.scale(
          scale: 1.2,
          child: FloatingActionButton(
            onPressed: () {
              _controller.showCustomDialog(location!);
              sub.fetchSubscription(location!.id);
            },
            backgroundColor: deepdarkblue,
            child: Transform.scale(
                scale: 0.6,
                child: Image.asset("assets/images/park.png",)),
          ),
        ),
      ),
    );
  }

  Widget _buildParkingImage() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.black,
        image: const DecorationImage(
          image: AssetImage("assets/images/parking.jpg"),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildDetailContainer({
    Widget? icon,
    String? label,
    double? width,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 40,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(color: darkblue, width: 3),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (icon != null) icon,
          Text(
            label!,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: darkblue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceContainer() {
    return Container(
      alignment: Alignment.center,
      height: 70,
      color: lightgreen,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            '\$${location!.price.toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: darkblue,
            ),
          ),
          Text(
            'per hour',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: red,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildMaterialButton(
          label: 'Cancel',
          backgroundColor: lightgreen,
          textColor: deepdarkblue,
          onPressed: () => Get.back(),
        ),
        _buildMaterialButton(
          label: 'Details',
          backgroundColor: deepdarkblue,
          textColor: lightgreen,
          onPressed: () => Get.to(SelectYourVehicleView(
            location: location,
          )),
        ),
      ],
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
      minWidth: 160,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
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
