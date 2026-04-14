import 'package:flutter/material.dart';

class CreateAssociateScreen extends StatelessWidget {
  const CreateAssociateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFF5F6FA),
        title: const Text(
          "Create Associate",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Name
            const LabelText("Associate Name"),
            const SizedBox(height: 8),
            const CustomTextField(hint: "Enter full name"),

            const SizedBox(height: 20),

            /// Mobile
            const LabelText("Mobile Number"),
            const SizedBox(height: 8),
            const CustomTextField(hint: "+91 00000 00000"),

            const SizedBox(height: 20),

            /// Email
            const LabelText("Email Address"),
            const SizedBox(height: 8),
            const CustomTextField(hint: "associate@example.com"),

            const SizedBox(height: 20),

            /// PAN
            const LabelText("PAN Card Number"),
            const SizedBox(height: 8),
            const CustomTextField(hint: "ABCDE1234F"),

            const SizedBox(height: 20),

            /// Aadhaar
            const LabelText("Aadhar Card Number"),
            const SizedBox(height: 8),
            const CustomTextField(hint: "XXXX XXXX XXXX"),

            const SizedBox(height: 20),

            /// Bank
            const LabelText("Bank Account Number"),
            const SizedBox(height: 8),
            const CustomTextField(hint: "Enter account number"),

            const SizedBox(height: 20),

            /// IFSC
            const LabelText("IFSC Code"),
            const SizedBox(height: 8),
            const CustomTextField(hint: "Enter IFSC code"),

            const SizedBox(height: 30),

            /// Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Associate Created")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0A2A6A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Create Associate",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 🔹 Label Widget
class LabelText extends StatelessWidget {
  final String text;
  const LabelText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    );
  }
}

/// 🔹 Custom TextField (Main UI part)
class CustomTextField extends StatelessWidget {
  final String hint;

  const CustomTextField({super.key, required this.hint});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade500),

        filled: true,
        fillColor: const Color(0xFFF1F3F6),

        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 18),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF0A2A6A)),
        ),
      ),
    );
  }
}