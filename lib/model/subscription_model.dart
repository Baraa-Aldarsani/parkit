import 'garage_subscription.dart';
import 'user_model.dart';

class SubscriptionModel {
  final int id;
  final String startDate;
  final String endDate;
  UserModel? user;
  GarageSubscription? garageSubscription;
  SubscriptionModel({
    required this.id,
    required this.startDate,
    required this.endDate,
    this.user,
    this.garageSubscription,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    print("SubscriptionModel11");
      if(json['users'] != null){
    return SubscriptionModel(
      id: json['id'],
      startDate: json['start_date_sub'],
      endDate: json['end_date_sub'],
      user: UserModel.fromJson(json['users'],2),
    );
  } else {
        return SubscriptionModel(
          id: json['id'],
          startDate: json['start_date_sub'],
          endDate: json['end_date_sub'],
          garageSubscription: GarageSubscription.fromJson(json['garage_subscriptions']),
        );
      }
  }
}


