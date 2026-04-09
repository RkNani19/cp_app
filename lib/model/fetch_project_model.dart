class FetchProjectModel {
  final String id;
  final String name;
  final String location;
  final String price;
  final String image;

  FetchProjectModel({
    required this.id,
    required this.name,
    required this.location,
    required this.price,
    required this.image,
  });

  factory FetchProjectModel.fromJson(Map<String, dynamic> json) {
    return FetchProjectModel(
      id: json['menu_id'] ?? "",
      name: json['menu_name'] ?? "",
      location: json['location'] ?? "",
      price: json['sale_price'] ?? "",
      image: json['menu_icon']
              ?.toString()
              .split('Image preview')[0] ??
          "",
    );
  }
}