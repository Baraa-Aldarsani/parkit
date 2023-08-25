import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:parking/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../helper/constant.dart';

class ApiServicesUser{
 static Future<UserModel> getUserInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token') ?? 0;
    final response = await http.get(Uri.parse('$baseUrl/get_user_info'),headers: {'Authorization' : 'Bearer $token'});
    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonData = json.decode(response.body);
      return UserModel.fromJson(jsonData,0,walletUser: true);
    } else {
      throw Exception('Failed to fetch user');
    }
  }

 static Future<UserModel> updateUserInfo(UserModel userModel,File imageFile) async {
   SharedPreferences preferences = await SharedPreferences.getInstance();
   final token = preferences.get('token') ?? 0;
   final url = '$baseUrl/update_user_info';
   final request = http.MultipartRequest('POST', Uri.parse(url));
   request.headers['Authorization'] = 'Bearer $token';
   request.fields['name'] = userModel.name!;
   request.fields['nickname'] = userModel.nickname!;
   request.fields['date_of_birthday'] = userModel.birth!;
   request.fields['phone_number'] = userModel.phone!;
   var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
   var length = await imageFile.length();
   var multipartFile = http.MultipartFile('image_link', stream, length,
       filename: 'image_link.png');
   request.files.add(multipartFile);
   try {
     final response = await request.send();
     print(response.statusCode);
     if (response.statusCode == 200 || response.statusCode == 201) {
       final responseData = await response.stream.bytesToString();
       final parsedData = jsonDecode(responseData);
       return UserModel.fromJson(parsedData,0);
     } else {
       throw Exception('Failed to update user Info');
     }
   } catch (e) {
     throw Exception('Error updating user: $e');
   }
 }
}