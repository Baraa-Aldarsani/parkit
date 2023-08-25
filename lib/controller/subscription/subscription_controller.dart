// ignore_for_file: avoid_print, deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';
import 'package:parking/model/subscription_garage_model.dart';
import 'ApiServicesSub.dart';

class SubscriptionController extends GetxController {
  Map<String, dynamic> data = {};
  var subscription = <SubscriptionGarageModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      data = await ApiService.getAllData();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchSubscription(int id) async {
    try {
      final List<SubscriptionGarageModel> fetchSub =
          await ApiService.getSubscription(id);
      subscription.assignAll(fetchSub);
      update();
    } catch (e) {
      print("Error fetching Subscription for Garage $e");
    }
  }

  Future<void> addSubscription(int id, int number, String type) async {
    try {
      await ApiService.addSubscription(id, number, type);
      AwesomeDialog(
        context: Get.context!,
        dialogType: DialogType.SUCCES,
        animType: AnimType.SCALE,
        title: 'Subscription Added!',
        desc: 'You have successfully subscribed to the garage.',
        btnOkText: 'Okay',
        btnOkOnPress: () {},
      ).show();
    } catch (e) {
      print("$e");
    }
  }
}
