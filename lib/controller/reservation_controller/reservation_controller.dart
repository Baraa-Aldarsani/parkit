import 'package:get/get.dart';
import 'package:parking/model/archive_model.dart';
import 'package:parking/model/car_model.dart';
import 'package:parking/model/parking_model.dart';
import 'package:parking/model/user_model.dart';
import '../../model/now_reservation_model.dart';
import '../../model/reservation_model.dart';
import 'ApiReservation.dart';

class ReservationController extends GetxController {
  var reservationNow = NowReservationModel(
          model1: [],
          model2: [])
      .obs;
  var reservationData = ReservationModel(model1: [], model2: []).obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
    getNowReservation();
  }

  Future<void> fetchData() async {
    try {
      final data = await ApiReservation.getAllReservation();
      reservationData.value = data;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getNowReservation() async {
    try {
      final data = await ApiReservation.getNowReservation();
      reservationNow.value = data;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteReservation(int id) async {
    try {
      await ApiReservation.deleteRes(id);
      Get.back();
    } catch (e) {
      print(e.toString());
    }
  }
}
