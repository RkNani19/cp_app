class CallLogResponseModel {
  final int recordId;
  final int callId;
  final int status;

  CallLogResponseModel({
    required this.recordId,
    required this.callId,
    required this.status,
  });

  factory CallLogResponseModel.fromJson(Map<String, dynamic> json) {
    return CallLogResponseModel(
      recordId: json['record_id'] ?? 0,
      callId: json['call_id'] ?? 0,
      status: json['status'] ?? 0,
    );
  }
}