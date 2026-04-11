class EnquiryResponseModel {
  final int status;
  final String msg;
  final int orderId;

  EnquiryResponseModel({
    required this.status,
    required this.msg,
    required this.orderId,
  });

  // 🔥 JSON → Model
  factory EnquiryResponseModel.fromJson(Map<String, dynamic> json) {
    return EnquiryResponseModel(
      status: json['status'] ?? 0,
      msg: json['msg']?.toString() ?? '',
      orderId: json['order_id'] ?? 0,
    );
  }

  // 🔥 Model → JSON
  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "msg": msg,
      "order_id": orderId,
    };
  }
}