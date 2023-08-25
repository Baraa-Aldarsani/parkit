class SubscriptionGarageModel {
  final int id;
  final double price;
  final String type;

  SubscriptionGarageModel(
      {required this.id, required this.price, required this.type});

  factory SubscriptionGarageModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionGarageModel(
        id: json['id'],
        price: double.parse(json['price'].toString()),
        type: json['subscriptions']['type']);
  }
}
