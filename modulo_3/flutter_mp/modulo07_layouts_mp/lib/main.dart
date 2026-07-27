// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/pantalla_dashboard_estudiante.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
    useMaterial3: true,
  ),
  home: const PantallaDashboardEstudiante(),
));
