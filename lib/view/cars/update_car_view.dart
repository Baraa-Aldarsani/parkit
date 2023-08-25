// ignore_for_file: unrelated_type_equality_checks

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking/view/cars/shap_car_view.dart';

import '../../controller/car/car_controller.dart';
import '../../helper/constant.dart';
import '../../model/car_model.dart';

class UpdateCarView extends StatelessWidget {
  UpdateCarView({Key? key, required this.car}) : super(key: key);
  final CarController _controller = Get.put(CarController());
  final CarModel car;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController =
        TextEditingController(text: car.name);
    TextEditingController numberController =
        TextEditingController(text: car.number.toString());
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
                    onPressed: () {
                      Get.back();
                      _controller.selectedImageIndex.value = -1;
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 35,
                    ),
                  ),
                  const Text(
                    "Update Car",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: nameController,
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
                controller: numberController,
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
                onTap: () {
                  Get.to(ShapCarView());
                },
                child: Card(
                  elevation: 7,
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
                            ? CachedNetworkImage(
                                imageUrl: car.imageCar,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                fit: BoxFit.cover,
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
                    String image = _controller.selectedImageIndex.value == -1
                        ? car.imageCar
                        : 'assets/cars/${_controller.shapCar[_controller.selectedImageIndex.value]}';
                    if (_formKey.currentState!.validate()) {
                    car.name = nameController.text;
                    car.number = int.parse(numberController.text);
                      await _controller.updateCar(car, image);
                      _controller.fetchCars();
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
