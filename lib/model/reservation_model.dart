import 'archive_model.dart';

class ReservationModel {
  List<ArchiveModel1> model1;
  List<ArchiveModel2> model2;

  ReservationModel({required this.model1, required this.model2});

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    var archive1List1 = json['archived_reservations'] as List<dynamic>;
    List<ArchiveModel1> archive1 =
        archive1List1.map((e) => ArchiveModel1.fromJson(e)).toList();
    var archive1List2 = json['archived_reservations2'] as List<dynamic>;
    List<ArchiveModel2> archive2 =
        archive1List2.map((e) => ArchiveModel2.fromJson(e)).toList();
    return ReservationModel(model1: archive1, model2: archive2);
  }
}
