import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'chatbot_screen.dart';
import 'resources_screen.dart';
import 'profile_screen.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeContent(),
    ChatbotScreen(),
    ResourcesScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
          BottomNavigationBarItem(
              icon: Icon(Icons.library_books), label: "Recursos"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
        ],
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final List<Map<String, dynamic>> emotions = [
    {"emoji": "😊", "label": "Feliz"},
    {"emoji": "😐", "label": "Neutral"},
    {"emoji": "😔", "label": "Cansado"},
    {"emoji": "😰", "label": "Ansioso"},
    {"emoji": "😢", "label": "Triste"},
  ];

  Map<String, int> stats = {
    "Feliz": 0,
    "Neutral": 0,
    "Cansado": 0,
    "Ansioso": 0,
    "Triste": 0,
  };

  String estadoHoy = "😊"; // Estado inicial

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      stats["Feliz"] = prefs.getInt("Feliz") ?? 0;
      stats["Neutral"] = prefs.getInt("Neutral") ?? 0;
      stats["Cansado"] = prefs.getInt("Cansado") ?? 0;
      stats["Ansioso"] = prefs.getInt("Ansioso") ?? 0;
      stats["Triste"] = prefs.getInt("Triste") ?? 0;
      estadoHoy = prefs.getString("estadoHoy") ?? "😊";
    });
  }

  Future<void> _saveEmotion(String emotion, String emoji) async {
    final prefs = await SharedPreferences.getInstance();
    int current = prefs.getInt(emotion) ?? 0;
    await prefs.setInt(emotion, current + 1);
    await prefs.setString("estadoHoy", emoji);
    _loadStats(); // 🔄 refresca estadísticas y estado en tiempo real

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Seleccionaste: $emotion")),
    );
  }

  String getFormattedDate() {
    final now = DateTime.now();
    return DateFormat('EEEE, d \'de\' MMMM \'de\' y', 'es_ES').format(now);
  }

  Future<void> _callNumber(String number) async {
    final Uri telUri = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(telUri)) {
      await launchUrl(telUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No se pudo abrir el marcador")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF6F6),
      appBar: AppBar(
        title: const Text("Mente Sana", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal[700],
        elevation: 0,
        actions: const [
          Icon(Icons.notifications, color: Colors.yellow),
          SizedBox(width: 12),
          Icon(Icons.person, color: Colors.white),
          SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 👋 Saludo y fecha
            Text("Hola, Bienvenido/a 👋",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[900])),
            Text(getFormattedDate(),
                style: TextStyle(color: Colors.grey[700], fontSize: 16)),
            const SizedBox(height: 20),

            // 😄 Emojis en una sola fila
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.teal.shade100),
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  const Text("¿Cómo te sientes hoy?",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: emotions.map((emotion) {
                      return InkWell(
                        onTap: () =>
                            _saveEmotion(emotion["label"], emotion["emoji"]),
                        child: Text(emotion["emoji"],
                            style: const TextStyle(fontSize: 32)),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 💬 Botón para hablar con Mente Sana
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => ChatbotScreen()));
              },
              icon: const Icon(Icons.chat_bubble_outline, color: Colors.white),
              label: const Text("Hablar con Mente Sana",
                  style: TextStyle(color: Colors.white, fontSize: 18)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal[700],
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
            const SizedBox(height: 20),

            // 📊 Estadísticas dinámicas
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatCard(
                    "${stats.values.reduce((a, b) => a + b)}", "Sesiones"),
                _buildStatCard("3", "Días Seguidos"),
                _buildStatCard(estadoHoy, "Estado hoy"),
              ],
            ),
            const SizedBox(height: 20),

            // ⚡ Recursos rápidos con navegación
            const Text("Recursos Rápidos",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildQuickResource(Icons.phone, "Líneas de Crisis", () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Líneas de Crisis"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading:
                                const Icon(Icons.phone, color: Colors.teal),
                            title: const Text("SAPTEL: 800-472-7835"),
                            onTap: () => _callNumber("8004727835"),
                          ),
                          ListTile(
                            leading:
                                const Icon(Icons.phone, color: Colors.teal),
                            title:
                                const Text("IMSS Salud Mental: 800-623-2323"),
                            onTap: () => _callNumber("8006232323"),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cerrar"),
                        ),
                      ],
                    ),
                  );
                }),
                _buildQuickResource(Icons.self_improvement, "Ejercicios", () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => ResourcesScreen()));
                }),
                _buildQuickResource(Icons.menu_book, "Artículos", () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => ResourcesScreen()));
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Container(
      width: 100,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.teal.shade100),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.teal[900],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickResource(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.teal.shade100),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.teal, size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
