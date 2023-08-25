import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:parking/controller/user/user_controller.dart';
import 'package:parking/model/user_model.dart';
import '../../helper/constant.dart';
import '../widget/custom_text_from_filed.dart';

class UpdateProfileView extends StatelessWidget {
  UpdateProfileView({Key? key,required this.user}) : super(key: key);
  final UserController _controller = Get.put(UserController());
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController(text: user.name);
    TextEditingController nickname = TextEditingController(text: user.nickname);
    TextEditingController phone = TextEditingController(text: user.phone);
    DateTime birthDate = DateTime.parse(user.birth!);
    String formattedDate = DateFormat('yyyy-MM-dd').format(birthDate);
    _controller.dateController = TextEditingController(text: formattedDate);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Obx(
          () =>  Column(
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
              SizedBox(
                height: 200,
                width: 320,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 12),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: ClipOval(
                          child: SizedBox(
                            width: 180,
                            height: 180,
                            child: _controller.image == null
                                ? CachedNetworkImage(
                              imageUrl: '${user.picture}',
                              placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                              fit: BoxFit.cover,
                            )
                                : Image.file(
                              File(_controller.image!.path),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 15,
                        right: 15,
                        child: Container(
                          width: 30,
                          decoration: BoxDecoration(
                            color: darkblue,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          child: InkWell(
                            child: Icon(
                              Icons.edit,
                              color: deepdarkblue,
                            ),
                            onTap: () {
                              _controller.selectImage();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              CustomTextFromField(
                controller: name,
                hintText: "Name",
                icon: Icons.account_circle,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),
              CustomTextFromField(
                controller: nickname,
                hintText: "Nick Name",
                icon: Icons.account_circle,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),
              CustomTextFromField(
                controller: phone,
                hintText: "Phone Number",
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 12),
              CustomTextFromField(
                controller: _controller.dateController,
                hintText: "Date of Birth",
                icon: Icons.date_range,
                readOnly: true,
                onTap: () => _controller.selectDate(context),
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
                  onPressed: () async{
                    user.name = name.text;
                    user.nickname = nickname.text;
                    user.phone = phone.text;
                    user.birth = DateFormat('yyyy-MM-dd').format(_controller.selectedDate.value);
                    File image = _controller.image == null ? File(user.picture!) : _controller.image!;
                    // print(image.path);
                    await _controller.updateInfo(user,image);
                    _controller.fetchUser();
                  },
                  child: Text(
                    "Save",
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
