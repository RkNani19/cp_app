class VideoProjectModel {
  final String id;
  final String name;

  VideoProjectModel({
    required this.id,
    required this.name,
  });

  factory VideoProjectModel.fromJson(Map<String, dynamic> json) {
    return VideoProjectModel(
      id: json['project_id'] ?? '',
      name: json['project_name'] ?? '',
    );
  }
}