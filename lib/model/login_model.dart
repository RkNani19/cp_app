class LoginModel {
  String cpId;
  String userName;
  String userEmail;
  String mobile;
  String uploadPic;
  String careTakerMobile;
  String agentCompanyName;
  String status;

  LoginModel({
    required this.cpId,
    required this.userName,
    required this.userEmail,
    required this.mobile,
    required this.uploadPic,
    required this.agentCompanyName,
    required this.careTakerMobile,
    required this.status,
  });

  factory LoginModel.fromJson(Map<String, dynamic>json){
    return LoginModel(
      cpId: json['cp_id'],
      userName: json["user_name"],
      userEmail: json['user_email'],
      mobile:json['mobile'],
      uploadPic: json['upload_pic'],
      agentCompanyName: json['agent_company_name'],
      careTakerMobile: json['care_taker_mobile'],
      status: json['status'],
    );
  }
}
