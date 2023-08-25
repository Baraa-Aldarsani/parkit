import 'package:parking/model/services_mode.dart';

class RequiredServicesModel{
  final int id;
  final ServiceModel serviceModel;

  RequiredServicesModel({required this.id,required this.serviceModel});

  factory RequiredServicesModel.fromJson(Map<String, dynamic> json) {
    return RequiredServicesModel(
      id: json['id'],
      serviceModel: ServiceModel.fromJson(json['services'],garage: true),
    );
  }
}