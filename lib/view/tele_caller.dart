import 'package:flutter/material.dart';

class TeleCaller extends StatefulWidget {
  final String title;

  const TeleCaller({super.key, required this.title});

  @override
  State<TeleCaller> createState() => _TeleCallerState();
}

class _TeleCallerState extends State<TeleCaller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("telle caller")));
  }
}
