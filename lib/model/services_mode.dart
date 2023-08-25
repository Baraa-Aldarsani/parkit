import 'garage_mode.dart';

class ServiceModel {
  final int id;
  final String name;
  final String image;
  final String serviceInformation;
  final double price;
  GarageModel? garageModel;

  ServiceModel({
    required this.id,
    required this.name,
    required this.image,
    required this.serviceInformation,
    required this.price,
    this.garageModel,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json,
      {bool garage = false}) {
    GarageModel garages = GarageModel(
        id: 0,
        name: '',
        email: '',
        floorNumber: 0,
        isOpen: 0,
        pricePerHour: 0.0,
        parksNumber: 0,
        timeOpen: '',
        timeClose: '',
        garageInformation: '');
    if (garage) {
      garages = GarageModel.fromJson(json['garages'],includeFloor: false);
    }
    return ServiceModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      serviceInformation: json['service_information'],
      price: double.parse(json['price'].toString()),
      garageModel: garages,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'service_information': serviceInformation,
      'price': price,
    };
  }
}
