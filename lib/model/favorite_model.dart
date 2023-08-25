
import 'location_model.dart';

class FavoriteModel{
  final int id;
  final LocationModel garageModel;

  FavoriteModel({required this.id,required this.garageModel});

  factory FavoriteModel.fromJson(Map<String,dynamic> json){
    return FavoriteModel(id: json['id'], garageModel: LocationModel.fromJson(json['garages'],0));
  }
}