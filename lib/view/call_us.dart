import 'package:flutter/material.dart';
import 'package:gjk_cp/view/dashboard_screen.dart';

class CallUs extends StatefulWidget {
  const CallUs({super.key, required this.title});
  final String title;

  @override
  State<CallUs> createState() => _CallUsState();
}

class _CallUsState extends State<CallUs> {
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
      child: Scaffold(body: Center(child: Text("Call Us"))),
    );
  }
}

