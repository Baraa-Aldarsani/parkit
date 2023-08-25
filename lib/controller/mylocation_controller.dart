import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../model/mylocationModel.dart';

class MyLocationController extends GetxController {
  Rx<MyLocationModel?> locationModel =
      Rx<MyLocationModel>(MyLocationModel(latitude: 33, longitude: 33));

  void getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      MyLocationModel location = MyLocationModel(
        latitude: position.latitude,
        longitude: position.longitude,
      );

      locationModel.value = location;
    } catch (e) {
      print('حدث خطأ أثناء الحصول على الموقع: $e');
    }
  }
}
