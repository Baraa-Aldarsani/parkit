import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:parking/view/cars/show_car_details_view.dart';

import '../../controller/car/car_controller.dart';
import '../../helper/constant.dart';
import 'add_car_view.dart';

class VehicleView extends StatelessWidget {
  final CarController carsController = Get.put(CarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Parkit",
            style: TextStyle(
              fontFamily: 'Billabong',
              color: deepdarkblue,
              fontSize: 50,
              fontWeight: FontWeight.w500,
              height: 2,
            ),
          ),
          elevation: 1.5,
          backgroundColor: lightgreen,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu,
              color: deepdarkblue,
              size: 45,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                onPressed: () {
                  Get.to(AddCarScreen());
                },
                icon: Icon(
                  Icons.add,
                  color: deepdarkblue,
                  size: 45,
                ),
              ),
            ),
          ],
        ),
        body: FutureBuilder<void>(
          future: carsController.fetchCars(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Text("");
            } else {
              return Obx(
                () => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                  child: ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    itemCount: carsController.cars.length,
                    itemBuilder: (BuildContext context, int index) {
                      final car = carsController.cars[index];
                      return Card(
                        elevation: 3,
                        child: GestureDetector(
                          onTap: () {
                            Get.to(ShowCarDetailsView(car: car));
                          },
                          child: SizedBox(
                            height: 80,
                            child: ListTile(
                              leading: Container(
                                width: 90,
                                height: 80,
                                padding: const EdgeInsets.only(top: 10),
                                child: CachedNetworkImage(
                                  imageUrl: car.imageCar,
                                  placeholder: (context, url) =>
                                      const Icon(Icons.question_mark),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  car.name,
                                  style: TextStyle(
                                      fontSize: 23,
                                      color: deepdarkblue,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text("${car.number}",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: darkblue,
                                      fontWeight: FontWeight.w400),),
                              ),
                              trailing:
                                  Icon(Icons.arrow_forward, color: deepdarkblue,size: 35),

                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }
          },
        ));
  }
}
