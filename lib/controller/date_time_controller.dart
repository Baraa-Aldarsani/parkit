import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:intl/intl.dart';
import '../helper/constant.dart';

class DateTimeController extends GetxController {
  final selectedDate = Rx<DateTime?>(DateTime.now());
  static final Rx<DateTime> _dateTime1 = DateTime.now().obs;
  static final Rx<DateTime> _dateTime2 =
      DateTime.now().add(const Duration(hours: 3)).obs;

  Duration difference = _dateTime2.value.difference(_dateTime1.value);

  int get differenceHour {
    Duration difference = _dateTime2.value.difference(_dateTime1.value);
    return difference.inHours;
  }

  int get differenceMinute {
    Duration difference = _dateTime2.value.difference(_dateTime1.value);
    return difference.inMinutes % 60;
  }

  int get day => selectedDate.value!.day;

  String get mounth => DateFormat('MMMM').format(selectedDate.value!);

  int get year => selectedDate.value!.year;

  DateTime get dateTime1 => _dateTime1.value;

  set dateTime1(DateTime value) => _dateTime1.value = value;

  String get hour1 => '${dateTime1.hour}'.padLeft(2, '0');

  String get minute1 => '${dateTime1.minute}'.padLeft(2, '0');

  DateTime get dateTime2 => _dateTime2.value;

  set dateTime2(DateTime value) => _dateTime2.value = value;

  String get hour2 => '${dateTime2.hour}'.padLeft(2, '0');

  String get minute2 => '${dateTime2.minute}'.padLeft(2, '0');

  RxBool showErrorDialog = false.obs;

  String get hours => '${dateTime2.hour - dateTime1.hour}'.padLeft(2, '0');

  String get minutes =>
      '${dateTime2.minute - dateTime1.minute}'.padLeft(2, '0');

  void onDateSelected(DateTime date, _) {
    selectedDate.value = date;
    update();
  }

  Future<void> updateTime1() async {
    TimeOfDay? newTime = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.fromDateTime(_dateTime1.value),
    );
    if (newTime == null) return;
    dateTime1 = DateTime(
      dateTime1.year,
      dateTime1.month,
      dateTime1.day,
      newTime.hour,
      newTime.minute,
    );
    update();
  }

  String getAMorPM1() {
    final hour = dateTime1.hour;
    if (hour >= 12 && hour <= 24) {
      return "PM";
    } else {
      return "AM";
    }
  }

  Future<void> updateTime2() async {
    TimeOfDay? newTime = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.fromDateTime(_dateTime2.value),
    );
    if (newTime == null) return;
    dateTime2 = DateTime(
      dateTime2.year,
      dateTime2.month,
      dateTime2.day,
      newTime.hour,
      newTime.minute,
    );
    update();
    int value = dateTime2.hour - dateTime1.hour;
    if (!(value >= 0 && value <= 6)) {
      return AwesomeDialog(
        context: Get.context!,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Timing error',
        desc: 'Booking cannot exceed 6 hours',
        btnCancelColor: red,
        btnOkColor: deepdarkblue,
        btnCancelOnPress: () {},
        btnOkOnPress: () {},
      ).show();
    }
  }

  String getAMorPM2() {
    final hour = dateTime2.hour;
    if (hour >= 12 && hour <= 24) {
      return "PM";
    } else {
      return "AM";
    }
  }

  void updateSlider(int hour, int minute) {
    dateTime2 = DateTime(
      dateTime2.year,
      dateTime2.month,
      dateTime2.day,
      dateTime1.hour + hour,
      dateTime1.minute + minute,
    );
    update();
  }

  int valueSlider() {
    int value = dateTime2.hour - dateTime1.hour;
    if (dateTime2.isAfter(dateTime1) || dateTime2 == dateTime1) {
      value = dateTime2.hour - dateTime1.hour;
    } else if (dateTime2.isBefore(dateTime1)) {
      value = (dateTime2.hour + 24) - dateTime1.hour;
    }
    if (value >= 0 && value <= 6) {
      showErrorDialog = false.obs;
      return value;
    } else {
      showErrorDialog = true.obs;
      return 0;
    }
  }

  void hideErrorDialog() {
    showErrorDialog = false.obs;
  }
}
