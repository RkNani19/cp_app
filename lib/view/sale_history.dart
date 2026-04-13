import 'package:flutter/material.dart';

class SalesHistory extends StatelessWidget {
  const SalesHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sales History")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const Icon(Icons.history),
              title: Text("Sale #${index + 1}"),
              subtitle: const Text("Customer: John Doe"),
              trailing: const Text("₹50,000"),
            ),
          );
        },
      ),
    );
  }
}