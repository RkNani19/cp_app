class TelleCallModel {
  final String msg;
  final String totalData;
  final String todaysCalls;
  final String montCalls;
  final String totalCalls;

  TelleCallModel({
    required this.msg,
    required this.totalData,
    required this.todaysCalls,
    required this.montCalls,
    required this.totalCalls,
  });

  factory TelleCallModel.fromJson(Map<String, dynamic> json) {
    return TelleCallModel(
      msg: json['msg']?.toString() ?? "",

      // ✅ FIXED KEYS + SAFE STRING
      totalData: json['totaldata']?.toString() ?? "0",
      todaysCalls: json['todayscalls']?.toString() ?? "0",
      montCalls: json['monthcalls']?.toString() ?? "0",
      totalCalls: json['totalcalls']?.toString() ?? "0",
    );
  }
}