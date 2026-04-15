import 'package:flutter/material.dart';

class ViewAllProjects extends StatelessWidget {
  const ViewAllProjects({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Projects")),
      body: const Center(
        child: Text("View All Content Here"),
      ),
    );
  }
}