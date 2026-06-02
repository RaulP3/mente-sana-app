// 📚 Recursos de bienestar
// Muestra ejercicios y artículos estáticos.
// Cada tarjeta tiene ícono y descripción breve.

import 'package:flutter/material.dart';

class ResourcesScreen extends StatelessWidget {
  final List<Map<String, String>> resources = [
    {
      "title": "Respiración profunda",
      "desc": "Inhala 4s, mantén 4s, exhala 6s",
    },
    {"title": "Meditación", "desc": "Permanece en silencio 5 minutos"},
    {"title": "Diario personal", "desc": "Escribe pensamientos positivos"},
    {"title": "Actividad física", "desc": "Camina 15 minutos"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text(
          "Recursos de Bienestar",
          style: TextStyle(color: Colors.teal[800]),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: resources.length,
        itemBuilder: (context, index) {
          final res = resources[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              leading: Icon(Icons.self_improvement, color: Colors.teal),
              title: Text(
                res["title"]!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(res["desc"]!),
            ),
          );
        },
      ),
    );
  }
}
