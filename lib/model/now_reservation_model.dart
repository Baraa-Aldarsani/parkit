import 'archive_model.dart';

class NowReservationModel {
  List<ArchiveModel1> model1;
  List<ArchiveModel2> model2;

  NowReservationModel({required this.model1, required this.model2});

  factory NowReservationModel.fromJson(Map<String, dynamic> json) {
    List<ArchiveModel1> mode1 = [];
    var ar1 = json['reservations'] as List<dynamic>;
    mode1 = ar1
        .map((parkingJson) => ArchiveModel1.fromJson(parkingJson))
        .toList();

    List<ArchiveModel2> mode2 = [];
    var ar2 = json['reservations2'] as List<dynamic>;
    mode2 = ar2
        .map((parkingJson) => ArchiveModel2.fromJson(parkingJson))
        .toList();

    return NowReservationModel(model1: mode1, model2: mode2);
  }
}