// ignore_for_file: deprecated_member_use, avoid_print

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../helper/constant.dart';
import '../../model/location_model.dart';
import '../../model/required_services_model.dart';
import '../../view/services/services_for_garage_view.dart';
import '../user/user_controller.dart';
import 'api_services.dart';

class ServicesController extends GetxController {
  var allServices = <LocationModel>[].obs;
  var services = <RequiredServicesModel>[].obs;
  final UserController user = Get.put(UserController());

  @override
  void onInit() {
    super.onInit();
    getServicesForUser();
  }
  void orderConfirmation(int id,double price) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: const Icon(Icons.car_rental_sharp, size: 70),
          title: const Text('Are you sure about ordering the service?'),
          content: const Text(
            'If you confirm the request, an amount of money will be deducted from your wallet in exchange for the service',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: ()  {
                requestServices(id,price);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> getServicesForGarage(int id) async {
    try {
      final LocationModel fetchedServices =
          await ApiServices.getAllServices(id);
      allServices.value = [fetchedServices];
      Get.to(ServicesForGarageView());
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getServicesForUser() async {
    try {
      final fetchServices = await ApiServices.getServicesUser();
      services.assignAll(fetchServices);
      print(services.length);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> requestServices(int id, double price) async {
    try {
      if (user.user.value.wallet!.price >= price) {
        await ApiServices.pushServices(id);
        AwesomeDialog(
          context: Get.context!,
          dialogType: DialogType.SUCCES,
          animType: AnimType.SCALE,
          title: 'Services Added!',
          desc: 'You have successfully service to the garage.',
          btnOkText: 'Okay',
          btnOkOnPress: () {},
        ).show();
        print("Success Request Service");
      } else {
        AwesomeDialog(
          context: Get.context!,
          dialogType: DialogType.info,
          animType: AnimType.rightSlide,
          title: 'Please top up your balance',
          desc: 'The wallet must be charged to be able to request service',
          titleTextStyle: TextStyle(
              color: darkblue, fontSize: 20, fontWeight: FontWeight.bold),
          btnCancelColor: red,
          btnOkColor: deepdarkblue,
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
        ).show();
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
