class CustomerActivityModel {
  final String id;
  final String name;

  CustomerActivityModel({
    required this.id,
    required this.name,
  });

  factory CustomerActivityModel.fromJson(Map<String, dynamic> json) {
    return CustomerActivityModel(
      id: json['activity_id'] ?? '',
      name: json['activity_name'] ?? '',
    );
  }
}