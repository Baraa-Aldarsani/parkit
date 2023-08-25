// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking/controller/garage/location_controller.dart';

import '../controller/slider_controller.dart';
import '../controller/user/user_controller.dart';
import '../helper/constant.dart';
import '../model/archive_model.dart';

class ExtendParkingTime extends StatelessWidget {
  ExtendParkingTime({Key? key,required this.model1}) : super(key: key);
  final ArchiveModel1 model1;
  int duration = 0;
  final LocationController _controller = Get.put(LocationController());
  final SliderController slider = Get.put(SliderController());
  final UserController user = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
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
                  "Extend Parking Timer",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            const Text(
              "Add Duration",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child:  Obx(
                    () => Slider(
                        value: slider.valueSlider().toDouble(),
                        min: 0,
                        max: 6,
                        activeColor: darkblue,
                        divisions: 6,
                        onChanged: (double value) {
                          int hour = int.parse(model1.time_end.split(':')[0]);
                          slider.setAdd(value);
                          duration =  hour + value.toInt();
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
                        '${slider.valueSlider().toInt()} hrs',
                        style: TextStyle(fontSize: 18, color: red),
                      ),
                    ),
                ),

              ],
            ),
            const SizedBox(height: 25),
            const Text(
              "Total",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            Obx(
                  () => ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: Container(
                height: 80,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                color: lightgreen,
                child: Row(
                    children: [
                      Text(
                        "\$ ${slider.totalPrice(model1.price)}",
                        style: TextStyle(
                          fontSize: 27,
                          color: darkblue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "  /  ${slider.valueSlider().toInt()} hours",
                        style: TextStyle(color: red,fontSize: 16),
                      ),
                    ],
                ),
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
      label: 'Confirm Payment',
      backgroundColor: deepdarkblue,
      textColor: lightgreen,
      onPressed: () {
        if (slider.totalPrice(model1.price) == 0) {
          AwesomeDialog(
            context: Get.context!,
            dialogType: DialogType.info,
            animType: AnimType.rightSlide,
            title: 'Please Add Duration',
            desc: '',
            titleTextStyle: TextStyle(
                color: darkblue, fontSize: 20, fontWeight: FontWeight.bold),
            btnCancelColor: red,
            btnOkColor: deepdarkblue,
            btnCancelOnPress: () {},
            btnOkOnPress: () {},
          ).show();
        } else {
          if (user.user.value.wallet!.price >=
              slider.totalPrice(model1.price)) {
            _controller.addTimeReservation(model1, duration);
          }
          else {
            AwesomeDialog(
              context: Get.context!,
              dialogType: DialogType.info,
              animType: AnimType.rightSlide,
              title: 'Please top up your balance',
              desc: 'The wallet must be charged to be able to book a recipe',
              titleTextStyle: TextStyle(
                  color: darkblue, fontSize: 20, fontWeight: FontWeight.bold),
              btnCancelColor: red,
              btnOkColor: deepdarkblue,
              btnCancelOnPress: () {},
              btnOkOnPress: () {},
            ).show();
          }
        }
      }
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
