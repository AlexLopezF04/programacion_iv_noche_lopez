// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/catalogo_basicos.dart';
import 'widgets/etiqueta.dart';
import 'widgets/servicio_estado.dart';
import 'widgets/contador_limitado.dart';
import 'widgets/reloj.dart';
import 'widgets/indicador.dart';
import 'screens/pantalla_contexto.dart';

// ┌──────────────────────────────────────────────────────────────────┐
// │  Cambia este número y guarda (Ctrl+S) para navegar entre pasos. │
// │  1  Paso 1   StatelessWidget mínimo (Saludo al estudiante)      │
// │  2  Paso 1b  Catálogo de widgets de cursos                      │
// │  3  Paso 2   Categorías de cursos (Etiquetas con parámetros)    │
// │  4  Paso 3   Inscripción a curso (StatefulWidget / CursoEstado) │
// │  5  Paso 3b  Límites de estudiante (Parámetros en StatefulWidget)│
// │  6  Paso 4   Temporizador de Examen (Timer en ciclo de vida)    │
// │  7  Paso 5   BuildContext & Adaptabilidad                        │
// │  8  Paso 6   Métricas de Aprendizaje (Composición de widgets)   │
// └──────────────────────────────────────────────────────────────────┘
const int paso = 2;

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
    useMaterial3: true,
  ),
  home: switch (paso) {
    1 => const Scaffold(body: Center(child: Saludo())),
    2 => const CatalogoBasicos(),
    3 => const Scaffold(
      body: Center(
        child: Wrap(
          spacing:    12,
          runSpacing: 8,
          children: [
            Etiqueta(texto: 'Desarrollo', color: Colors.indigo),
            Etiqueta(texto: 'Diseño UX/UI', color: Colors.orange, relleno: true),
            Etiqueta(texto: 'Negocios', color: Colors.green),
            Etiqueta(texto: 'Marketing Digital', color: Colors.purple, fontSize: 16, relleno: true),
            Etiqueta(texto: 'Fotografía', color: Colors.blue, fontSize: 11),
          ],
        ),
      ),
    ),
    4 => const Scaffold(
      body: Center(
        child: CursoEstado(nombre: 'Curso de Flutter & Dart Avanzado'),
      ),
    ),
    5 => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ContadorLimitado(
              etiqueta: 'Exámenes Realizados (Máx 3)',
              limite:   3,
              color:    Colors.red,
              onLimite: () => debugPrint('¡Límite de exámenes alcanzado!'),
            ),
            const SizedBox(height: 40),
            ContadorLimitado(
              etiqueta: 'Cursos Inscritos',
              limite:   10,
              color:    Colors.indigo,
            ),
          ],
        ),
      ),
    ),
    6 => Scaffold(
      appBar: AppBar(title: const Text('Temporizador de Examen')),
      body: const Center(child: Reloj()),
    ),
    7 => const PantallaContexto(),
    8 => Scaffold(
      body: Center(
        child: Wrap(
          spacing: 32, runSpacing: 24,
          alignment: WrapAlignment.center,
          children: const [
            Indicador(label: 'Cursos activos', valor: '8',
                      color: Colors.indigo, icono: Icons.school),
            Indicador(label: 'Tareas pendientes',   valor: '2',
                      color: Colors.red,   icono: Icons.assignment_late,
                      subtitulo: 'Requieren atención'),
            Indicador(label: 'Horas de estudio',            valor: '42.5 hrs',
                      color: Colors.green, icono: Icons.timer),
            Indicador(label: 'Uptime de Plataforma',             valor: '99.9%',
                      color: Colors.teal, subtitulo: 'Últimos 30 días'),
          ],
        ),
      ),
    ),
    _ => Scaffold(body: Center(child: Text('Paso $paso no definido'))),
  },
));

class Saludo extends StatelessWidget {
  const Saludo({super.key});
  @override
  Widget build(BuildContext context) =>
      const Text('¡Bienvenido a tu Academia!', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.indigo));
}