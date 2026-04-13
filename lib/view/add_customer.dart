import 'package:flutter/material.dart';

class AddCustomer extends StatefulWidget {
  const AddCustomer({super.key, required this.title});
  final String title;

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("AddCustomer")));
  }
}
