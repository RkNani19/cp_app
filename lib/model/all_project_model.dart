class AllProjectModel {
  final String id;
  final String name;
  final String location;
  final String price;
  final String image;

  AllProjectModel({
    required this.id,
    required this.name,
    required this.location,
    required this.price,
    required this.image,
  });

  factory AllProjectModel.fromJson(Map<String, dynamic> json) {
    return AllProjectModel(
      id: json['menu_id'] ?? "",
      name: json['menu_name'] ?? "",
      location: json['location'] ?? "",
      price: json['sale_price'] ?? "",
      image: json['menu_icon'] ?? "",
    );
  }
}