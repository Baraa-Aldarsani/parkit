import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:intl/intl.dart';
import 'package:parking/helper/constant.dart';
import '../model/archive_model.dart';
import 'extend_parking_time_view.dart';

class ParkingTimer extends StatelessWidget {
  const ParkingTimer(
      {Key? key,
      required this.model1,
      required this.model2,
      required this.hours})
      : super(key: key);

  final ArchiveModel1 model1;
  final ArchiveModel2 model2;
  final double hours;
  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.parse(model1.date);
    String monthName = DateFormat('MMMM').format(date);
    String day = model1.date.split('-')[2].toString();
    String year = model1.date.split('-')[0].toString();
    String timeStart = model1.time_begin;
    DateFormat dateFormatStart = DateFormat.jm();
    DateTime time = DateFormat("HH:mm:ss").parse(timeStart);
    String formattedStart = dateFormatStart.format(time);
    String timeEnd = model1.time_end;
    DateFormat dateFormatEnd = DateFormat.jm();
    DateTime time1 = DateFormat("HH:mm:ss").parse(timeEnd);
    String formattedEnd = dateFormatEnd.format(time1);
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
                  "Parking Timer",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
         CircularCountDownTimer(
                duration: hours.toInt() * 3600,
                initialDuration: 0,
                controller: CountDownController(),
                width: MediaQuery.of(context).size.width / 1.5,
                height: MediaQuery.of(context).size.height / 2.7,
                ringColor: Colors.grey.shade200,
                ringGradient: null,
                fillColor: deepdarkblue,
                fillGradient: null,
                backgroundColor: Colors.white,
                backgroundGradient: null,
                strokeWidth: 20.0,
                strokeCap: StrokeCap.round,
                textStyle: const TextStyle(
                  fontSize: 50.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textFormat: CountdownTextFormat.HH_MM_SS,
                isReverse: true,
                isReverseAnimation: true,
                isTimerTextShown: true,
                autoStart: true,
                onStart: () {},
                onComplete: () {},
                onChange: (String timeStamp) {},
              ),
            const SizedBox(height: 15),
            Container(
              height: 365,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: BoxDecoration(
                color: lightgreen,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Parking Area :",
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      Text(
                        "Parking lot of ${model2.parking.floor!.locationModel!.name}",
                        style: TextStyle(
                            color: deepdarkblue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
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
                            fontSize: 16),
                      ),
                      Text(
                        "${model1.car.name} (${model1.car.number})",
                        style: TextStyle(
                            color: deepdarkblue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
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
                            fontSize: 16),
                      ),
                      Text(
                        "${model2.parking.floor!.number} Floor (${model2.parking.number})",
                        style: TextStyle(
                            color: deepdarkblue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
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
                            fontSize: 16),
                      ),
                      Text(
                        "$monthName $day / $year",
                        style: TextStyle(
                            color: deepdarkblue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
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
                            fontSize: 16),
                      ),
                      Text(
                        "${hours.toInt()} hours ",
                        style: TextStyle(
                            color: deepdarkblue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
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
                            fontSize: 16),
                      ),
                      Text(
                        "$formattedStart - $formattedEnd",
                        style: TextStyle(
                            color: deepdarkblue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
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
      label: 'Extend Parking Time',
      backgroundColor: deepdarkblue,
      textColor: lightgreen,
      onPressed: () {
        Get.to(ExtendParkingTime(model1: model1,));
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
