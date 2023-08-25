import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:parking/controller/user/api_services_user.dart';
import 'package:parking/helper/constant.dart';
import 'package:parking/model/user_model.dart';
import 'package:image_picker/image_picker.dart';

class UserController extends GetxController {
  var user = UserModel().obs;
  TextEditingController dateController = TextEditingController();
  Rx<DateTime> selectedDate = DateTime.now().obs;
  final Rx<File?> _image = Rx<File?>(null);
  File? get image => _image.value;

  @override
  void onInit() {
    fetchUser();
  }

  Future<void> fetchUser() async {
    try {
      final UserModel fetchedUser = await ApiServicesUser.getUserInfo();
      user.value = fetchedUser;
    } catch (e) {
      print('Error fetching user: $e');
    }
  }

  void selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(1930),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
      String formattedDate =
          DateFormat('yyyy-MM-dd').format(selectedDate.value);
      dateController.text = formattedDate;
    }
  }

  Future pickImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: source);
    if (pickedImage != null) {
      _image.value = File(pickedImage.path);
      update();
    }
    else {
      print("Error");
    }
  }

  void selectImage() {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: const Center(
            child: Text(
              "Select Image Source",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: ()async {
                  await pickImage(ImageSource.camera);
                  Get.back();
                },
                child: ListTile(
                  leading: Icon(
                    Icons.camera_enhance,
                    size: 30,
                    color: darkblue,
                  ),
                  title: const Text(
                    "From Camera",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const Divider(thickness: 2,),
              InkWell(
                onTap: ()async {
                  await pickImage(ImageSource.gallery);
                  Get.back();
                },
                child: ListTile(
                  leading: Icon(
                    Icons.camera,
                    size: 30,
                    color: darkblue,
                  ),
                  title: const Text(
                    "From Gallery",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                'OK',
                style: TextStyle(
                  color: darkblue,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> updateInfo(UserModel userModel,File image) async{
    try{
      await ApiServicesUser.updateUserInfo(userModel,image);
      update();
      Get.back();
    }catch(e){
      print('Error updating user Info: $e');
    }
  }

}
