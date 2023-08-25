import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimerController extends GetxController {
  RxInt timerValue = 50.obs;
  int hours = 30;
  TimerController({required this.hours});

  @override
  void onInit() {
    timerValue.value = hours.toInt() * 3600;
    retrieveTimerValue();
    super.onInit();
  }

  @override
  void dispose() {
    saveTimerValue();
    super.dispose();
  }

  void saveTimerValue() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt('timerValue', timerValue.value);
  }

  void retrieveTimerValue() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int saveTimerValue = preferences.getInt('timerValue') ?? 0;
    timerValue.value = saveTimerValue;
    update();
  }
}
