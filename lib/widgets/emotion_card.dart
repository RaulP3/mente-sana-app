// 🧩 Widget para mostrar una tarjeta de emoción
import 'package:flutter/material.dart';

class EmotionCard extends StatelessWidget {
  final String emoji;
  final String label;

  EmotionCard({required this.emoji, required this.label});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: TextStyle(fontSize: 40)),
            SizedBox(height: 8),
            Text(label,
                style: TextStyle(fontSize: 18, color: Colors.teal[700])),
          ],
        ),
      ),
    );
  }
}
