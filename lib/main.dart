// 🧠 Punto de entrada de la aplicación
// Se inicializa intl para mostrar fechas en español.

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart'; // ✅ Importación necesaria
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Inicializa el idioma español para DateFormat
  await initializeDateFormatting('es_ES', null);

  runApp(MenteSanaApp());
}

class MenteSanaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mente Sana',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: SplashScreen(),
    );
  }
}
