import 'package:get/get.dart';
import 'package:parking/helper/constant.dart';
import 'package:parking/view/control_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/get_started_screen_model.dart';
import '../view/auth/sign-in_view.dart';

class GetStartedScreenController extends GetxController {
  final GetStartedScreenModel model = GetStartedScreenModel();
  final currentStep = 0.obs;

  void goToNextStep() async {
    if (currentStep.value < model.colors.length - 1) {
      currentStep.value++;
      model.colors[currentStep.value] = deepdarkblue;
    } else {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("pref", "checkPref");
      Get.to(SignInView());
    }
  }
}
