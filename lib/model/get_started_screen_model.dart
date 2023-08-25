import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking/helper/constant.dart';

class GetStartedScreenModel {
  final RxList<Color> colors = [
    deepdarkblue,
    Colors.grey,
    Colors.grey,
  ].obs;
  final RxList<Widget> title = [
    const Text(
      "Find Parking Places Around You Easily",
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 36,
          fontFamily: 'Playfair Display'),
      textAlign: TextAlign.center,
    ),
    const Text(
      "Book and Pay Parking Quickly & Safely",
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 36,
          fontFamily: 'Playfair Display'),
      textAlign: TextAlign.center,
    ),
    const Text(
      "Extend Parking Time As You Need",
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 36,
          fontFamily: 'Playfair Display'),
      textAlign: TextAlign.center,
    ),
  ].obs;
  final RxList<Widget> image = [
    Image.asset(
      "assets/onBoarding/undraw_tourist_map_re_293e.png",
      height: 300,
    ),
    Image.asset(
      "assets/onBoarding/undraw_Transfer_money_re_6o1h.png",
      height: 300,
    ),
    Image.asset(
      "assets/onBoarding/undraw_season_change_f99v.png",
      height: 300,
    ),
  ].obs;
}
