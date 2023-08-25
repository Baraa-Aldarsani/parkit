import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';
import 'constant.dart';

class LocalStorageData extends GetxController {
  Future<UserModel?> get getUser async {
    try {
      UserModel userModel = await getUserData();
      print(userModel.token);
      if (userModel == null) return null;
      return userModel;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  getUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var value = preferences.getString(CHARED_DATA_STORAGE);
    return UserModel.fromJson(json.decode(value!),1);
  }

  setUser(UserModel userModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(
        CHARED_DATA_STORAGE, jsonEncode(userModel.toJson()));
  }

  void deleteUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.getString(CHARED_DATA_STORAGE);
    await preferences.remove(CHARED_DATA_STORAGE);
  }
}
