import 'floor_model.dart';

class GarageModel {
  final int id;
  final String name;
  final String email;
  final int floorNumber;
  final int isOpen;
  final double pricePerHour;
  final int parksNumber;
  final String timeOpen;
  final String timeClose;
  final String garageInformation;
  List<Floor>? floors;

  GarageModel({
    required this.id,
    required this.name,
    required this.email,
    required this.floorNumber,
    required this.isOpen,
    required this.pricePerHour,
    required this.parksNumber,
    required this.timeOpen,
    required this.timeClose,
    required this.garageInformation,
    this.floors,
  });

  factory GarageModel.fromJson(Map<String, dynamic> json,{bool includeFloor = true}) {

    List<Floor> floors = [];
    if(includeFloor) {
      var floorsList = json['floors'] as List<dynamic>;
      List<Floor> floors = floorsList.map((floorJson) =>
          Floor.fromJson(floorJson)).toList();
    }

    return GarageModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      floorNumber: json['floor_number'],
      isOpen: json['is_open'],
      pricePerHour: double.parse(json['price_per_hour'].toString()),
      parksNumber: json['parks_number'],
      timeOpen: json['time_open'],
      timeClose: json['time_close'],
      garageInformation: json['garage_information'],
      floors: floors,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> floorsJson = floors?.map((floor) => floor.toJson()).toList() ?? [];

    return {
      'id': id,
      'name': name,
      'email': email,
      'floor_number': floorNumber,
      'is_open': isOpen,
      'price_per_hour': pricePerHour,
      'parks_number': parksNumber,
      'time_open': timeOpen,
      'time_close': timeClose,
      'garage_information': garageInformation,
      'floors': floorsJson,
    };
  }

}
