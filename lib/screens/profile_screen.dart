// 👤 Perfil del usuario
// Muestra nombre y correo guardados en SharedPreferences.
// Permite editar perfil o cerrar sesión.

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'splash_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? name;
  String? email;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // 📥 Cargar datos guardados
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString("name") ?? "Usuario Demo";
      email = prefs.getString("email") ?? "demo@correo.com";
    });
  }

  // 🚪 Cerrar sesión (borra datos y regresa al Splash)
  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => SplashScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text("Perfil", style: TextStyle(color: Colors.teal[800])),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.teal[200],
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(name ?? "",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[900])),
            SizedBox(height: 8),
            Text(email ?? "", style: TextStyle(color: Colors.grey[700])),
            SizedBox(height: 40),

            // ✏️ Botón editar perfil (MVP: no implementado aún)
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Función de editar perfil en MVP")),
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              child: Text("Editar Perfil",
                  style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
            SizedBox(height: 16),

            // 🚪 Botón cerrar sesión
            OutlinedButton(
              onPressed: _logout,
              style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.teal),
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              child: Text("Cerrar Sesión",
                  style: TextStyle(color: Colors.teal, fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
