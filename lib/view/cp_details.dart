import 'package:flutter/material.dart';

class CpDetails extends StatefulWidget {
  const CpDetails({super.key, required this.title});

  final String title;

  @override
  State<CpDetails> createState() => _CpDetailsState();
}

class _CpDetailsState extends State<CpDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'CP Details Screen',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
