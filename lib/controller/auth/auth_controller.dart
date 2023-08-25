import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:parking/controller/auth/api_services.dart';
import 'package:parking/view/control_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../helper/constant.dart';
import '../../helper/local_storage_data.dart';
import '../../model/user_model.dart';

enum Gender { male, female }

class AuthController extends GetxController {
  final LocalStorageData localStorageData = Get.put(LocalStorageData());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nickNameController = TextEditingController();

  TextEditingController get email => emailController;

  TextEditingController get password => passwordController;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  Rx<Gender> selectedGender = Gender.male.obs;

  Future<void> signInWithEmailAndPassword() async {
    final email = emailController.text;
    final password = passwordController.text;
    try {
      final UserModel user =
          await ApiService.signInWithEmailAndPassword(email, password);
      EasyLoading.showSuccess('done...',
          maskType: EasyLoadingMaskType.black,
          duration: const Duration(milliseconds: 500));
      setUser(user);
      _saveToken(user.token.toString());
      _saveID(user.userId.toString());
      Get.offAll(ControlView());
    } catch (e) {
      print(e.toString());
      EasyLoading.showError(
        "Wrong login",
        maskType: EasyLoadingMaskType.black,
      );
    }
  }

  void setUser(UserModel userModel) async {
    await localStorageData.setUser(userModel);
  }

  void createaccount(TextEditingController emailController,
      TextEditingController passwordController,File selectimage) async {
    final name = nameController.text;
    final nickName = nickNameController.text;
    final email = emailController.text;
    final password = passwordController.text;
    final phone = phoneController.text;
    final gender = selectedGender.toString();
    final birth = selectedDate.toString();
    final File image = selectimage;
    try {
      final UserModel user = await ApiService.createaccount(
          name, nickName, email, password, phone, gender, birth,image);
      EasyLoading.showSuccess('done...',
          maskType: EasyLoadingMaskType.black,
          duration: const Duration(milliseconds: 500));
      setUser(user);
      _saveToken(user.token.toString());
      _saveID(user.userId.toString());
      // print(user.token);
      Get.offAll(ControlView());
    } catch (e) {
      print(e.toString());
      EasyLoading.showError(
        "Wrong register",
        maskType: EasyLoadingMaskType.black,
      );
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

  void setSelectedGender(Gender gender) {
    selectedGender.value = gender;
  }

  Gender getSelectedGender() {
    return selectedGender.value;
  }

  bool isValidEmail(String email) {
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(emailPattern);
    return regExp.hasMatch(email);
  }
  final Rx<File?> _image = Rx<File?>(null);
  File? get image => _image.value;


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
  _saveToken(String token) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    const key = 'token';
    final value = token;
    preferences.setString(key, value);
  }

  read() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    const key = 'token';
    final value = preferences.getString(key) ?? 0;
  }
  _saveID(String id) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    const key = 'ID';
    final value = id;
    preferences.setString(key, value);
  }

  readID() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    const key = 'ID';
    final value = preferences.getString(key) ?? 0;
  }
}
