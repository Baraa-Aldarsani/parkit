import 'package:get/get.dart';

class QualitiesModel {
  final RxMap<String, List<Map<String, String>>> flrAquai;

  QualitiesModel({
    RxMap<String, List<Map<String, String>>>? flrAquai,
  }) : flrAquai = flrAquai ??
            RxMap.from({
              "": [
                {"": ""}
              ]
            });

  factory QualitiesModel.fromJson(Map<String, dynamic> json) {
    return QualitiesModel(
      flrAquai: RxMap<String, List<Map<String, String>>>.from(json['flrAquai']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'flrAquai': flrAquai,
    };
  }
}
