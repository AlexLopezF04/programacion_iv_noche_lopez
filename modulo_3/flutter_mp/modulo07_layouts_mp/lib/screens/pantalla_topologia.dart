import 'package:flutter/material.dart';
import '../models/dispositivo.dart';
import '../widgets/chip_resumen.dart';
import '../widgets/fila_dispositivo.dart';

class PantallaTopologia extends StatelessWidget {
  const PantallaTopologia({super.key});

  @override
  Widget build(BuildContext context) {
    final dispositivos = [
      const InfoCurso(
        nombre: 'Desarrollo Flutter y Dart', categoria: 'mobile',
        instructor: 'Alex López', activo: true, leccionesNuevas: 2,
        etiquetas: ['Dart', 'Widgets', 'Mobile'], progreso: 75,
      ),
      const InfoCurso(
        nombre: 'Bases de Datos Relacionales', categoria: 'database',
        instructor: 'Ing. Gómez', activo: true, leccionesNuevas: 0,
        etiquetas: ['PostgreSQL', 'Query', 'L3'], progreso: 40,
      ),
      const InfoCurso(
        nombre: 'Backend con Node.js & Express', categoria: 'backend',
        instructor: 'Lic. Ruiz', activo: true, leccionesNuevas: 1,
        etiquetas: ['Express', 'REST', 'APIs'], progreso: 90,
      ),
      const InfoCurso(
        nombre: 'Maquetación Web con CSS y HTML', categoria: 'frontend',
        instructor: 'Profe Diaz', activo: true, leccionesNuevas: 3,
        etiquetas: ['HTML', 'CSS', 'Flexbox'], progreso: 100,
      ),
      const InfoCurso(
        nombre: 'Arquitectura Clean en Dart', categoria: 'backend',
        instructor: 'Ing. López', activo: false, leccionesNuevas: 0,
        etiquetas: ['Clean Code', 'Design Patterns'], progreso: 15,
      ),
    ];

    final totalAlertas = dispositivos.fold(0, (s, d) => s + d.leccionesNuevas);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Cursos Inscritos'),
        actions: [
          IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}),
          IconButton(icon: const Icon(Icons.refresh),     onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // Cabecera — Container con Row de ChipResumen (Pasos 1 + 3)
          Container(
            color:   Theme.of(context).colorScheme.surfaceContainerHighest,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                ChipResumen(
                  icono: Icons.school,
                  texto: '${dispositivos.length} cursos',
                  color: Colors.indigo,
                ),
                const SizedBox(width: 16),
                ChipResumen(
                  icono: Icons.circle,
                  texto: '${dispositivos.where((d) => d.activo).length} activos',
                  color: Colors.green,
                ),
                const SizedBox(width: 16),
                ChipResumen(
                  icono: Icons.notification_important,
                  texto: '$totalAlertas nuevas',
                  color: Colors.orange,
                ),
              ],
            ),
          ),

          // Lista — Expanded para que ocupe el espacio restante (Paso 3)
          Expanded(
            child: ListView.separated(
              padding:          const EdgeInsets.symmetric(vertical: 8),
              itemCount:        dispositivos.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder:      (_, i)  => FilaDispositivo(dispositivo: dispositivos[i]),
            ),
          ),
        ],
      ),
    );
  }
}

