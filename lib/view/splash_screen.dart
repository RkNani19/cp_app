import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';
import 'dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required String title});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

     SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white, // same as background
      statusBarIconBrightness: Brightness.dark, // icons visible
    ),
  );
    checkLogin();
  }

  void checkLogin() async {
    final prefs = await SharedPreferences.getInstance();

    bool isLoggedIn = prefs.getBool("isLoggedIn") ?? false;

    await Future.delayed(Duration(seconds: 1));

    if (isLoggedIn) {
      // ✅ Go to Dashboard
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen(title: '')),
      );
    } else {
      // ❌ Go to Login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen(title: '')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
  backgroundColor: Colors.white,

  /// 🔥 ADD THIS
  body: SafeArea(
    top: false, // ✅ remove top padding
    bottom: false,
    child: Center(
      child: Text(
        "GJKedia",
        style: TextStyle(
          fontSize: 34,
          color: Color(0xFF021148),
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),
);
  }
}
