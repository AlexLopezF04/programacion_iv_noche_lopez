import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screens/pantalla_dashboard.dart';

/// Proyecto completo integrado
/// NavigationBar con dos pestañas: Servidores (CRUD + búsqueda) y Métricas (Async)
void main() {
  runApp(const ProviderScope(child: AppProyecto()));
}

class AppProyecto extends StatelessWidget {
  const AppProyecto({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestor de Servidores',
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const PantallaDashboard(),
    );
  }
}
