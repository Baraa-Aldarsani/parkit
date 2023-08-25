import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/constant.dart';
import '../../model/subscription_garage_model.dart';

class ApiService {
  static Future<Map<String, dynamic>> getAllData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final id = preferences.get('ID') ?? 0;
    final response =
        await http.get(Uri.parse('$baseUrl/user-subscriptions/$id'));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<List<SubscriptionGarageModel>> getSubscription(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token') ?? 0;
    final response = await http.get(
        Uri.parse('$baseUrl/showGarageSubscriptions/$id'),
        headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> data =
          json.decode(response.body)['garage_subscriptions'];
      return data
          .map<SubscriptionGarageModel>(
              (json) => SubscriptionGarageModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load data Subscription Garage');
    }
  }

  static Future<void> addSubscription(int id, int number, String type) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token') ?? 0;
    final response = await http
        .post(Uri.parse('$baseUrl/subscriptions_with_garage'), headers: {
      'Authorization': 'Bearer $token'
    }, body: {
      'garage_id': id.toString(),
      'subscription_type': type,
      'number_of_months': number.toString(),
    });
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Success Add Subscription");
    } else {
      throw Exception("Failed add subscription");
    }
  }
}
