import 'package:flutter/material.dart';
import 'package:gjk_cp/view/dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CpDetails extends StatefulWidget {
  const CpDetails({super.key, required this.title});
  final String title;

  @override
  State<CpDetails> createState() => _CpDetailsState();
}

class _CpDetailsState extends State<CpDetails> {
  String userName = "";
  String mobile = "";
  String email = "";
  String address = "";
  String pan = "";
  String aadhar = "";
  String cpId = "";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      userName = prefs.getString("userName") ?? "Guest User";
      mobile = prefs.getString("mobile") ?? "No Mobile";
      email = prefs.getString("userEmail") ?? "No Email";
      address = prefs.getString("agentAddress") ?? "No Address";
      pan = prefs.getString("panCard") ?? "No PAN";
      aadhar = prefs.getString("aadharNumber") ?? "No Aadhar";
      cpId = prefs.getInt("cpId")?.toString() ?? "No ID";
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen(title: "")),
          (route) => false,
        );
        return false;
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Channel Partner Details",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),

            const SizedBox(height: 16),

            profileCard(userName, cpId),

            const SizedBox(height: 20),

            contactCard(mobile, email, address),

            const SizedBox(height: 20),

            bankCard(),

            const SizedBox(height: 30),

            kycCard(pan, aadhar),

            const SizedBox(height: 30),

            editButton(),
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// PROFILE CARD
////////////////////////////////////////////////////////////

Widget profileCard(String name, String cpId) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFF0A1F66),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      children: [
        Row(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                color: Color(0xFFC49A50),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.person, color: Colors.white, size: 30),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Channel Partner",
                  style: TextStyle(color: Color(0xFFB6C2E1), fontSize: 13),
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 20),

        Row(
          children: [
            expandedCard("Partner ID", cpId, true),
            const SizedBox(width: 12),
            expandedCard("Member Since", "Jan 2024", false),
          ],
        ),
      ],
    ),
  );
}

Widget expandedCard(String title, String value, bool isGold) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1C2F6E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: Color(0xFFB6C2E1), fontSize: 12),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              color: isGold ? const Color(0xFFC49A50) : Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}

////////////////////////////////////////////////////////////
/// CONTACT
////////////////////////////////////////////////////////////

Widget contactCard(String mobile, String email, String address) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFFE5E7EB)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Contact Information",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 16),

        contactItem(Icons.phone_outlined, "Phone Number", mobile),
        const SizedBox(height: 14),

        contactItem(Icons.email_outlined, "Email Address", email),
        const SizedBox(height: 14),

        contactItem(Icons.location_on_outlined, "Address", address),
      ],
    ),
  );
}

Widget bankCard() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: const Color(0xFFE5E7EB)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ===== TITLE =====
        const Text(
          "Bank Details",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0F172A),
          ),
        ),

        const SizedBox(height: 18),

        // ===== BANK NAME =====
        bankItem("Bank Name", "HDFC Bank"),

        const SizedBox(height: 16),

        // ===== ACCOUNT NUMBER =====
        bankItem("Account Number", "XXXX XXXX XX12 3456"),

        const SizedBox(height: 16),

        // ===== IFSC =====
        bankItem("IFSC Code", "HDFC0001234"),
      ],
    ),
  );
}

Widget bankItem(String title, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          color: Color(0xFF64748B),
          fontWeight: FontWeight.w500,
        ),
      ),

      const SizedBox(height: 4),

      Text(
        value,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Color(0xFF0F172A),
        ),
      ),
    ],
  );
}
////////////////////////////////////////////////////////////
/// KYC
////////////////////////////////////////////////////////////

Widget kycCard(String pan, String aadhar) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFFE5E7EB)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "KYC Documents",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 14),

        kycItem("PAN Card", pan),
        kycItem("Aadhar Card", aadhar),
      ],
    ),
  );
}

Widget kycItem(String title, String value) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFFF3F4F6),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 2),
            Text(value, style: const TextStyle(color: Color(0xFF64748B))),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            "Verified",
            style: TextStyle(color: Colors.green, fontSize: 12),
          ),
        ),
      ],
    ),
  );
}

////////////////////////////////////////////////////////////
/// COMMON
////////////////////////////////////////////////////////////

Widget contactItem(IconData icon, String title, String value) {
  return Row(
    children: [
      Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          color: Color(0xFFF1F3F6),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: const Color(0xFF1E3A8A)),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
            ),
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget editButton() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 14),
    decoration: BoxDecoration(
      border: Border.all(color: const Color(0xFF0A1F66), width: 1.5),
      borderRadius: BorderRadius.circular(30),
    ),
    child: const Center(
      child: Text(
        "Edit Profile Details",
        style: TextStyle(color: Color(0xFF0A1F66), fontWeight: FontWeight.w600),
      ),
    ),
  );
}
