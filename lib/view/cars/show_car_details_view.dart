import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking/controller/car/car_controller.dart';
import 'package:parking/helper/constant.dart';
import 'package:parking/model/car_model.dart';
import 'package:parking/view/cars/update_car_view.dart';

import '../../controller/bottomSheet_controller.dart';

class ShowCarDetailsView extends StatelessWidget {
  ShowCarDetailsView({Key? key, required this.car}) : super(key: key);
  final CarModel car;
  final bottomSheet = Get.put(BottomSheetController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(
                  Icons.arrow_back,
                  size: 35,
                ),
              ),
              const Text(
                "Details Car",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              IconButton(
                  onPressed: () {
                    Get.to(UpdateCarView(car: car,));
                  },
                  icon: const Icon(
                    Icons.edit,
                    size: 35,
                  ))
            ],
          ),
          const SizedBox(height: 30.0),
          Card(
            elevation: 7,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
            ),
            child: Container(
              height: 250,
              width: 400,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(3)),
              ),
              child: CachedNetworkImage(
                imageUrl: car.imageCar,
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Card(
            elevation: 7,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
            ),
            child: Container(
              alignment: Alignment.center,
              height: 50,
              width: 400,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(3)),
              ),
              child: Text(
                "Name : ${car.name}",
                style: TextStyle(fontSize: 20, color: deepdarkblue),
              ),
            ),
          ),
          Card(
            elevation: 7,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
            ),
            child: Container(
              alignment: Alignment.center,
              height: 50,
              width: 400,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(3)),
              ),
              child: Text(
                "Number : ${car.number}",
                style: TextStyle(fontSize: 20, color: deepdarkblue),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 350,
            height: 150,
        child: CachedNetworkImage(
          imageUrl: car.barCode!,
          placeholder: (context, url) => const Text(""),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          fit: BoxFit.contain,
        ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 50,
            width: 250,
            decoration: BoxDecoration(
                color: red,
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            child: MaterialButton(
              onPressed: () async{
               // await _controller.deleteCar(car.id);
                bottomSheet.deleteCars(car.id);
              },
              child: const Text(
                "Delete This Car",
                style: TextStyle(
                    fontSize: 23,
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
