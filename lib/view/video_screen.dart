import 'package:flutter/material.dart';
import 'package:gjk_cp/view/dashboard_screen.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key, required this.title});
  final String title;

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
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
      child: Scaffold(
        backgroundColor: Color(0xFFF8F9FA),
        body: Center(child: Text("Video Screen"))),
    );
  }
}
