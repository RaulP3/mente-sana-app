// 📱 Pantalla de bienvenida (Splash)
// Muestra el logo, nombre de la app y botones para iniciar sesión o crear cuenta.

import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'home_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 🧠 Logo de la aplicación
              Image.asset('assets/brain.png', height: 120),
              SizedBox(height: 20),

              // 🧩 Nombre y descripción
              Text('Mente Sana',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal[900])),
              SizedBox(height: 8),
              Text('Tu espacio de apoyo emocional',
                  style: TextStyle(color: Colors.grey[600], fontSize: 16)),
              SizedBox(height: 40),

              // 🔘 Botón para iniciar sesión
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => LoginScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                child: Text('Iniciar Sesión',
                    style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
              SizedBox(height: 16),

              // 🧾 Botón para crear cuenta
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => RegisterScreen()),
                  );
                },
                style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.teal),
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                child: Text('Crear Cuenta',
                    style: TextStyle(color: Colors.teal, fontSize: 18)),
              ),
              SizedBox(height: 20),

              // 🔗 Opción para continuar sin cuenta
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => HomeScreen()),
                  );
                },
                child: Text('Continuar sin cuenta',
                    style: TextStyle(color: Colors.grey[700])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
