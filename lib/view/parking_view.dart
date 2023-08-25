import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking/view/details_parking_view.dart';

import '../controller/garage/location_controller.dart';
import '../helper/constant.dart';
import '../model/location_model.dart';

class ParkingDetailScreen extends StatelessWidget {
  final LocationModel location;
  final LocationController _controller = Get.put(LocationController());

  ParkingDetailScreen({Key? key, required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 5),
          _buildDivider(),
          const SizedBox(height: 30),
          const Text(
            "Details",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildParkingImage(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Parking Lot of ${location.name}",
                              style: const TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              location.street,
                              style: const TextStyle(fontSize: 18.0),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            _controller.toggleFavorite(location.name,location.id);
                          },
                          icon: Obx(
                            () => location.favoriteIcon.value,
                          ),
                        ),
                      ],
                    ),
                    _buildButtons(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 5,
      width: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: grey,
      ),
    );
  }

  Widget _buildParkingImage() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.black,
        image: const DecorationImage(
          image: AssetImage("assets/images/parking.jpg"),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MaterialButton(
          height: 50,
          minWidth: 160,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: lightgreen),
          ),
          color: lightgreen,
          onPressed: () {
            Get.back();
          },
          child: Text(
            "Cancel",
            style: TextStyle(
              color: deepdarkblue,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        MaterialButton(
          height: 50,
          minWidth: 160,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: darkblue),
          ),
          color: deepdarkblue,
          onPressed: () {
            Get.to(DetailsParkingView(
              location: location,
            ));
          },
          child: Row(
            children: [
              Text(
                "Details",
                style: TextStyle(
                  color: lightgreen,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10),
              Icon(
                Icons.arrow_right_alt_outlined,
                color: lightgreen,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
