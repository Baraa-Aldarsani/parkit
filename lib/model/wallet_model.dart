class WalletModel{
 final int id;
 final double price;

  WalletModel({
   required this.id,
   required this.price,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json,{bool include = false}) {
    return WalletModel(
      id: json['id'],
      price: double.parse(json['price'].toString()),
    );
  }
}