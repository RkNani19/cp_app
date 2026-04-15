class ProjectDetailsModel {
  final String name;
  final String description;
  final String image;
  final String lat;
  final String lng;

  ProjectDetailsModel({
    required this.name,
    required this.description,
    required this.image,
    required this.lat,
    required this.lng,
  });

  factory ProjectDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProjectDetailsModel(
      name: json['project_name'] ?? "",
      description: json['description'] ?? "",
      image: json['menu_icon'] ?? "",
      lat: json['lat'] ?? "",
      lng: json['lan'] ?? "",
    );
  }
}