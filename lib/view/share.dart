import 'package:flutter/material.dart';

class Share extends StatefulWidget {
  const Share({super.key, required this.title});

  final String title;

  @override
  State<Share> createState() => _ShareState();
}

class _ShareState extends State<Share>{
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: 
      Text("share")
    ),
  );
  }
}
