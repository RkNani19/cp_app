class CallusModel {
  final String salesName;
  final String saleMobile;

  final String csName;
  final String csMobile;

  final String svbName;
  final String svbMobile;

  final String address;
  final String email;
  final String timing;

  CallusModel({
    required this.salesName,
    required this.saleMobile,
    required this.csName,
    required this.csMobile,
    required this.svbName,
    required this.svbMobile,
    required this.address,
    required this.email,
    required this.timing,
  });

  factory CallusModel.fromJson(Map<String, dynamic> json) {
    return CallusModel(
      salesName: json['sales_team_name'] ?? '',
      saleMobile: json['sales_team_number'] ?? '',

      csName: json['customer_support_name'] ?? '',
      csMobile: json['customer_support_number'] ?? '',

      svbName: json['site_visit_booking_name'] ?? '',
      svbMobile: json['site_visit_booking_number'] ?? '',

      address: json['head_office_address'] ?? '',
      email: json['office_mail'] ?? '',
      timing: json['office_timing'] ?? '',
    );
  }
}