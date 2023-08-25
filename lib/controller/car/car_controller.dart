// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:parking/model/car_model.dart';
import 'api_services_car.dart';
import 'car_repository.dart';

class CarController extends GetxController {
  RxInt selectedCar = RxInt(-1);
  List<String> shapCar = [
    'car1.jpg',
    'car2.jpg',
    'car3.jpg',
    'car4.jpg',
    'car5.jpg',
    'car6.jpg',
    'car7.jpg',
    'car8.jpg',
    'car9.jpg',
    'car10.jpg',
  ];
  RxInt selectedImageIndex = RxInt(-1);
  RxInt checkSelectImage = RxInt(-1);
  final TextEditingController nameCar = TextEditingController();
  final TextEditingController numberCar = TextEditingController();

  void setSelectedImage(int index) {
    selectedImageIndex.value = index;
  }

  @override
  void onInit() {
    fetchCars();
  }
  var cars = <CarModel>[].obs;

  void updateSelectedCar(int id) {
    selectedCar.value = id;
    update();

    for (int i = 0; i < cars.length; i++) {
      if (cars[i].id == id) {
        cars[i].isSelected = true;
      } else {
        cars[i].isSelected = false;
      }
    }
  }

  CarModel? car;

  Future<void> addCar() async {
    final nameCars = nameCar.text;
    final numberCars = numberCar.text;
    final image = 'assets/cars/${shapCar[selectedImageIndex.value]}';
    try {
      car = await ApiServicesCar.addCarServe(nameCars, numberCars, image);
      nameCar.clear();
      numberCar.clear();
      selectedImageIndex.value = -1;
      EasyLoading.showSuccess('done...',
          maskType: EasyLoadingMaskType.black,
          duration: const Duration(milliseconds: 500));
      Get.back();
    } catch (e) {
      if (car != null) print("asdasd");
      print("Exeception$e");
      EasyLoading.showError(
        "Wrong add car",
        maskType: EasyLoadingMaskType.black,
      );
    }
  }
  Future<void> deleteCar(int carId) async {
    try {
      await ApiServicesCar.deleteCarServe(carId);
      cars.removeWhere((car) => car.id == carId);
      update();
      Get.back();
      Get.back();
    } catch (e) {
      print('Error deleting car: $e');
    }
  }

  Future<void> updateCar(CarModel car,String image) async{
    try{
      await ApiServicesCar.updateCarServe(car,image);
      final updatedIndex = cars.indexWhere((oldCar) => oldCar.id == car.id);
      if (updatedIndex != -1) {
        cars[updatedIndex] = car;
      }
      update();
      Get.back();
      Get.back();
      selectedImageIndex.value = -1;
    }catch(e){
      print('Error updating car: $e');
    }
  }

  Future<void> fetchCars() async {
    try {
      final List<CarModel> fetchedCars = await CarRepository.getAllCars();
      cars.assignAll(fetchedCars);
    } catch (e) {
      print(e.toString());
    }
  }


}
