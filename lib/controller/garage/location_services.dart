// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:parking/model/archive_model.dart';
import 'package:parking/model/favorite_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/constant.dart';
import '../../model/location_model.dart';
import '../date_time_controller.dart';

class LocationService {
  static Future<List<LocationModel>> fetchLocationsAvail() async {
    final response =
        await http.get(Uri.parse('$baseUrl/availableAndNonAvailabelGarages'));
    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> data =
          json.decode(response.body)['available_garages'];
      return data
          .map<LocationModel>(
              (json) => LocationModel.fromJson(json, 1, includeFloor: true))
          .toList();
    } else {
      throw Exception('Failed to load locations');
    }
  }

  static Future<List<LocationModel>> fetchLocationsNonAvail() async {
    final response =
        await http.get(Uri.parse('$baseUrl/availableAndNonAvailabelGarages'));
    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> data =
          json.decode(response.body)['non_available_garages'];
      return data
          .map<LocationModel>(
              (json) => LocationModel.fromJson(json, 1, includeFloor: true))
          .toList();
    } else {
      throw Exception('Failed to load locations');
    }
  }

  static Future<List<FavoriteModel>> getFavorite() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final id = preferences.get('ID') ?? 0;
    final response = await http.get(Uri.parse('$baseUrl/$id/favorite_garages'));
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> data = json.decode(response.body)['favorite_garages'];
      return data
          .map<FavoriteModel>((json) => FavoriteModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load locations');
    }
  }

  static Future addFavorite(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token') ?? 0;
    final response = await http.post(
      Uri.parse('$baseUrl/garages/addToFavorites'),
      body: {'garage_id': id.toString()},
      headers: {'Authorization': 'Bearer $token'},
    );
    print("add : ${response.statusCode}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Success add Favorite Garage");
    } else {
      throw Exception('Failed to add Favorite Garage');
    }
  }

  static Future removeFavorite(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token') ?? 0;
    final response = await http.post(
      Uri.parse('$baseUrl/garages/removeFromFavorites'),
      body: {'garage_id': id.toString()},
      headers: {'Authorization': 'Bearer $token'},
    );
    print("Remove : ${response.statusCode}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Success remove Favorite Garage");
    } else {
      throw Exception('Failed to remove Favorite Garage');
    }
  }

  static Future addReservationUser(LocationModel location, int carId,
      int parkingId, int floorId, List time) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token') ?? 0;
    final DateTimeController controller = Get.put(DateTimeController());
    String formattedDate =
        DateFormat('yyyy-MM-dd').format(controller.selectedDate.value!);
    // print('${time[0]}:${time[1]}');
    // print('${time[3]}:${time[4]}');
    // print(formattedDate);
    // print(parkingId);
    // print(floorId);
    // print(location.id);
    // print(carId);
    String begin = '${time[0]}:${time[1]}';
    String end = '${time[3]}:${time[4]}';
    final response = await http.post(
      Uri.parse('$baseUrl/reserve-parking'),
      body: {
        'time_begin': begin,
        'time_end': end,
        'date': formattedDate,
        'parking_id': parkingId.toString(),
        'floor_id': floorId.toString(),
        'garage_id': location.id.toString(),
        'car_id': carId.toString(),
      },
      headers: {'Authorization': 'Bearer $token'},
    );
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Success add reservation for user");
    } else {
      throw Exception('Failed to add reservation');
    }
  }

  static Future<void> addTime(ArchiveModel1 model, int hour) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token') ?? 0;
    String timeEnd = '$hour:${model.time_end.split(':')[1]}';
    String timeBegin =
        '${model.time_begin.split(':')[0]}:${model.time_begin.split(':')[1]}';
    print(timeBegin);
    print(timeEnd);
    print(model.date);

    final response = await http.post(
      Uri.parse('$baseUrl/edit-reserve-parking/${model.id}'),
      body: {'time_begin': timeBegin, 'time_end': timeEnd, 'date': model.date},
      headers: {'Authorization': 'Bearer $token'},
    );
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Success add Time reservation for user");
    } else {
      throw Exception('Failed to add Time reservation');
    }
  }
}
