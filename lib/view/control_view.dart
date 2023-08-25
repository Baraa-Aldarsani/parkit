import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking/controller/control_controller.dart';
import '../helper/constant.dart';

class ControlView extends StatelessWidget {
  double? latitude;
  double? longitude;
  ControlView({Key? key,this.latitude,this.longitude}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControlController>(
      init: ControlController(),
      builder: (controller) => Scaffold(
        body: controller.currentScreen,
        bottomNavigationBar: bottomNavigationBar(),
      ),
    );
  }

  Widget bottomNavigationBar() {
    return GetBuilder<ControlController>(
      init: ControlController(),
      builder: (controller) => BottomNavigationBar(
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'Playfair Display',
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'Playfair Display',
        ),
        selectedFontSize: 13,
        unselectedFontSize: 13,
        backgroundColor: lightgreen,
        selectedItemColor: const Color(0xFF1D3557),
        unselectedItemColor: const Color(0xFFA5A5A5),
        type: BottomNavigationBarType.fixed,
        elevation: 4,
        items: const [
          BottomNavigationBarItem(
            label: "Map",
            icon: SizedBox(
              height: 40,
              child: Icon(
                Icons.location_on,
                size: 40,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: "Sessions",
            icon: SizedBox(
              height: 40,
              child: Icon(
                Icons.lock_clock,
                size: 40,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: "Vehcil",
            icon: SizedBox(
              height: 40,
              child: Icon(
                Icons.add,
                size: 40,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: "Servicecription",
            icon: SizedBox(
              height: 40,
              child: Icon(
                Icons.compare_arrows_sharp,
                size: 40,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: SizedBox(
              height: 40,
              child: Icon(
                Icons.person,
                size: 40,
              ),
            ),
          ),
        ],
        currentIndex: controller.navigationValue,
        onTap: (index) {
          controller.changeSelectedValue(index);
        },
      ),
    );
  }
}
