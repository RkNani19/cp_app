import 'package:flutter/material.dart';

class CreativesScreen extends StatelessWidget {
  const CreativesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final images = List.generate(
        6, (index) => "https://picsum.photos/200?random=$index");

    return Scaffold(
      appBar: AppBar(title: const Text("Creatives")),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: images.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              images[index],
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}