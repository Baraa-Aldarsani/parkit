import 'package:parking/model/qualities_model.dart';

import 'location_model.dart';
import 'parking_model.dart';

class Floor {
  final int id;
  final int number;
  List<Parking>? parkings;
  LocationModel? locationModel;

  Floor({
    required this.id,
    required this.number,
    this.parkings,
    this.locationModel,
  });

  factory Floor.fromJson(Map<String, dynamic> json,
      {bool includePark = true, includeLocation = false}) {
    List<Parking> parkings = [];
    LocationModel location = LocationModel(
        id: 0,
        name: '',
        latitude: 0.0,
        longitude: 0.0,
        description: '',
        street: '',
        price: 0.0,
        saffah: 0,
        qualities: QualitiesModel(),
        time_open: '',
        time_close: '');
    if (includePark) {
      var parkingsList = json['parkings'] as List<dynamic>;
      parkings = parkingsList
          .map((parkingJson) => Parking.fromJson(parkingJson))
          .toList();
    }
    if(includeLocation){
      location = LocationModel.fromJson(json['garages'], 0);
    }
    return Floor(
      id: json['id'],
      number: json['number'],
      parkings: parkings,
      locationModel : location,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> parkingsJson =
        parkings?.map((parking) => parking.toJson()).toList() ?? [];

    return {
      'id': id,
      'number': number,
      'parkings': parkingsJson,
    };
  }
}
