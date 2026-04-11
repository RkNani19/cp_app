import 'package:flutter/material.dart';
import 'package:gjk_cp/view/dashboard_screen.dart';

class CallUs extends StatefulWidget {
  const CallUs({super.key, required this.title});
  final String title;

  @override
  State<CallUs> createState() => _CallUsState();
}

class _CallUsState extends State<CallUs> {

  /// 🔥 Reusable Contact Card
  Widget contactCard({
    required String title,
    required String tag,
    required String phone,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05), // soft shadow
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// Title + Tag
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F4F7),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  tag,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF3A5BA0),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          /// Phone Number
          Text(
            phone,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFFC8A573),
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 14),

          /// Call Button
          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.call, size: 18),
              label: const Text(
                "Call Now",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF021148),
                 foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen(title: '')),
              (route) => false,
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// 🔹 Title
                  const Text(
                    "Contact Us",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0D1B2A),
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// 🔹 Cards
                  contactCard(
                    title: "Sales Team",
                    tag: "Primary",
                    phone: "+91 98765 43210",
                  ),

                  contactCard(
                    title: "Customer Support",
                    tag: "Support",
                    phone: "+91 98765 43211",
                  ),

                  contactCard(
                    title: "Site Visit Booking",
                    tag: "Booking",
                    phone: "+91 98765 43212",
                  ),

                  const SizedBox(height: 10),

                  /// 🔹 Head Office Card
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: const Color(0xFF021148),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const Text(
                          "Head Office",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 16),

                        /// Address
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Icon(Icons.location_on_outlined,
                                color: Colors.white70),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "GJKedia Homes, 123 Business Tower, Bandra Kurla Complex, Mumbai - 400051",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 14),

                        /// Email
                        Row(
                          children: const [
                            Icon(Icons.mail_outline, color: Colors.white70),
                            SizedBox(width: 10),
                            Text(
                              "info@gjkediahomes.com",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 14),

                        /// Working Hours
                        Row(
                          children: const [
                            Icon(Icons.access_time, color: Colors.white70),
                            SizedBox(width: 10),
                            Text(
                              "Mon - Sat: 10:00 AM - 7:00 PM",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}