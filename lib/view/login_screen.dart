import 'package:flutter/material.dart';
import 'package:gjk_cp/view/create_account.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.title});
  final String title;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    Text(
                      "GJKedia",
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0B2A6F),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "HOMES",
                      style: TextStyle(
                        color: Color(0xFFB89B5E),
                        fontSize: 16,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10),
                    Text(
                      "Customer Portal Login",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
               margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [BoxShadow(blurRadius: 6)],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome Back",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),

                    const Text(
                      "Enter your credentials to access your account",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),

                    SizedBox(height: 10),
                    Text(
                      "Customer ID/Mobile Number",
                      style: TextStyle(fontSize: 16),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Enter Customer ID or Mobile",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        isDense: true,
                      ),
                    ),

                    SizedBox(height: 10),
                    Text("Secret Key", style: TextStyle(fontSize: 16)),
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Enter your secret key",
                        prefixIcon: Icon(Icons.key_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        isDense: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account? ",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const CreateAccount(title: 'Create Account'),
                      ),
                    );
                  },
                  child: const Text(
                    "Create Account",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 198, 218, 132),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
