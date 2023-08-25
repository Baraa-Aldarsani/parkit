import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/constant.dart';
import '../../model/car_model.dart';

class CarRepository {
 static Future<List<CarModel>> getAllCars() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token') ?? 0;
    final response = await http.get(Uri.parse('$baseUrl/get_user_cars'),headers: {'Authorization' : 'Bearer $token'});
    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> jsonData = json.decode(response.body)['user_cars'];
      return jsonData.map((carJson) => CarModel.fromJson(carJson,bar: true)).toList();
    } else {
      throw Exception('Failed to fetch cars');
    }
  }
}