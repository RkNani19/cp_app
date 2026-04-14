import 'package:flutter/material.dart';

class SalesHistory extends StatelessWidget {
  const SalesHistory({super.key});

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
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            SalesCard(
              title: "Total Sales",
              value: "₹45.2 Cr",
              tagText: "12 Units",
              tagColor: Color(0xFFE0E7FF),
              valueColor: Color(0xFF0A2A6A),
            ),
            SizedBox(height: 16),
            SalesCard(
              title: "Commission Paid",
              value: "₹1.89 Lakhs",
              tagText: "Received",
              tagColor: Color(0xFFD1FAE5),
              valueColor: Color(0xFF10B981),
            ),
            SizedBox(height: 16),
            SalesCard(
              title: "Commission Due",
              value: "₹37,000",
              tagText: "Pending",
              tagColor: Color(0xFFF3E8D6),
              valueColor: Color(0xFFB0892F),
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
          /// Top Row
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

          /// Value
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