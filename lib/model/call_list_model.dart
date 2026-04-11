class CallListModel {
  final String callerId;
  final String leadName;
  final String leadMobile;
  final String leadEmail;
  final String createdIn;
  final String updatedTime;
  final String sourceType;
  final String status;


  CallListModel({
    required this.callerId,
    required this.leadName,
    required this.leadMobile,
    required this.leadEmail,
    required this.createdIn,
    required this.updatedTime,
    required this.sourceType,
    required this.status,
  });

  factory CallListModel.fromJson(Map<String, dynamic> json) {
    return CallListModel(
      callerId: json['caller_id'] ?? "",
      leadName: json['lead_name'] ?? "",
      leadMobile: json['lead_mobile'] ?? "",
      leadEmail: json['lead_email'] ?? "",
      createdIn: json['created_in'] ?? "",
      updatedTime: json['updated_time'] ?? "",
      sourceType: json['source_type'] ?? "",
      status: json['lead_status'] ?? "",
    );
  }
}