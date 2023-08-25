import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking/helper/constant.dart';
import 'package:parking/view/auth/sign-in_view.dart';
import 'package:parking/view/control_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/get_started_screen_controller.dart';

class GetStartedScreenView extends StatelessWidget {
  const GetStartedScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GetStartedScreenController controller = GetStartedScreenController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Obx(
              () {
                if (controller.currentStep.value == 0) {
                  return controller.model.image[0];
                } else if (controller.currentStep.value == 1) {
                  return controller.model.image[1];
                } else {
                  return controller.model.image[2];
                }
              },
            ),
          ),
          Obx(
            () {
              if (controller.currentStep.value == 0) {
                return controller.model.title[0];
              } else if (controller.currentStep.value == 1) {
                return controller.model.title[1];
              } else {
                return controller.model.title[2];
              }
            },
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: const Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor inididunt ut labore et dolore mangna aliqua",
              textAlign: TextAlign.center,
              style: TextStyle(
                  // fontSize:36,
                  fontFamily: 'Playfair Display'),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 5,
                  backgroundColor: controller.model.colors[0],
                ),
                const SizedBox(
                  width: 16,
                ),
                CircleAvatar(
                  radius: 5,
                  backgroundColor: controller.model.colors[1],
                ),
                const SizedBox(
                  width: 16,
                ),
                CircleAvatar(
                  radius: 5,
                  backgroundColor: controller.model.colors[2],
                ),
              ],
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: SizedBox(
                width: double.infinity,
                height: 45,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: deepdarkblue,
                  onPressed: () {
                    controller.goToNextStep();
                  },
                  child: Text(
                    "Next",
                    style: TextStyle(
                      color: grey,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Playfair Display',
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: SizedBox(
                width: double.infinity,
                height: 45,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: lightgreen,
                  onPressed: () async{
                    SharedPreferences pref = await SharedPreferences.getInstance();
                    pref.setString("pref", "checkPref");
                    Get.to(SignInView());
                  },
                  child: Text(
                    "Skip",
                    style: TextStyle(
                      color: deepdarkblue,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Playfair Display',
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
