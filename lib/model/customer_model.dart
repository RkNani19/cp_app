class CustomerModel {
  final String name;
  final String mobile;
  final String email;
  final String project;
  final String activity;
  final String date;

  CustomerModel({
    required this.name,
    required this.mobile,
    required this.email,
    required this.project,
    required this.activity,
    required this.date,
     required String id,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      name: json['first_name'] ?? '',
      mobile: json['mobile_number'] ?? '',
      email: json['email_id'] ?? '',
      project: json['requirement_name'] ?? '',
      activity: json['activity_name'] ?? '',
      date: json['created_date'] ?? '',
     id: json['s_no'] ?? ''
    );
  }

  get id => null;
}