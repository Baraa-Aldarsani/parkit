// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:parking/model/car_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../helper/constant.dart';

class ApiServicesCar {
  static Future<CarModel> addCarServe(
      String nameCar, String numberCar, String selectedCarImage) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token') ?? 0;
    const url = '$baseUrl/add_user_car';
    final request = http.MultipartRequest('POST', Uri.parse(url));
    final bytes = await rootBundle.load(selectedCarImage);
    final Uint8List byteList = bytes.buffer.asUint8List();
    final multipartFile =
        http.MultipartFile.fromBytes('image', byteList, filename: 'image.png');
    request.headers['Authorization'] = 'Bearer $token';
    request.fields['name'] = nameCar;
    request.fields['number'] = numberCar;
    request.files.add(multipartFile);
    try {
      final response = await request.send();
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = await response.stream.bytesToString();
        final parsedData = jsonDecode(responseData);
        return CarModel(
          id: 0,
          imageCar: '',
          name: '',
          number: 0,
          isSelected: false,
        );
      } else {
        throw Exception('Failed to add car');
      }
    } catch (e) {
      throw Exception('Error uploading car: $e');
    }
  }

  static Future<void> deleteCarServe(int carId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token') ?? 0;
    // print("ID : ${carId}");
    // print("token : ${token}");
    final url = '$baseUrl/delete_user_car/$carId';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Accept': "application/json", 'Authorization': 'Bearer $token'},
    );
    // print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Car deleted successfully');
    } else {
      throw Exception('Failed to delete car');
    }
  }

  static Future<void> updateCarServe(CarModel car, String image) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token') ?? 0;
    final url = '$baseUrl/update_user_car/${car.id}';
      final request = http.MultipartRequest('POST', Uri.parse(url));
      final bytes = await rootBundle.load(image);
      final Uint8List byteList = bytes.buffer.asUint8List();
      final multipartFile = http.MultipartFile.fromBytes('image', byteList,
          filename: 'image.png');
      request.headers['Authorization'] = 'Bearer $token';
      request.fields['name'] = car.name;
      request.fields['number'] = car.number.toString();
      request.files.add(multipartFile);
      final response = await request.send();
      // print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Car updated successfully');
      } else {
        throw Exception('Failed to update car');
      }
  }
}
