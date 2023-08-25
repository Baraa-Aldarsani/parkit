import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:parking/helper/constant.dart';
import 'package:parking/model/locale_model.dart';
import 'package:parking/view/auth/sign-in_view.dart';
import 'package:parking/view/control_view.dart';
import 'package:parking/view/get_started_screen_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controller/locale_controller.dart';
import 'helper/binding.dart';

SharedPreferences? sharedpref;
late bool checkStart;
late bool checkLogin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedpref = await SharedPreferences.getInstance();
  var value = sharedpref!.getString("pref");
  if (value != null) {
    checkStart = false;
  } else {
    checkStart = true;
  }
  var val = sharedpref!.getString(CHARED_DATA_STORAGE);
  if (val != null) {
    checkLogin = false;
  } else {
    checkLogin = true;
  }
  runApp(DevicePreview(builder: (context) => const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    LocaleController controllerlang = Get.put(LocaleController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: Binding(),
      locale: controllerlang.initlang,
      builder: (context, myWidget) {
        myWidget = EasyLoading.init()(context, myWidget);
        myWidget = DevicePreview.appBuilder(context, myWidget);
        return myWidget;
      },
      translations: LocaleModel(),
      home: checkStart
          ? const Scaffold(
              body: GetStartedScreenView(),
            )
          : checkLogin
              ? Scaffold(
                  body: SignInView(),
                )
              : Scaffold(
                  body: ControlView(),
                ),
    );
  }
}
