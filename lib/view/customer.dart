import 'package:flutter/material.dart';

class Customer extends StatelessWidget {
  const Customer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFF5F6FA),
        title: const Text(
          "My Customers",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFE6ECF5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: Text(
                "4 Total",
                style: TextStyle(
                    color: Color(0xFF0A2A6A), fontWeight: FontWeight.w600),
              ),
            ),
          )
        ],
      ),

      body: Column(
        children: [

          /// 🔘 Filter Tabs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: const [
                FilterChipUI("All", true),
                SizedBox(width: 10),
                FilterChipUI("New", false),
                SizedBox(width: 10),
                FilterChipUI("Contacted", false),
                SizedBox(width: 10),
                FilterChipUI("Site Visit", false),
              ],
            ),
          ),

          const SizedBox(height: 16),

          /// 🔽 List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 4,
              itemBuilder: (context, index) {
                return const CustomerCard();
              },
            ),
          )
        ],
      ),
    );
  }
}

/// 🔹 Customer Card
class CustomerCard extends StatelessWidget {
  const CustomerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// Top Row
          Row(
            children: [

              /// Avatar
              Container(
                width: 55,
                height: 55,
                decoration: const BoxDecoration(
                  color: Color(0xFFB0892F),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person, color: Colors.white),
              ),

              const SizedBox(width: 12),

              /// Name + Phone + Email
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [

                    Text(
                      "Amit Sharma",
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),

                    SizedBox(height: 4),

                    Row(
                      children: [
                        Icon(Icons.call, size: 14, color: Colors.grey),
                        SizedBox(width: 4),
                        Text("+91 98765 11111",
                            style: TextStyle(fontSize: 13)),
                      ],
                    ),

                    SizedBox(height: 2),

                    Row(
                      children: [
                        Icon(Icons.email, size: 14, color: Colors.grey),
                        SizedBox(width: 4),
                        Text("amit@example.com",
                            style: TextStyle(fontSize: 13)),
                      ],
                    ),
                  ],
                ),
              ),

              /// Status
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5E8C7),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Site Visit",
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFFB0892F),
                      fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),

          const SizedBox(height: 14),

          /// Location
          const Row(
            children: [
              Icon(Icons.location_on, size: 16, color: Colors.grey),
              SizedBox(width: 6),
              Text(
                "GJ Kedia Signature Towers",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),

          const SizedBox(height: 6),

          /// Date
          const Row(
            children: [
              Icon(Icons.calendar_today, size: 14, color: Colors.grey),
              SizedBox(width: 6),
              Text(
                "Added on 28 Mar 2026",
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// Interest Tag
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F3F6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text("Interested in 3 BHK"),
          ),

          const SizedBox(height: 14),

          const Divider(),

          const SizedBox(height: 10),

          /// Buttons
          Row(
            children: [

              /// Edit
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.edit, size: 18),
                  label: const Text("Edit"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              /// Call
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.call),
                  label: const Text("Call"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0A2A6A),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

/// 🔹 Filter Chip
class FilterChipUI extends StatelessWidget {
  final String text;
  final bool selected;

  const FilterChipUI(this.text, this.selected, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFFF5E8C7) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: selected
              ? const Color(0xFFB0892F)
              : Colors.grey.shade300,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          color:
              selected ? const Color(0xFFB0892F) : Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}