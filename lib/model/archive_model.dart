// ignore_for_file: non_constant_identifier_names

import 'package:parking/model/car_model.dart';
import 'package:parking/model/user_model.dart';

import 'parking_model.dart';

class ArchiveModel1 {
  final int id;
  final String date;
  final String time_begin;
  final String time_end;
  final String time_reservation;
  final double price;
  final double pay;
  final UserModel user;
  final CarModel car;
  final String barcode;

  ArchiveModel1({
    required this.id,
    required this.date,
    required this.time_begin,
    required this.time_end,
    required this.time_reservation,
    required this.price,
    required this.pay,
    required this.user,
    required this.car,
    required this.barcode,
  });

  factory ArchiveModel1.fromJson(Map<String, dynamic> json) {
    return ArchiveModel1(
      id: json['id'],
      date: json['date'],
      time_begin: json['time_begin'],
      time_end: json['time_end'],
      time_reservation: json['time_reservation'],
      price: double.parse(json['price'].toString()),
      pay: double.parse(json['pay'].toString()),
      user: UserModel.fromJson(json['user'], 0,noUser: false),
      car: CarModel.fromJson(json['cars'], bar: true),
      barcode: json['barcode'],
    );
  }
}

class ArchiveModel2 {
  final Parking parking;

  ArchiveModel2({required this.parking});

  factory ArchiveModel2.fromJson(Map<String, dynamic> json) {
    return ArchiveModel2(
        parking: Parking.fromJson(json['parkings'],
            status: false, floorStatus: true));
  }
}
