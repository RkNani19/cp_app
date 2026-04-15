class SalesSummaryModel {
  final int totalSales;
  final int totalSalesAmount;
  final int activeLeads;
  final int unitSolds;
  final int monthCommission;
  final int receivedAmount;
  final int pending;

  SalesSummaryModel({
    required this.totalSales,
    required this.totalSalesAmount,
    required this.activeLeads,
    required this.unitSolds,
    required this.monthCommission,
    required this.receivedAmount,
    required this.pending,
  });

  /// 🔹 JSON → Model
  factory SalesSummaryModel.fromJson(Map<String, dynamic> json) {
    return SalesSummaryModel(
      totalSales: json['totalsales'] ?? 0,
      totalSalesAmount: json['totalsalesamount'] ?? 0,
      activeLeads: json['activeleads'] ?? 0,
      unitSolds: json['unitsolds'] ?? 0,
      monthCommission: json['monthcommion'] ?? 0,
      receivedAmount: json['receivedamount'] ?? 0,
      pending: json['pending'] ?? 0,
    );
  }

  /// 🔹 Model → JSON
  Map<String, dynamic> toJson() {
    return {
      'totalsales': totalSales,
      'totalsalesamount': totalSalesAmount,
      'activeleads': activeLeads,
      'unitsolds': unitSolds,
      'monthcommion': monthCommission,
      'receivedamount': receivedAmount,
      'pending': pending,
    };
  }
}