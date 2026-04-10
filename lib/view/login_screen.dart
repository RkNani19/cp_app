import 'package:flutter/material.dart';
import 'package:gjk_cp/config/app_config.dart';
import 'package:gjk_cp/view/create_account.dart';
import 'package:gjk_cp/view/dashboard_screen.dart';
import 'package:gjk_cp/viewmodel/login_view_model.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.title});
  final String title;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  @override
  void initState() {
    super.initState();
    debugPrint("APP BASE URL => ${AppConfig.baseUrl}");

    Future.microtask(() {
      context.read<LoginViewModel>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFF3F5F9),
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
                          color: Color(0xFF021148),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "HOMES",
                        style: TextStyle(
                          color: Color(0xFFC8A573),
                          fontSize: 16,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 10),
                      Text(
                        "Customer Portal Login",
                        style: TextStyle(fontSize: 16,
                    fontWeight: FontWeight.w500, color: Color(0xFF5A667E),
                      ),
                      )
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
                              color: Color(0xFF021148),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),

                        const Text(
                          "Enter your credentials to access your account",
                          style: TextStyle(fontSize: 16, color:Color(0xFF7B8599)),
                        ),

                        SizedBox(height: 10),
                        Text(
                          "Customer ID/Mobile Number",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: mobileController,
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
                          controller: passwordController,
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
                              color: Color(0xFFC8A573),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),

                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (mobileController.text.isEmpty ||
                                  passwordController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Enter all fields")),
                                );
                                return;
                              }

                              final vm = Provider.of<LoginViewModel>(
                                context,
                                listen: false,
                              );

                              bool success = await vm.login(
                                mobileController.text.trim(),
                                passwordController.text.trim(),
                              );

                              print("LOGIN RESULT: $success");

                              if (success) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DashboardScreen(title: ''),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Invalid login or inactive user",
                                    ),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF021148),
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
                            color: Color(0xFFC8A573),
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
                      color: Color(0xFFE1E4EA),
                      borderRadius: BorderRadius.circular(15),
                      // boxShadow: [
                      //   BoxShadow(blurRadius: 4, color: Colors.black12),
                      // ],
                    ),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                        children: [
                          TextSpan(
                            text:
                                "Need help? Contact your sales representative or call us at ",
                                style:TextStyle(color: Color(0xFF657189),
                                 fontSize: 12.5,
                      height: 1.5,
                      fontWeight: FontWeight.w500,) 

                          ),
                          WidgetSpan(
                            child: GestureDetector(
                              onTap: () {},
                              child: Text(
                                "+91 9876543210",
                                style: TextStyle(
                                  color: Color(0xFF021148),
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
