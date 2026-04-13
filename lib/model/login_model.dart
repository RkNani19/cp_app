class LoginModel {
  final int cpId;
  final String userName;
  final String mobile;
  final int status;
  final String userEmail;
  final String agentUniqueId;
  final String agentAddress;
  final String panCard;
  final String aadharNumber;
  final String bankName;
  final String accountNumber;
  final String ifsc;

  LoginModel({
    required this.cpId,
    required this.userName,
    required this.mobile,
    required this.status,
    required this.userEmail,
    required this.agentUniqueId,
    required this.agentAddress,
    required this.panCard,
    required this.aadharNumber,
    required this.bankName,
    required this.accountNumber,
    required this.ifsc,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      cpId: int.tryParse(json['cp_id'].toString()) ?? 0,
      userName: json['user_name']?.toString() ?? '',
      mobile: json['mobile']?.toString() ?? '',
      status: int.tryParse(json['status'].toString()) ?? 0,
      // ✅ NEW PARSING
      userEmail: json['user_email']?.toString() ?? '',
      agentUniqueId: json['agent_unique_id']?.toString() ?? '',
      agentAddress: json['agent_address']?.toString() ?? '',
      panCard: json['pan_card']?.toString() ?? '',
      aadharNumber: json['aadhar_number']?.toString() ?? '',
      bankName: json['bank_name']?.toString() ?? '',
      accountNumber: json["account_number"]?.toString() ?? "",
      ifsc: json["ifsc_code"]?.toString() ?? "",
    );
  }
}
