// 📜 Historial emocional
// Lista todas las emociones guardadas y permite eliminarlas.

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<String> history = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      history = prefs.getStringList("history") ?? [];
    });
  }

  Future<void> _deleteRecord(int index) async {
    final prefs = await SharedPreferences.getInstance();
    history.removeAt(index);
    await prefs.setStringList("history", history);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text("Historial Emocional",
            style: TextStyle(color: Colors.teal[800])),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: history.isEmpty
          ? Center(child: Text("No hay registros aún"))
          : ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: ListTile(
                    title: Text(history[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteRecord(index),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
