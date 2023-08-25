import 'floor_model.dart';
import 'parking_status_mode.dart';

class Parking {
  final int id;
  final String number;
  final int floorsId;
  final int statusId;
  ParkingStatus? status;
  Floor? floor;

  Parking({
    required this.id,
    required this.number,
    required this.floorsId,
    required this.statusId,
    this.status,
    this.floor,
  });

  factory Parking.fromJson(Map<String, dynamic> json,{bool status = true,bool floorStatus = false}) {
    ParkingStatus parkingStatus = ParkingStatus(id: 0, name: '');
    Floor floor = Floor(id: 0, number: 0);
    if(status){
      parkingStatus = ParkingStatus.fromJson(json['status']);
    }
    if(floorStatus){
      floor = Floor.fromJson(json['floors'],includeLocation: true,includePark: false);
    }

    return Parking(
      id: json['id'],
      number: json['number'],
      floorsId: json['floors_id'],
      statusId: json['status_id'],
      status: parkingStatus,
      floor: floor,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'number': number,
      'floors_id': floorsId,
      'status_id': statusId,
      'status': status?.toJson(),
    };
  }
}
