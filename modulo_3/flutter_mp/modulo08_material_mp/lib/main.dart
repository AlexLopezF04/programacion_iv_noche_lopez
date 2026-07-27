// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/pantalla_navegacion.dart';

void main() => runApp(const AppCursos());

class AppCursos extends StatefulWidget {
  const AppCursos({super.key});
  @override
  State<AppCursos> createState() => _AppCursosState();
}

class _AppCursosState extends State<AppCursos> {
  ThemeMode _themeMode = ThemeMode.system;
  Color _seedColor = const Color(0xFF1A237E);

  final List<({String nombre, Color color})> _paletas = const [
    (nombre: 'Índigo', color: Color(0xFF1A237E)),
    (nombre: 'Teal',   color: Colors.teal),
    (nombre: 'Verde',  color: Colors.green),
    (nombre: 'Naranja', color: Colors.orange),
    (nombre: 'Rojo',   color: Colors.red),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: _seedColor, brightness: Brightness.light),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: _seedColor, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      home: PantallaNavegacion(
        themeMode: _themeMode,
        seedColor: _seedColor,
        onThemeMode: (mode) => setState(() => _themeMode = mode),
        onSeedColor: (color) => setState(() => _seedColor = color),
        paletas: _paletas,
      ),
    );
  }
}
