class ProjectModel {
  final String projectId;
  final String projectName;

  ProjectModel({
    required this.projectId,
    required this.projectName,
  });

  // 🔥 Convert JSON → Model
  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      projectId: json['project_id']?.toString() ?? '',
      projectName: json['project_name']?.toString() ?? '',
    );
  }

  // 🔥 Optional: Convert Model → JSON (useful later)
  Map<String, dynamic> toJson() {
    return {
      "project_id": projectId,
      "project_name": projectName,
    };
  }
}