import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:parking/controller/date_time_controller.dart';
import 'package:parking/model/location_model.dart';

import '../controller/garage/location_controller.dart';
import '../helper/constant.dart';
import '../model/car_model.dart';

class ReviewSummaryView extends StatelessWidget {
  final LocationModel? location;
  final CarModel? car;
  final int duration;
  List time;
  final int day;
  final String mounth;
  final int year;
  final List parkingSport;
  final int carId;
  final int parkingId;
  final int floorId;
  ReviewSummaryView({
    Key? key,
    this.location,
    this.car,
    required this.duration,
    required this.time,
    required this.day,
    required this.mounth,
    required this.year,
    required this.parkingSport,
    required this.carId,
    required this.parkingId,
    required this.floorId,
  }) : super(key: key);
  final LocationController _controller = Get.put(LocationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 35),
        child: Column(
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
                  "Review Summary",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 420,
              decoration: BoxDecoration(
                color: lightgreen,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Parking Area :",
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Text(
                        "Parking lot of ${location!.name}",
                        style: TextStyle(
                            color: deepdarkblue,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Address :",
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Text(
                        "${location!.street}",
                        style: TextStyle(
                            color: deepdarkblue,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Vehicle :",
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Text(
                        "${car!.name} (${car!.number})",
                        style: TextStyle(
                            color: deepdarkblue,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Parking Spot :",
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Text(
                        "${parkingSport[0]} Floor (${parkingSport[1]})",
                        style: TextStyle(
                            color: deepdarkblue,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Date :",
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Text(
                        "$mounth $day, $year",
                        style: TextStyle(
                            color: deepdarkblue,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Duration :",
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Text(
                        "$duration hours ",
                        style: TextStyle(
                            color: deepdarkblue,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Hours :",
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Text(
                        "${time[0]}:${time[1]} ${time[2]} - ${time[3]}:${time[4]} ${time[5]}",
                        style: TextStyle(
                            color: deepdarkblue,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 200,
              decoration: BoxDecoration(
                color: lightgreen,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Amount :",
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Text(
                        "\$ ${_controller.totalPrice(location!.price)}",
                        style: TextStyle(
                            color: deepdarkblue,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Taxes & Fees (10%) :",
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Text(
                        "\$ ${_controller.totalPrice(location!.price) / 10}",
                        style: TextStyle(
                            color: deepdarkblue,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1.5,
                    color: red,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total :",
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Text(
                        "\$ ${_controller.totalPrice(location!.price) + _controller.totalPrice(location!.price) / 10}",
                        style: TextStyle(
                          color: deepdarkblue,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: lightgreen,
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Text(
                "An amount of \$${_controller.totalPrice(location!.price) + _controller.totalPrice(location!.price) / 10} will be deducted from your wallet",
                style: TextStyle(
                  color: red,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
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
      label: 'Confirm Payment',
      backgroundColor: deepdarkblue,
      textColor: lightgreen,
      onPressed: () async {
        _controller.checkPayment(
            location!, car!, duration, time, day, mounth, year,parkingSport,carId,parkingId,floorId);
      },
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
