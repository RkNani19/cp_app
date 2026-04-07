import 'package:flutter/material.dart';

class CpDetails extends StatelessWidget {
  const CpDetails({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ===== TITLE =====
          const Text(
            "Channel Partner Details",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),

          const SizedBox(height: 16),

          // ================= PROFILE CARD =================
          profileCard(),

          const SizedBox(height: 20),

          // ================= CONTACT =================
          contactCard(),

          const SizedBox(height: 20),

          // ================= PERFORMANCE =================
          performanceCard(),

          const SizedBox(height: 20),

          // ================= BANK =================
          bankCard(),

          const SizedBox(height: 20),

          // ================= KYC =================
          kycCard(),

          const SizedBox(height: 30),

          // ================= BUTTON =================
          editButton(),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// PROFILE CARD
////////////////////////////////////////////////////////////

Widget profileCard() {
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
              children: const [
                Text(
                  "Rajesh Kumar",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 4),
                Text(
                  "Channel Partner",
                  style: TextStyle(color: Color(0xFFB6C2E1), fontSize: 13),
                ),
              ],
            )
          ],
        ),

        const SizedBox(height: 20),

        Row(
          children: [
            expandedCard("Partner ID", "CP2024001", true),
            const SizedBox(width: 12),
            expandedCard("Member Since", "Jan 2024", false),
          ],
        )
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
          Text(title,
              style:
                  const TextStyle(color: Color(0xFFB6C2E1), fontSize: 12)),
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

Widget contactCard() {
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
        const Text("Contact Information",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        const SizedBox(height: 16),
        contactItem(Icons.phone_outlined, "Phone Number",
            "+91 98765 43210"),
        const SizedBox(height: 14),
        contactItem(Icons.email_outlined, "Email Address",
            "rajesh.kumar@example.com"),
        const SizedBox(height: 14),
        contactItem(Icons.location_on_outlined, "Address",
            "Andheri West, Mumbai - 400058"),
      ],
    ),
  );
}

////////////////////////////////////////////////////////////
/// PERFORMANCE
////////////////////////////////////////////////////////////

Widget performanceCard() {
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
          "Performance Stats",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),

        const SizedBox(height: 16),

        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.2,
          children: const [
            statBox(Icons.trending_up, "₹45.2 Cr", "Total Sales"),
            statBox(Icons.people_outline, "24", "Active Leads"),
            statBox(Icons.access_time, "12", "Units Sold"),
            statBox(Icons.workspace_premium, "Gold", "Partner Tier", isGold: true),
          ],
        )
      ],
    ),
  );
}

class statBox extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final bool isGold;

  const statBox(
    this.icon,
    this.value,
    this.label, {
    this.isGold = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          // ===== ICON =====
          Icon(
            icon,
            size: 24,
            color: isGold
                ? const Color(0xFFC49A50)
                : const Color(0xFF0A1F66),
          ),

          const SizedBox(height: 10),

          // ===== VALUE =====
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isGold
                  ? const Color(0xFFC49A50)
                  : const Color(0xFF0A1F66),
            ),
          ),

          const SizedBox(height: 4),

          // ===== LABEL =====
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// BANK
////////////////////////////////////////////////////////////

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

      // LABEL
      Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          color: Color(0xFF64748B),
          fontWeight: FontWeight.w500,
        ),
      ),

      const SizedBox(height: 4),

      // VALUE
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
 

Widget kycCard() {
  return cardBlock("KYC Documents", [
    kycItem("PAN Card", "ABCDE1234F"),
    kycItem("Aadhar Card", "XXXX XXXX 5678"),
  ]);
}

 

Widget cardBlock(String title, List<Widget> children) {
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
        Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        const SizedBox(height: 14),
        ...children,
      ],
    ),
  );
}

Widget infoText(String title, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
        const SizedBox(height: 2),
        Text(value,
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600)),
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
            Text(value,
                style: const TextStyle(color: Color(0xFF64748B))),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text("Verified",
              style: TextStyle(color: Colors.green, fontSize: 12)),
        )
      ],
    ),
  );
}

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
            Text(title,
                style: const TextStyle(
                    fontSize: 12, color: Color(0xFF64748B))),
            Text(value,
                style: const TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 14)),
          ],
        ),
      )
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
        style: TextStyle(
          color: Color(0xFF0A1F66),
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}