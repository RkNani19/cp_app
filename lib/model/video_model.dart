class VideoModel {
  final String id;
  final String name;
  final String videoUrl;
  final String title;
  final int status;

  VideoModel({
    required this.id,
    required this.name,
    required this.videoUrl,
    required this.title,
    required this.status,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['requirement_id'] ?? '',
      name: json['requirement_name'] ?? '',
      videoUrl: json['vedio_url'] ?? '',
      title: json['title'] ?? '',
      status: json['status'] ?? 0,
    );
  }
}