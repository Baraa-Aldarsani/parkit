import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:parking/controller/auth/auth_controller.dart';

import '../../helper/constant.dart';
import '../widget/custom_text_from_filed.dart';

class ContinueView extends StatelessWidget {
  ContinueView(
      {Key? key,
      required this.emailController,
      required this.passwordController})
      : super(key: key);
  final AuthController _controller = Get.put(AuthController());
  final TextEditingController emailController;
  final TextEditingController passwordController;
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formstate,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 28,
                    ),
                  ),
                  const Text(
                    "File Your Profile",
                    style: TextStyle(
                      fontFamily: 'Playfair Display',
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
              Obx(
                () => SizedBox(
                  height: 200,
                  width: 320,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60, vertical: 12),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: ClipOval(
                        child: SizedBox(
                          width: 180,
                          height: 180,
                          child: _controller.image == null
                              ? InkWell(
                            onTap: (){
                              _controller.selectImage();
                            },
                                child: Container(
                                    width: 180,
                                    height: 180,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 2,
                                      ),
                                    ),
                                    child: Center(
                                      child: Icon(Icons.add,
                                          size: 100, color: deepdarkblue),
                                    ),
                                  ),
                              )
                              : Image.file(
                                  File(_controller.image!.path),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              CustomTextFromField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a name';
                  }
                  if (value.length < 3) {
                    return 'name should be at least 3 characters';
                  }
                  return null;
                },
                controller: _controller.nameController,
                hintText: "Name",
                icon: Icons.account_circle,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),
              CustomTextFromField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a nick name';
                  }
                  if (value.length < 3) {
                    return 'nick name should be at least 3 characters';
                  }
                  return null;
                },
                controller: _controller.nickNameController,
                hintText: "Nick Name",
                icon: Icons.account_circle,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),
              CustomTextFromField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                },
                controller: _controller.phoneController,
                hintText: "Phone Number",
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 12),
              CustomTextFromField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please select your date of birthday';
                  }
                },
                controller: _controller.dateController,
                hintText: "Date of Birth",
                icon: Icons.date_range,
                readOnly: true,
                onTap: () => _controller.selectDate(context),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Gender",
                    style: TextStyle(
                      color: deepdarkblue,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Playfair Display',
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text(
                        'Male',
                        style: TextStyle(
                          color: deepdarkblue,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Playfair Display',
                          fontSize: 20,
                        ),
                      ),
                      leading: Obx(() => Radio(
                            activeColor: deepdarkblue,
                            value: Gender.male,
                            groupValue: _controller.getSelectedGender(),
                            onChanged: (value) {
                              _controller.setSelectedGender(value!);
                            },
                          )),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(
                        'Female',
                        style: TextStyle(
                          color: deepdarkblue,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Playfair Display',
                          fontSize: 20,
                        ),
                      ),
                      leading: Obx(() => Radio(
                            activeColor: deepdarkblue,
                            value: Gender.female,
                            groupValue: _controller.getSelectedGender(),
                            onChanged: (value) {
                              _controller.setSelectedGender(value!);
                            },
                          )),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: deepdarkblue,
                  onPressed: () {
                    if (formstate.currentState!.validate() &&
                        _controller.image != null) {
                      File image = _controller.image!;
                      EasyLoading.show(
                          status: 'loading...',
                          maskType: EasyLoadingMaskType.black);
                      _controller.createaccount(
                          emailController, passwordController, image);
                      _controller.emailController.clear();
                      _controller.passwordController.clear();
                      _controller.phoneController.clear();
                      _controller.nameController.clear();
                      _controller.nickNameController.clear();
                      _controller.dateController.clear();
                      _controller.image == null;
                    }
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      color: lightgreen,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Playfair Display',
                      fontSize: 20,
                    ),
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
