class RegisterResponse {
  final String status;
  final String msg;

  RegisterResponse({
    required this.status,
    required this.msg,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      status: json["status"]?.toString() ?? "0",
      msg: json["msg"] ?? "Something went wrong",
    );
  }
}