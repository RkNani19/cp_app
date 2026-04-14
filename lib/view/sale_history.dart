import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gjk_cp/config/app_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

 

class SalesHistory extends StatefulWidget {
  const SalesHistory({super.key});

  @override
  State<SalesHistory> createState() => _SalesHistoryState();
}

class _SalesHistoryState extends State<SalesHistory> {
  bool isLoading = true;

  int totalUnits = 0;
  String totalSalesAmount = "₹0";
  String receivedAmount = "₹0";
  String pendingAmount = "₹0";

  @override
  void initState() {
    super.initState();
    fetchSalesData();
  }

  Future<void> fetchSalesData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cpId = prefs.getInt("cpId") ?? 0;

      print("CP ID 👉 $cpId");

      if (cpId == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Invalid User. Please login again")),
        );
        setState(() => isLoading = false);
        return;
      }

      /// ✅ API CALL (AppConfig based)
      final uri = Uri.parse(
              "${AppConfig.baseUrl}/mobileapp/cpleadsadatawithcommsionsaleshistoryy")
          .replace(
        queryParameters: {
          "cp_id": cpId.toString(),
        },
      );

      print("API 👉 $uri");

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        print("Response 👉 $jsonData");

        setState(() {
          totalUnits = jsonData['totalsales'] ?? 0;

          totalSalesAmount =
              formatAmount(jsonData['totalsalesamount'] ?? 0);

          receivedAmount =
              formatAmount(jsonData['receivedamount'] ?? 0);

          pendingAmount =
              formatAmount(jsonData['pending'] ?? 0);

          isLoading = false;
        });
      } else {
        throw Exception("API Failed");
      }
    } catch (e) {
      print("Error 👉 $e");
      setState(() => isLoading = false);
    }
  }

  /// 🔥 Amount Formatter (Cr / Lakhs)
  String formatAmount(dynamic amount) {
    double value = double.tryParse(amount.toString()) ?? 0;

    if (value >= 10000000) {
      return "₹${(value / 10000000).toStringAsFixed(1)} Cr";
    } else if (value >= 100000) {
      return "₹${(value / 100000).toStringAsFixed(2)} Lakhs";
    } else {
      return "₹${value.toStringAsFixed(0)}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFF5F6FA),
        title: const Text(
          "Sales History",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  SalesCard(
                    title: "Total Sales",
                    value: totalSalesAmount,
                    tagText: "$totalUnits Units",
                    tagColor: const Color(0xFFE0E7FF),
                    valueColor: const Color(0xFF0A2A6A),
                  ),

                  const SizedBox(height: 16),

                  SalesCard(
                    title: "Commission Paid",
                    value: receivedAmount,
                    tagText: "Received",
                    tagColor: const Color(0xFFD1FAE5),
                    valueColor: const Color(0xFF10B981),
                  ),

                  const SizedBox(height: 16),

                  SalesCard(
                    title: "Commission Due",
                    value: pendingAmount,
                    tagText: "Pending",
                    tagColor: const Color(0xFFF3E8D6),
                    valueColor: const Color(0xFFB0892F),
                  ),
                ],
              ),
            ),
    );
  }
}

class SalesCard extends StatelessWidget {
  final String title;
  final String value;
  final String tagText;
  final Color tagColor;
  final Color valueColor;

  const SalesCard({
    super.key,
    required this.title,
    required this.value,
    required this.tagText,
    required this.tagColor,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: tagColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  tagText,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}