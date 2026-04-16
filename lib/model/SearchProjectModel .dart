class SearchProjectModel {
  final String id;
  final String name;
  final String location;
  final String price;
  final String image;

  SearchProjectModel({
    required this.id,
    required this.name,
    required this.location,
    required this.price,
    required this.image,
  });

  factory SearchProjectModel.fromJson(Map<String, dynamic> json) {
    return SearchProjectModel(
      id: json['menu_id'] ?? "",
      name: json['menu_name'] ?? "",
      location: json['location'] ?? "",
      price: json['sale_price'] ?? "",
      image: json['menu_icon'] ?? "",
    );
  }
}