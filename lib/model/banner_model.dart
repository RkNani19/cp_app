class BannerModel {
  final String id;
  final String name;
  final String image;
  final String location;
  final String price;

  BannerModel({
    required this.id,
    required this.name,
    required this.image,
    required this.location,
    required this.price,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['menu_id'],
      name: json['menu_name'],
      image: json['menu_icon'].toString().replaceAll("Image preview", ""),
      location: json['location'],
      price: json['sale_price'],
    );
  }

  void fetchProjects() {}
}
