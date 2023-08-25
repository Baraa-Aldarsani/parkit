import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking/main.dart';

class LocaleController extends GetxController {
  Locale initlang =
      sharedpref!.getString("lang") == "Arabic" ? const Locale("ar") : const Locale("en");

  void changeLanguage(String codelang) {
    Locale currentlang = Locale(codelang);
    sharedpref!.setString("lang", codelang);
    Get.updateLocale(currentlang);
  }
}
