import 'package:flutter/material.dart';
import '../models/dispositivo.dart';
import '../widgets/avatar_badge.dart';
import '../widgets/fila_estadisticas.dart';
import '../widgets/tarjeta_trafico.dart';
import '../widgets/grid_puertos.dart';
import '../widgets/tarjeta_log.dart';

class PantallaDashboardEstudiante extends StatefulWidget {
  const PantallaDashboardEstudiante({super.key});

  @override
  State<PantallaDashboardEstudiante> createState() => _PantallaDashboardEstudianteState();
}

class _PantallaDashboardEstudianteState extends State<PantallaDashboardEstudiante> {
  // Curso seleccionado actualmente para ver sus capítulos
  String _cursoSeleccionado = 'Desarrollo Flutter y Dart Avanzado';

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    // Lista de cursos del alumno (Requerimiento 1)
    final misCursos = [
      const InfoCurso(
        nombre: 'Desarrollo Flutter y Dart Avanzado',
        categoria: 'mobile',
        instructor: 'Alex López',
        activo: true,
        leccionesNuevas: 2,
        etiquetas: ['Flutter', 'Dart', 'Riverpod'],
        progreso: 75,
      ),
      const InfoCurso(
        nombre: 'Bases de Datos Relacionales (SQL)',
        categoria: 'database',
        instructor: 'Ing. Gómez',
        activo: true,
        leccionesNuevas: 0,
        etiquetas: ['Postgres', 'SQL', 'Indexes'],
        progreso: 40,
      ),
      const InfoCurso(
        nombre: 'Backend con Node.js & Express',
        categoria: 'backend',
        instructor: 'Lic. Ruiz',
        activo: true,
        leccionesNuevas: 1,
        etiquetas: ['Node', 'Express', 'JWT'],
        progreso: 90,
      ),
      const InfoCurso(
        nombre: 'Clean Architecture y Clean Code',
        categoria: 'backend',
        instructor: 'Ing. López',
        activo: false,
        leccionesNuevas: 0,
        etiquetas: ['Clean Code', 'SOLID'],
        progreso: 15,
      ),
    ];

    // Gráfico de minutos de estudio diarios (Requerimiento 2)
    final minutosEstudio = [
      const _MinutosDia('Lun', 45),
      const _MinutosDia('Mar', 65),
      const _MinutosDia('Mié', 20),
      const _MinutosDia('Jue', 80),
      const _MinutosDia('Vie', 55),
      const _MinutosDia('Sáb', 95),
      const _MinutosDia('Dom', 35),
    ];

    // Historial de lecciones reproducidas recientemente (Requerimiento 4)
    final historialLecciones = [
      const _LogItem(nivel: 'INFO', componente: 'Módulo 4: State', mensaje: 'Clase vista: Introducción a ChangeNotifierProvider', minutosAtras: 5),
      const _LogItem(nivel: 'ERROR', componente: 'Examen de Dart', mensaje: 'Calificación: 4/10 — Debes repetir el cuestionario para avanzar', minutosAtras: 25),
      const _LogItem(nivel: 'WARN', componente: 'Módulo 3: UI', mensaje: 'Lección pendiente: Creación de Layouts Responsivos', minutosAtras: 60),
      const _LogItem(nivel: 'INFO', componente: 'Módulo 2: Sintaxis', mensaje: 'Clase vista: Estructuras de control y Colecciones', minutosAtras: 120),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.school, size: 28),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Plataforma Académica', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text('Panel del Estudiante', style: TextStyle(fontSize: 11, color: cs.secondary)),
              ],
            ),
          ],
        ),
        backgroundColor: cs.primaryContainer,
        foregroundColor: cs.onPrimaryContainer,
        elevation: 2,
        actions: [
          IconButton(
            icon: const Badge(
              label: Text('3'),
              child: Icon(Icons.notifications_outlined),
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isLargeScreen = constraints.maxWidth >= 800;

          final panelIzquierdo = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Perfil del estudiante ─────────────────────────────────
              Card(
                elevation: 3,
                margin: const EdgeInsets.all(12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [Colors.indigo.shade100, Colors.indigo.shade100.withValues(alpha: 0.6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const AvatarBadge(nombre: 'Alex López', alertas: 3, activo: true),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '¡Hola, Alex López!',
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.indigo.shade900,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: cs.primary,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Text(
                                      'Nivel 12',
                                      style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    '🔥 5 días de racha',
                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.orange),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              // Barra de XP del nivel
                              Row(
                                children: [
                                  Expanded(
                                    child: LinearProgressIndicator(
                                      value: 0.72,
                                      backgroundColor: Colors.white24,
                                      color: cs.primary,
                                      minHeight: 6,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '720/1000 XP',
                                    style: TextStyle(fontSize: 10, color: Colors.indigo.shade900.withValues(alpha: 0.8)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // ── Estadísticas de Estudio ─────────────────────────────
              const FilaEstadisticas(),

              const SizedBox(height: 8),

              // ── Gráfico de Minutos de Estudio Diarios (Requerimiento 2) ──
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Minutos de Estudio Diarios',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      'Meta Semanal: 420m',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: cs.primary),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 155,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: minutosEstudio.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 8),
                  itemBuilder: (ctx, i) {
                    final item = minutosEstudio[i];
                    return TarjetaTrafico(nombreInterfaz: item.dia, uso: item.minutos);
                  },
                ),
              ),

              const SizedBox(height: 16),

              // ── Curso Destacado / Continuar Viendo ─────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'Continuar Aprendiendo',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: cs.primary),
                ),
              ),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                        gradient: LinearGradient(
                          colors: [Colors.indigo.shade800, Colors.purple.shade700],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            right: -20, bottom: -20,
                            child: Icon(Icons.school, size: 120, color: Colors.white.withValues(alpha: 0.1)),
                          ),
                          Center(
                            child: CircleAvatar(
                              radius: 28,
                              backgroundColor: Colors.white.withValues(alpha: 0.9),
                              child: IconButton(
                                icon: const Icon(Icons.play_arrow, size: 32, color: Colors.indigo),
                                onPressed: () {},
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 8, left: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(4)),
                              child: const Text(
                                'Clase 14: Gestión de layouts responsivos',
                                style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Desarrollo Flutter y Dart Avanzado',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Último acceso: hace 5 minutos · 15 clases restantes',
                            style: TextStyle(fontSize: 11, color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ── Lista de Cursos del Alumno (Requerimiento 1) ──────────
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'Mis Cursos Inscritos',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: misCursos.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (ctx, i) {
                  final curso = misCursos[i];
                  final isSelected = curso.nombre == _cursoSeleccionado;

                  return Container(
                    color: isSelected ? cs.primaryContainer.withValues(alpha: 0.3) : null,
                    child: ListTile(
                      onTap: () {
                        setState(() {
                          _cursoSeleccionado = curso.nombre;
                        });
                      },
                      leading: CircleAvatar(
                        backgroundColor: curso.activo ? cs.primaryContainer : Colors.grey.shade200,
                        child: Icon(
                          Icons.menu_book,
                          color: curso.activo ? cs.primary : Colors.grey,
                          size: 20,
                        ),
                      ),
                      title: Text(
                        curso.nombre,
                        style: TextStyle(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                          color: isSelected ? cs.primary : null,
                        ),
                      ),
                      subtitle: Text(
                        'Progreso: ${curso.progreso}% · ${curso.instructor}',
                        style: const TextStyle(fontSize: 12),
                      ),
                      trailing: Icon(
                        isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                        color: isSelected ? cs.primary : Colors.grey,
                        size: 16,
                      ),
                    ),
                  );
                },
              ),
            ],
          );

          final panelDerecho = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Vista de Cuadrícula de Capítulos (Requerimiento 3) ────
              Card(
                elevation: 3,
                margin: const EdgeInsets.all(12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.view_module, color: cs.primary),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _cursoSeleccionado,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 24),
                      const GridModulos(),
                    ],
                  ),
                ),
              ),

              // ── Historial de Lecciones Reproducidas (Requerimiento 4) ──
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'Historial Reciente de Actividades',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: historialLecciones.length,
                itemBuilder: (ctx, i) {
                  final log = historialLecciones[i];
                  return TarjetaLog(
                    nivel: log.nivel,
                    componente: log.componente,
                    mensaje: log.mensaje,
                    timestamp: DateTime.now().subtract(Duration(minutes: log.minutosAtras)),
                  );
                },
              ),
            ],
          );

          if (isLargeScreen) {
            // Diseño de Dos Columnas para Tablets/Desktops (Requerimiento 5)
            return SingleChildScrollView(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 5, child: panelIzquierdo),
                  Expanded(flex: 4, child: panelDerecho),
                ],
              ),
            );
          } else {
            // Diseño de Una Columna para Celulares (Requerimiento 5)
            return SingleChildScrollView(
              child: Column(
                children: [
                  panelIzquierdo,
                  const Divider(height: 32, thickness: 2, indent: 16, endIndent: 16),
                  panelDerecho,
                  const SizedBox(height: 24),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class _MinutosDia {
  final String dia;
  final double minutos;
  const _MinutosDia(this.dia, this.minutos);
}

class _LogItem {
  final String nivel;
  final String componente;
  final String mensaje;
  final int minutosAtras;
  const _LogItem({
    required this.nivel,
    required this.componente,
    required this.mensaje,
    required this.minutosAtras,
  });
}
