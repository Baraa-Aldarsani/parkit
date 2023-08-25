import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../helper/constant.dart';
import '../../model/location_model.dart';
import '../../model/required_services_model.dart';

class ApiServices {
  static Future<LocationModel> getAllServices(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token') ?? 0;
    final response = await http.get(
        Uri.parse('$baseUrl/showGarageServices/$id'),
        headers: {'Authorization': 'Bearer $token'});
    // print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> jsonData =
          json.decode(response.body)['garageServices'];
      return LocationModel.fromJson(jsonData, 0, includeServices: true);
    } else {
      throw Exception('Failed to fetch Services Garage');
    }
  }

  static Future<List<RequiredServicesModel>> getServicesUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token') ?? 0;
    final response = await http.get(Uri.parse('$baseUrl/get_required_services'),
        headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> data =
          json.decode(response.body)['required_services'];
      return data
          .map<RequiredServicesModel>((json) => RequiredServicesModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to fetch Services User');
    }
  }

  static Future<void> pushServices(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token') ?? 0;
    final response = await http.post(
      Uri.parse('$baseUrl/users/request-services'),
      body: {'service_id': id.toString()},
      headers: {'Authorization': 'Bearer $token'},
    );
    // print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Success");
    } else {
      throw Exception('Failed to request Service');
    }
  }
}
