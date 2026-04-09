import 'package:flutter/material.dart';

class Enquiry extends StatefulWidget{
  const Enquiry({super.key, required this.title});
  final String title;

  @override
  State<Enquiry> createState() => _EnquiryState();
}

class _EnquiryState extends State<Enquiry> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(body: Center(child: Text("Enquiry")));
  }
}