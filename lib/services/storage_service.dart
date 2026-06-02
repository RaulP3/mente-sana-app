// 💾 Servicio de almacenamiento local con SharedPreferences
// Guarda y lee datos simples como nombre, correo y emociones.

import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  // Guardar un valor
  Future<void> saveData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  // Leer un valor
  Future<String?> readData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  // Eliminar un valor
  Future<void> deleteData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
