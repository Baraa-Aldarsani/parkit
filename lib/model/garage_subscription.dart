import 'garage_mode.dart';

class GarageSubscription {
  final int id;
  final double price;

  GarageSubscription({
    required this.id,
    required this.price,
  });

  factory GarageSubscription.fromJson(Map<String, dynamic> json) {
    return GarageSubscription(
      id: json['id'],
      price: double.parse(json['price'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'price': price,
    };
  }
}