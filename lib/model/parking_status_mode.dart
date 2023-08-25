class ParkingStatus {
  final int id;
  final String name;

  ParkingStatus({required this.id, required this.name});

  factory ParkingStatus.fromJson(Map<String, dynamic> json) {
    return ParkingStatus(
      id: json['id'],
      name: json['name'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
