class CpDashboardModel {
  final String totalSales;
  final String totalSalesAmount;
  final String activeLeads;
  final String unitsSold;
  final String monthCommission;

  CpDashboardModel({
    required this.totalSales,
    required this.totalSalesAmount,
    required this.activeLeads,
    required this.unitsSold,
    required this.monthCommission,
  });

  factory CpDashboardModel.fromJson(Map<String, dynamic> json) {
    return CpDashboardModel(
      totalSales: json['totalsales']?.toString() ?? "0",
      totalSalesAmount: json['totalsalesamount']?.toString() ?? "0",
      activeLeads: json['activeleads']?.toString() ?? "0",
      unitsSold: json['unitsolds']?.toString() ?? "0",
      monthCommission: json['monthcommion']?.toString() ?? "0",
    );
  }
}