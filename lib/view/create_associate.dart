import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gjk_cp/config/app_config.dart';
import 'package:gjk_cp/view/dashboard_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CreateAssociateScreen extends StatefulWidget {
  const CreateAssociateScreen({super.key});

  @override
  State<CreateAssociateScreen> createState() => _CreateAssociateScreenState();
}

class _CreateAssociateScreenState extends State<CreateAssociateScreen> {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final panController = TextEditingController();
  final aadharController = TextEditingController();
  final bankController = TextEditingController();
  final ifscController = TextEditingController();

  bool isLoading = false;

  Future<void> createAssociate() async {
  setState(() => isLoading = true);

  try {
    // ✅ GET cpId from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final cpId = prefs.getInt("cpId") ?? 0;

    print("CP ID 👉 $cpId"); // 🔥 Debug

    // ❌ prevent wrong API call
    if (cpId == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid User. Please login again")),
      );
      setState(() => isLoading = false);
      return;
    }

    final uri = Uri.parse("${AppConfig.baseUrl}/mobileapp/createcp").replace(
      queryParameters: {
        "cp_id": cpId.toString(), // ✅ FIXED
        "name": nameController.text.trim(),
        "mobile_number": mobileController.text.trim(),
        "email": emailController.text.trim(),
        "bank_name": "ICICI",
        "account_number": bankController.text.trim(),
        "ifsc_code": ifscController.text.trim(),
        "pan_card": panController.text.trim(),
        "aadhar_number": aadharController.text.trim(),
      },
    );

    print("Create Associate URL 👉 $uri");

    final response = await http.get(uri);

    print("RESPONSE 👉 ${response.body}");

    final data = json.decode(response.body);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(data["msg"] ?? "Success")),
    );

     // ✅ SUCCESS NAVIGATION
    if (data["status"] == true) {
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => const DashboardScreen(title: ''),
          ),
          (route) => false,
        );
      });
    }

  } catch (e) {
    print("ERROR 👉 $e");

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Something went wrong")),
    );
  }

  setState(() => isLoading = false);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFF5F6FA),
        title: const Text(
          "Create Associate",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
            CustomTextField(
              hint: "Enter full name",
              controller: nameController,
            ),

            const SizedBox(height: 20),

            /// Mobile
            const LabelText("Mobile Number"),
            const SizedBox(height: 8),
            CustomTextField(
              hint: "+91 00000 00000",
              controller: mobileController,
            ),

            const SizedBox(height: 20),

            /// Email
            const LabelText("Email Address"),
            const SizedBox(height: 8),
            CustomTextField(
              hint: "associate@example.com",
              controller: emailController,
            ),

            const SizedBox(height: 20),

            /// PAN
            const LabelText("PAN Card Number"),
            const SizedBox(height: 8),
            CustomTextField(hint: "ABCDE1234F", controller: panController),

            const SizedBox(height: 20),

            /// Aadhaar
            const LabelText("Aadhar Card Number"),
            const SizedBox(height: 8),
            CustomTextField(
              hint: "XXXX XXXX XXXX",
              controller: aadharController,
            ),

            const SizedBox(height: 20),

            /// Bank
            const LabelText("Bank Account Number"),
            const SizedBox(height: 8),
            CustomTextField(
              hint: "Enter account number",
              controller: bankController,
            ),

            const SizedBox(height: 20),

            /// IFSC
            const LabelText("IFSC Code"),
            const SizedBox(height: 8),
            CustomTextField(
              hint: "Enter IFSC code",
              controller: ifscController,
            ),

            const SizedBox(height: 30),

            /// Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: isLoading ? null : createAssociate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0A2A6A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Create Associate",
                        style: TextStyle(
                          color: Colors.white,
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
  final TextEditingController controller;
  const CustomTextField({
    super.key,
    required this.hint,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade500),

        filled: true,
        fillColor: const Color(0xFFF1F3F6),

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),

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
          borderSide: BorderSide(color: Color(0xFF0A2A6A)),
        ),
      ),
    );
  }
}
