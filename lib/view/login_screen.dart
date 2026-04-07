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
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFEDF2FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
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
              // SizedBox(height: 10),
              Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 16,
                    ),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(blurRadius: 4, color: Colors.black12),
                      ],
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
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          decoration: InputDecoration(
                            labelText: "Enter Customer ID or Mobile",
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelStyle: TextStyle(color: Colors.grey),
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: Color(0xFFA6AEBD),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Color(0xFFA6AEBD)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Color(0xFFA6AEBD)),
                            ),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 10,
                            ),
                          ),
                        ),

                        SizedBox(height: 10),
                        Text(
                          "Secret Key",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          decoration: InputDecoration(
                            labelText: "Enter your secret key",
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelStyle: TextStyle(color: Colors.grey),
                            prefixIcon: Icon(
                              Icons.key_outlined,
                              color: Color(0xFFA6AEBD),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Color(0xFFA6AEBD)),
                            ),

                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Color(0xFFA6AEBD)),
                            ),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 10,
                            ),
                          ),
                        ),

                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Forgot Secret key?",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFD0AE66),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),

                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF0B2A6F),
                            ),
                            child: Text(
                              "Login to Account",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
                    child: Row(
                      // New Row to hold text and icon together
                      children: const [
                        Text(
                          "Create Account",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFFD0AE66),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 4), // Small gap
                        Icon(
                          Icons.person_add_alt_outlined,
                          size: 18,
                          color: Color(0xFFD0AE66),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 16,
                    ),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(blurRadius: 4, color: Colors.black12),
                      ],
                    ),
                    child:  RichText(
  textAlign: TextAlign.center,
  text: TextSpan(
    style: TextStyle(color: Colors.grey, fontSize: 14),
    children: [
      TextSpan(
        text:
            "Need help? Contact your sales representative or call us at ",
      ),
      WidgetSpan(
        child: GestureDetector(
          onTap: () {},
          child: Text(
            "+91 9876543210",
            style: TextStyle(
              color: Color(0xFF0B2A6F),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ],
  ),
),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
