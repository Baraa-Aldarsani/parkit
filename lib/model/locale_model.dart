import 'package:get/get.dart';

class LocaleModel implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "ar": {
          "1": "خرائط",
          "2" : "عربي",
          "3" : "انكليزي",
          "4" : "إعدادات",

        },
        "en": {
          "1": "Map",
          "2" : "Arabic",
          "3" : "English",
          "4" : "Settings",
        }
      };
}
