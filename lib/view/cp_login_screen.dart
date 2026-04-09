import 'package:flutter/material.dart';

class CpLoginScreen extends StatefulWidget {
  const CpLoginScreen({super.key, required this.title});

  final String title;

  @override
  State<CpLoginScreen> createState() => _CpLoginScreenState();
}

class _CpLoginScreenState extends State<CpLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("CP Login Screen"),
    );
  }
}