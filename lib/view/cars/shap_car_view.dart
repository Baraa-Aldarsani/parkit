import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking/controller/car/car_controller.dart';

class ShapCarView extends StatelessWidget {
  ShapCarView({Key? key}) : super(key: key);
  final CarController _controller = Get.put(CarController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 35),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 35,
                  ),
                ),
                const Text(
                  "shape of the vehicle",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
            Expanded(
              child: GridView.builder(
                physics: const ClampingScrollPhysics(),
                itemCount: 10,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 5,
                  childAspectRatio: 1.2,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Material(
                    elevation: 1.5,
                    borderRadius: index % 2 == 0
                        ? const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                          )
                        : const BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                          ),
                    child: InkWell(
                      onTap: (){
                        _controller.checkSelectImage.value = -1;
                        _controller.setSelectedImage(index);
                          Get.back();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: index % 2 == 0
                              ? const BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                )
                              : const BorderRadius.only(
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                ),
                        ),
                        child: Image.asset("assets/cars/${_controller.shapCar[index]}"),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
