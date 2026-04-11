class TeleSourceModel {
  final String id;
  final String name;
  final String count;

  TeleSourceModel({
    required this.id,
    required this.name,
    required this.count,
  });

  factory TeleSourceModel.fromJson(Map<String, dynamic> json) {
    return TeleSourceModel(
      id: json['telecaller_source_id'],
      name: json['source_name'],
      count: json['count'],
    );
  }
}