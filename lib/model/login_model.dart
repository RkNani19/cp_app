class LoginModel {
  final int cpId;
  final String userName;
  final String mobile;
  final int status;

  LoginModel({
    required this.cpId,
    required this.userName,
    required this.mobile,
    required this.status,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      cpId: int.tryParse(json['cp_id'].toString()) ?? 0,
      userName: json['user_name']?.toString() ?? '',
      mobile: json['mobile']?.toString() ?? '',
      status: int.tryParse(json['status'].toString()) ?? 0,
    );
  }
}