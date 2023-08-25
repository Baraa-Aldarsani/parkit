class CarModel {
   final int id;
   String imageCar;
   String name;
   int number;
   bool isSelected = false;
   String? barCode;

  CarModel({
    required this.id,
    required this.imageCar,
    required this.name,
    required this.number,
    required this.isSelected,
    this.barCode,
  });

   factory CarModel.fromJson(Map<String, dynamic> json,{bool bar = false}) {
     String barCode = '';
     if(bar){
       barCode = json['barcode'];
     }

     return CarModel(
       id: json['id'],
       imageCar: json['image'],
       name: json['name'],
       number: json['number'],
       isSelected: false,
       barCode: barCode,
     );
   }

   Map<String, dynamic> toJson() {
     return {
       'imageCar': imageCar,
       'name': name,
       'number': number,
       'isSelected': isSelected,
     };
   }
}
