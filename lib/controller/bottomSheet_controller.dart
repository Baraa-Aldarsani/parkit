import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking/controller/reservation_controller/reservation_controller.dart';

import '../helper/constant.dart';
import '../helper/local_storage_data.dart';
import '../view/auth/sign-in_view.dart';
import 'car/car_controller.dart';

class BottomSheetController extends GetxController {
  void logout() {
    Get.bottomSheet(
      Logout(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
  void deleteCars(int id) {
    Get.bottomSheet(
      DeleteCars(id: id),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void deleteReservation(int id) {
    Get.bottomSheet(
      DeleteReservation(id: id),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
}

class Logout extends StatelessWidget {
  Logout({Key? key}) : super(key: key);
  final LocalStorageData localStorageData = Get.put(LocalStorageData());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
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
          Text(
            "Logout",
            style: TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, color: red),
          ),
          const SizedBox(height: 30),
          Text(
            "Are you sure you want to log out?",
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: deepdarkblue),
          ),
          const SizedBox(height: 30),
          _buildButtons(
              label: 'Yes, Logout',
              backgroundColor: deepdarkblue,
              textColor: lightgreen,
              onPressed: () {
                localStorageData.deleteUser();
                Get.offAll(SignInView());
              }),
          const SizedBox(height: 20),
          _buildButtons(
              label: 'Cancel',
              backgroundColor: lightgreen,
              textColor: deepdarkblue,
              onPressed: () {
                Get.back();
              }),
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

  Widget _buildButtons(
      {required String label,
      required Color backgroundColor,
      required Color textColor,
      required VoidCallback onPressed}) {
    return _buildMaterialButton(
        label: label,
        backgroundColor: backgroundColor,
        textColor: textColor,
        onPressed: onPressed);
  }

  Widget _buildMaterialButton({
    required String label,
    required Color backgroundColor,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: MaterialButton(
        height: 60,
        minWidth: double.infinity,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(color: backgroundColor),
        ),
        color: backgroundColor,
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class DeleteCars extends StatelessWidget {
  DeleteCars({Key? key,required this.id}) : super(key: key);
  final CarController _controller = Get.put(CarController());
  final int id;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
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
          Text(
            "Delete Car",
            style: TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, color: red),
          ),
          const SizedBox(height: 30),
          Text(
            "Are you sure you want to delete car?",
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: deepdarkblue),
          ),
          const SizedBox(height: 30),
          _buildButtons(
              label: 'Yes, I am sure',
              backgroundColor: deepdarkblue,
              textColor: lightgreen,
              onPressed: () async{
                await _controller.deleteCar(id);
              }),
          const SizedBox(height: 20),
          _buildButtons(
              label: 'Cancel',
              backgroundColor: lightgreen,
              textColor: deepdarkblue,
              onPressed: () {
                Get.back();
              }),
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

  Widget _buildButtons(
      {required String label,
        required Color backgroundColor,
        required Color textColor,
        required VoidCallback onPressed}) {
    return _buildMaterialButton(
        label: label,
        backgroundColor: backgroundColor,
        textColor: textColor,
        onPressed: onPressed);
  }

  Widget _buildMaterialButton({
    required String label,
    required Color backgroundColor,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: MaterialButton(
        height: 60,
        minWidth: double.infinity,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(color: backgroundColor),
        ),
        color: backgroundColor,
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class DeleteReservation extends StatelessWidget {
  DeleteReservation({Key? key,required this.id}) : super(key: key);
  final int id;
  final ReservationController _controller = Get.put(ReservationController());
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
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
          Text(
            "Delete Reservation",
            style: TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, color: red),
          ),
          const SizedBox(height: 30),
          Text(
            "Are you sure you want to delete reservation?",
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: deepdarkblue),
          ),
          const SizedBox(height: 30),
          _buildButtons(
              label: 'Yes, I am sure',
              backgroundColor: deepdarkblue,
              textColor: lightgreen,
              onPressed: () async{
                await _controller.deleteReservation(id);
              }),
          const SizedBox(height: 20),
          _buildButtons(
              label: 'Cancel',
              backgroundColor: lightgreen,
              textColor: deepdarkblue,
              onPressed: () {
                Get.back();
              }),
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

  Widget _buildButtons(
      {required String label,
        required Color backgroundColor,
        required Color textColor,
        required VoidCallback onPressed}) {
    return _buildMaterialButton(
        label: label,
        backgroundColor: backgroundColor,
        textColor: textColor,
        onPressed: onPressed);
  }

  Widget _buildMaterialButton({
    required String label,
    required Color backgroundColor,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: MaterialButton(
        height: 60,
        minWidth: double.infinity,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(color: backgroundColor),
        ),
        color: backgroundColor,
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
