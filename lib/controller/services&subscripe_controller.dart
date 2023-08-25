import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/constant.dart';
import '../model/services&subscripe_model.dart';

class ServicesAndSubscripeController extends GetxController{
  RxInt selectedIndexButtons = 0.obs;
  List<String> text = [
    "My Services",
    "My Subscription",
  ];

  int get selectIndex => selectedIndexButtons.value;

  void changeColor(int index) {
    selectedIndexButtons.value = index;
    update();
  }

  Color getColorButtons(int index) {
    return selectedIndexButtons.value == index ? deepdarkblue : Colors.white;
  }
  Color getColorText(int index) {
    return selectedIndexButtons.value == index ? Colors.white : deepdarkblue;
  }
  FontWeight changeStyle(int index) {
    return selectedIndexButtons.value == index
        ? FontWeight.bold
        : FontWeight.normal;
  }

  var sessions = <ServicesAndSubscripeModel>[
    ServicesAndSubscripeModel(
        image: '',
        title: 'No Active sessions',
        subtitle: 'There are no active sessions registered on your account'),
    ServicesAndSubscripeModel(
        image: '',
        title: 'You have no history',
        subtitle:
        'There are no historic sessions registered on your account in the last 3 months.'),
  ].obs;
}