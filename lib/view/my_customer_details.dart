import 'package:flutter/material.dart';

class MyCustomerDetails extends StatefulWidget {
  const MyCustomerDetails({super.key, required this.title});
  final String title;

  @override
  State<MyCustomerDetails> createState() => _MyCustomerDetailsState();
}

class _MyCustomerDetailsState extends State<MyCustomerDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("My customer Details"),
      ),
    );
  }
}
