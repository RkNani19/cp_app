import 'package:flutter/material.dart';
import 'package:gjk_cp/view/dashboard_screen.dart';

class CpLoginScreen extends StatefulWidget {
  const CpLoginScreen({super.key, required this.title});

  final String title;

  @override
  State<CpLoginScreen> createState() => _CpLoginScreenState();
}

class _CpLoginScreenState extends State<CpLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop:() async{
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => DashboardScreen(title: ""),),
      (route) => false,
      );
      return false;
    },
    child:  Center(
      child: Text("CP Login Screen"),
    )
    );
  }
}