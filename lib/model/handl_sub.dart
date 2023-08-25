import 'package:parking/model/garage_mode.dart';
import 'subscription_model.dart';

class HandlSub{
  final List<SubscriptionModel> subscriptions;
  final List<SubscriptionModel> garage;

  HandlSub({
    required this.subscriptions,
    required this.garage,
  });

  factory HandlSub.fromJson(Map<String, dynamic> json) {
    final List<dynamic> subscriptionsJson = json['subscriptions'];
    final List<dynamic> garageJson = json['garage'];
    return HandlSub(
      subscriptions: subscriptionsJson.map((subJson) => SubscriptionModel.fromJson(subJson)).toList(),
      garage: garageJson.map((garageJson) => SubscriptionModel.fromJson(garageJson)).toList(),
    );
  }
}