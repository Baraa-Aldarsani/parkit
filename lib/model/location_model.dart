// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking/model/qualities_model.dart';

import '../helper/constant.dart';
import 'floor_model.dart';
import 'services_mode.dart';

class LocationModel {
  final int id;
  final double latitude;
  final double longitude;
  final String name;
  final String street;
  int? availableSpots;
  int? saffah;
  final String description;
  final double price;
  late bool favorite;
  late Rx<Icon> favoriteIcon;
  final QualitiesModel qualities;
  int? is_open;
  final String time_open;
  final String time_close;
  List<Floor>? floor;
  String? city;
  String? country;
  List<ServiceModel>? services;
  LocationModel({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.street,
    required this.price,
    required this.saffah,
    required this.qualities,
    this.favorite = false,
    this.is_open,
   required this.time_open,
   required this.time_close,
    this.floor,
    this.city,
    this.country,
    this.services,
  }) {
    favoriteIcon = Rx<Icon>(
      Icon(
        favorite ? Icons.favorite : Icons.favorite_border_outlined,
        size: 35,
        color: favorite ? red : deepdarkblue,
      ),
    );
  }

  factory LocationModel.fromJson(Map<String, dynamic> json,int val, {bool includeFloor =  false,bool includeServices =  false}) {
    List<Floor> floor = [];
    List<ServiceModel> services = [];
    if (includeFloor) {
      var floorList = json['floors'] as List<dynamic>;
      floor = floorList.map((parkingJson) => Floor.fromJson(parkingJson)).toList();
    }
    if (includeServices) {
      var servicesList = json['services'] as List<dynamic>;
      services = servicesList.map((servicesJson) => ServiceModel.fromJson(servicesJson)).toList();
    }
    return LocationModel(

      id: json['id'],
      name: json['name'],
      latitude:val == 0 ? 0.0 : json['garage_location']['Latitude_lines'],
      longitude:val == 0 ? 0.0 :  json['garage_location']['Longitude_lines'],
      is_open :  json['is_open'],
      price: double.parse(json['price_per_hour'].toString()),
      time_open : json['time_open'],
      time_close : json['time_close'],
      description: json['garage_information'],
      floor: floor,
      street:val == 0 ? '' :  json['garage_location']['street'],
      saffah: 1,
      city: val == 0 ? '' : json['garage_location']['city'],
      country: val == 0 ? '' : json['garage_location']['country'],
      qualities: QualitiesModel(),
      favorite: false,
      services: services,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'availableSpots': availableSpots,
      'description': description,
      'street': street,
      'price': price,
      'saffah': saffah,
      'qualities': qualities.toJson(),
      'favorite': favorite,
    };
  }
}



