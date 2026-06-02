// 💬 Chatbot de apoyo emocional
// No usa IA real, solo respuestas predefinidas.
// Simula una conversación empática con el usuario.

import 'package:flutter/material.dart';

class ChatbotScreen extends StatefulWidget {
  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

  void _sendMessage(String text) {
    setState(() {
      _messages.add({"sender": "user", "text": text});
      _messages.add({"sender": "bot", "text": _getResponse(text)});
    });
    _controller.clear();
  }

  String _getResponse(String input) {
    if (input.toLowerCase().contains("triste")) {
      return "Lamento que te sientas así. Recuerda que es normal tener días difíciles.";
    } else if (input.toLowerCase().contains("ansioso")) {
      return "Prueba realizar ejercicios de respiración profunda.";
    } else if (input.toLowerCase().contains("feliz")) {
      return "Excelente. Continúa realizando actividades que te hagan sentir bien.";
    } else {
      return "Gracias por compartir cómo te sientes.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text("Chat de Apoyo", style: TextStyle(color: Colors.teal[800])),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg["sender"] == "user";
                return Align(
                  alignment: isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.teal[200] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      msg["text"]!,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Escribe cómo te sientes...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.teal),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      _sendMessage(_controller.text);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
