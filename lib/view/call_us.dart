import 'package:flutter/material.dart';

class CallUs extends StatefulWidget {
  const CallUs({super.key, required this.title});
  final String title;

  @override
  State<CallUs> createState() => _CallUsState();
}

class _CallUsState extends State<CallUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Call Us")));
  }
}
