import 'dart:convert';
import 'package:parking/model/reservation_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../helper/constant.dart';
import '../../model/now_reservation_model.dart';

class ApiReservation{
    static Future<ReservationModel> getAllReservation() async{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final id = preferences.get('ID') ?? 0;
      final response =
      await http.get(Uri.parse('$baseUrl/getArchivedReservationsForUser/$id'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ReservationModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load data');
      }
    }

    static Future<NowReservationModel> getNowReservation() async{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final id = preferences.get('ID') ?? 0;
      final response =
      await http.get(Uri.parse('$baseUrl/show-reservation-parking/$id'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return NowReservationModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load data');
      }
    }
    static Future<void> deleteRes(int id) async{
      final response = await http.post(Uri.parse('$baseUrl/delete-reserve-parking/$id'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Success Delete Reservation");
      } else {
        throw Exception('Failed to delete reservation');
      }
    }
}