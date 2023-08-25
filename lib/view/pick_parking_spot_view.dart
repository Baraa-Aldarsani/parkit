// ignore_for_file: invalid_use_of_protected_member, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking/controller/garage/location_controller.dart';
import 'package:parking/view/review_summary_view.dart';

import '../helper/constant.dart';
import '../model/car_model.dart';
import '../model/location_model.dart';

class PickParkingSpotView extends StatelessWidget {
  final LocationModel? location;
  final LocationController _controller = Get.put(LocationController());
  final CarModel? car;
  final int duration;
  List time;
  final int day;
  final String mounth;
  final int year;
  final List parkingSpot = <String>['', ''];
  final int carId;

  PickParkingSpotView({
    Key? key,
    this.location,
    this.car,
    required this.duration,
    required this.time,
    required this.day,
    required this.mounth,
    required this.year,
    required this.carId,
  }) : super(key: key);
  int parkingId = -1;
  int floorId = 1;

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
                  onPressed: () {
                    Get.back();
                    _controller.selectedQualities.value = -1;
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 35,
                  ),
                ),
                const Text(
                  "Pick Parking Spot",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 45,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: location!.floor!.length,
                itemBuilder: (BuildContext context, int index) {
                  parkingSpot[0] = _controller.updateFloor.toString();
                  return Obx(
                    () => InkWell(
                      onTap: () {
                        _controller.selectedQualities.value = -1;
                        _controller.changeColor(index);
                        _controller.increase(index);
                        parkingSpot[0] = _controller.updateFloor.toString();
                        floorId = location!.floor![index].id;
                      },
                      child: Container(
                        width: 122,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1.6, color: darkblue),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30),
                          ),
                          color: _controller.getColorButtons(index),
                        ),
                        child: Text(
                          "${location!.floor![index].number} Floor",
                          style: TextStyle(
                            color: _controller.getColorText(index),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  width: 12,
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                return GridView.builder(
                    physics: const ClampingScrollPhysics(),
                    itemCount: location!
                        .floor![_controller.updateFloor - 1].parkings!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 70,
                            mainAxisSpacing: 33,
                            childAspectRatio: 1.8),
                    itemBuilder: (BuildContext context, int index) {
                      final parking = location!
                          .floor![_controller.updateFloor - 1].parkings![index];
                      return Container(
                        decoration: ShapeDecoration(
                          shape: index % 2 == 0
                              ? const Border(
                                  top: BorderSide(
                                      width: 1.2, color: Colors.grey),
                                  left: BorderSide(
                                      width: 1.2, color: Colors.grey),
                                  bottom: BorderSide(
                                      width: 1.2, color: Colors.grey),
                                )
                              : const Border(
                                  top: BorderSide(
                                      width: 1.2, color: Colors.grey),
                                  right: BorderSide(
                                      width: 1.2, color: Colors.grey),
                                  bottom: BorderSide(
                                      width: 1.2, color: Colors.grey),
                                ),
                        ),
                        alignment: Alignment.center,
                        child: parking.status!.name == 'available'
                            ? InkWell(
                                onTap: () {
                                  _controller.changeQualities(index);
                                  parkingSpot[1] = parking.number;
                                  parkingId = parking.id;
                                },
                                child: Obx(() =>
                                    _controller.getStatusQualities1(
                                        index, parking.number)),
                              )
                            : parking.status!.name == 'busy'
                                ? Image.asset("assets/cars/carWhite.jpg")
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 200,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 2, color: darkblue),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(25)),
                                          color: lightgreen),
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            parking.number,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Icon(
                                            Icons.lock,
                                            color: deepdarkblue,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                      );
                    });
              }),
            ),
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
        onPressed: () {
          if ((parkingId == -1) || (_controller.selectedQualities.value == -1)) {
            print(parkingId);
          } else {
            Get.to(ReviewSummaryView(
              location: location,
              car: car,
              duration: duration,
              time: time,
              day: day,
              mounth: mounth,
              year: year,
              parkingSport: parkingSpot,
              carId: carId,
              parkingId: parkingId,
              floorId: floorId,
            ));
          }
        });
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
