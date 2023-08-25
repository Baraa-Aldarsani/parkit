// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking/view/cars/shap_car_view.dart';
import '../../controller/car/car_controller.dart';
import '../../helper/constant.dart';

class AddCarScreen extends StatelessWidget {
  AddCarScreen({super.key});

  final CarController _controller = Get.put(CarController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 35),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () async{
                      Get.back();
                      await Future.delayed(const Duration(microseconds: 10));
                      _controller.selectedImageIndex.value = -1;
                      _controller.checkSelectImage.value = -1;
                      _controller.nameCar.clear();
                      _controller.numberCar.clear();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 35,
                    ),
                  ),
                  const Text(
                    "Add Car",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _controller.nameCar,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'please enter name car';
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Car Name',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                    borderSide: BorderSide(color: deepdarkblue),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'please enter number car';
                  }
                },
                controller: _controller.numberCar,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                    borderSide: BorderSide(color: deepdarkblue),
                  ),
                  labelText: 'Car Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              InkWell(
                onTap: () async {
                  await Get.to(ShapCarView());
                },
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Obx(
                    () => Container(
                        height: 300,
                        width: 400,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(3)),
                        ),
                        child: _controller.selectedImageIndex == -1
                            ? Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _controller.checkSelectImage.value == -1
                                      ? Icon(
                                          Icons.add,
                                          color: darkblue,
                                          size: 100,
                                        )
                                      : Icon(
                                          Icons.close,
                                          color: red,
                                          size: 100,
                                        ),
                                  Text(
                                    "Select the type of vehicle",
                                    style: TextStyle(
                                      color:
                                          _controller.checkSelectImage.value ==
                                                  -1
                                              ? darkblue
                                              : red,
                                      fontSize: 25,
                                    ),
                                  ),
                                ],
                              )
                            : Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/cars/${_controller.shapCar[_controller.selectedImageIndex.value]}"),
                                    fit: BoxFit.contain,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              )),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              SizedBox(
                height: 50,
                width: 300,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate() &&
                        _controller.selectedImageIndex != -1) {
                      await _controller.addCar();
                      _controller.fetchCars();
                    }
                    if(_controller.selectedImageIndex == -1) {
                      _controller.checkSelectImage.value = 1;
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: deepdarkblue,
                    alignment: Alignment.center,
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
