import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:parking/controller/garage/location_controller.dart';
import 'package:parking/helper/constant.dart';
import 'package:parking/view/pick_parking_spot_view.dart';
import 'package:table_calendar/table_calendar.dart';
import '../controller/date_time_controller.dart';
import '../controller/slider_controller.dart';
import '../model/car_model.dart';
import '../model/location_model.dart';

class BookParkingDetails extends StatelessWidget {
  final LocationModel? location;
  final CarModel? car;
  int duration = 3;
  List time = ['','','','','',''];
  int day = 0;
  String mounth = '';
  int year = 0;
  final int carId;
  BookParkingDetails({Key? key, this.location, this.car,required this.carId}) : super(key: key);
  final DateTimeController controllerTime = Get.put(DateTimeController());
  final LocationController _controller = Get.put(LocationController());
  @override
  Widget build(BuildContext context) {
    final SliderController controllerSlider = Get.put(SliderController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 35),
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
                  "Book Parking Details",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            const Text(
              "Select Date",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            GetBuilder(
                init: DateTimeController(),
                builder: (controller) {
                  day = controller.day;
                  mounth = controller.mounth;
                  year = controller.year;
                  return Container(
                    decoration: BoxDecoration(
                      color: lightgreen,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          15,
                        ),
                      ),
                    ),
                    child: TableCalendar(
                      firstDay: DateTime(2022),
                      lastDay: DateTime(2040),
                      focusedDay: DateTime.now(),
                      selectedDayPredicate: (date) {
                        day = controller.selectedDate.value!.day;
                        mounth = DateFormat('MMMM')
                            .format(controller.selectedDate.value!);
                        year = controller.selectedDate.value!.year;
                        return isSameDay(date, controller.selectedDate.value);
                      },
                      onDaySelected: controller.onDateSelected,
                    ),
                  );
                }),
            const SizedBox(height: 15),
            const Text(
              "Duration",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 7),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Obx(
                    () => Slider(
                      value: controllerTime.valueSlider().toDouble(),
                      min: 0,
                      max: 6,
                      activeColor: darkblue,
                      divisions: 6,
                      onChanged: (double value) {
                        controllerSlider.setValue(value);
                        int hour = value.toInt();
                        int minute = 0;
                        controllerTime.updateSlider(hour, minute);
                        duration = hour;
                      },
                    ),
                  ),
                ),
                Obx(
                  () => AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    width: 40,
                    alignment: Alignment.center,
                    child: Text(
                      '${controllerTime.valueSlider()} hrs',
                      style: TextStyle(fontSize: 18, color: red),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Start Hour",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 70),
                  child: Text(
                    "End Hour",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () {
                    time[0] = controllerTime.hour1;
                    time[1] = controllerTime.minute1;
                    time[2] = controllerTime.getAMorPM1();
                    return GestureDetector(
                      onTap: () async {
                        await controllerTime.updateTime1();
                        time[0] = controllerTime.hour1;
                        time[1] = controllerTime.minute1;
                        time[2] = controllerTime.getAMorPM1();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 170,
                        height: 40,
                        decoration: BoxDecoration(
                          color: lightgreen,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                                "${controllerTime.hour1}:${controllerTime.minute1} ${controllerTime.getAMorPM1()}"),
                            const Icon(Icons.watch_later_outlined),
                          ],
                        ),
                      ),
                    );
                  }
                ),
                const Icon(Icons.arrow_right_alt_outlined),
                Obx(
                  () {
                    time[3] = controllerTime.hour2;
                    time[4] = controllerTime.minute2;
                    time[5] = controllerTime.getAMorPM2();
                    return GestureDetector(
                      onTap: () async {
                        await controllerTime.updateTime2();
                        time[3] = controllerTime.hour2;
                        time[4] = controllerTime.minute2;
                        time[5] = controllerTime.getAMorPM2();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 170,
                        height: 40,
                        decoration: BoxDecoration(
                          color: lightgreen,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                                "${controllerTime.hour2}:${controllerTime.minute2} ${controllerTime.getAMorPM2()}"),
                            const Icon(Icons.watch_later_outlined)
                          ],
                        ),
                      ),
                    );
                  }
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Total",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Obx(
              () => Container(
                height: 60,
                padding: EdgeInsets.symmetric(horizontal: 15),
                color: lightgreen,
                child: Row(
                  children: [
                    Text(
                      "\$${_controller.totalPrice(location!.price)}",
                      style: TextStyle(
                        fontSize: 23,
                        color: darkblue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      " / ${controllerTime.differenceHour} hours - ${controllerTime.differenceMinute} minute",
                      style: TextStyle(color: red),
                    ),
                  ],
                ),
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
      label: 'Continue',
      backgroundColor: deepdarkblue,
      textColor: lightgreen,
      onPressed: () => Get.to(PickParkingSpotView(
        location: location,
        car: car,
        duration: duration,
        time: time,
        day: day,
        mounth: mounth,
        year: year,
        carId: carId,
      )),
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
