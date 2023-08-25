// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:intl/intl.dart';

import '../../helper/constant.dart';
import '../../model/user_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<UserModel> signInWithEmailAndPassword(
      String email, String password) async {
    final url = '$baseUrl/user-login';
    final body = jsonEncode({'email': email, 'password': password});
    final headers = {'Content-Type': 'application/json'};
    final response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      return UserModel.fromJson(responseData, 1);
    } else {
      throw Exception('حدث خطأ أثناء تسجيل الدخول');
    }
  }

  static Future<UserModel> createaccount(
    String name,
    String nickName,
    String email,
    String password,
    String phone,
    String gender,
    String birth,
    File imageFile,
  ) async {
    final url = '$baseUrl/user-new-account';
    DateTime birthday = DateTime.parse(birth);
    String formatbirthday = DateFormat('yyyy-MM-dd').format(birthday);
    String genderFormat = gender.split('.').last;
    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields['name'] = name;
    request.fields['nickname'] = nickName;
    request.fields['date_of_birthday'] = formatbirthday;
    request.fields['phone_number'] = phone;
    request.fields['gender'] = genderFormat;
    request.fields['email'] = email;
    request.fields['password'] = password;
    var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var multipartFile = http.MultipartFile('image_link', stream, length,
        filename: 'image_link.png');
    request.files.add(multipartFile);
    final response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = await response.stream.bytesToString();
      final parsedData = jsonDecode(responseData);
      return UserModel.fromJson(parsedData, 1);
    } else {
      throw Exception('حدث خطأ أثناء إنشاء حساب');
    }
  }
}
