// lib/screens/pantalla_navegacion.dart
import 'package:flutter/material.dart';
import 'pantalla_ajustes.dart';

class PantallaNavegacion extends StatefulWidget {
  final ThemeMode themeMode;
  final Color     seedColor;
  final void Function(ThemeMode) onThemeMode;
  final void Function(Color)     onSeedColor;
  final List<({String nombre, Color color})> paletas;

  const PantallaNavegacion({
    super.key,
    required this.themeMode,
    required this.seedColor,
    required this.onThemeMode,
    required this.onSeedColor,
    required this.paletas,
  });

  @override
  State<PantallaNavegacion> createState() => _PantallaNavegacionState();
}

class _PantallaNavegacionState extends State<PantallaNavegacion> {
  int _indice = 0;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title:           const Text('Academia Online'),
        backgroundColor: cs.surfaceContainerHighest,
      ),
      body: IndexedStack(
        index: _indice,
        children: [
          const _PantallaDashboard(),
          const _PantallaCursos(),
          const _PantallaAlertas(),
          PantallaAjustes(
            themeMode: widget.themeMode,
            seedColor: widget.seedColor,
            onThemeMode: widget.onThemeMode,
            onSeedColor: widget.onSeedColor,
            paletas: widget.paletas,
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex:         _indice,
        onDestinationSelected: (i) => setState(() => _indice = i),
        indicatorColor: cs.primaryContainer,
        destinations: const [
          NavigationDestination(
            icon:         Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label:        'Dashboard',
          ),
          NavigationDestination(
            icon:         Icon(Icons.school_outlined),
            selectedIcon: Icon(Icons.school),
            label:        'Cursos',
          ),
          NavigationDestination(
            icon:         Badge(label: Text('3'), child: Icon(Icons.notifications_outlined)),
            selectedIcon: Badge(label: Text('3'), child: Icon(Icons.notifications)),
            label:        'Mensajes',
          ),
          NavigationDestination(
            icon:         Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label:        'Ajustes',
          ),
        ],
      ),
    );
  }
}

// ─── Pantallas de cada pestaña ────────────────────────────────────────────

class _PantallaDashboard extends StatelessWidget {
  const _PantallaDashboard();

  @override
  Widget build(BuildContext context) {
    final cs   = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Progreso de Aprendizaje', style: text.headlineSmall),
        const SizedBox(height: 16),
        Row(children: [
          Expanded(child: _TarjetaMetrica(titulo: 'Cursos Inscritos', valor: '8',  icono: Icons.school,       color: cs.primaryContainer)),
          const SizedBox(width: 8),
          Expanded(child: _TarjetaMetrica(titulo: 'Tareas Pendientes', valor: '3',  icono: Icons.assignment,  color: cs.errorContainer)),
        ]),
        const SizedBox(height: 8),
        Row(children: [
          Expanded(child: _TarjetaMetrica(titulo: 'Progreso Total',   valor: '78.5%', icono: Icons.trending_up, color: cs.tertiaryContainer)),
          const SizedBox(width: 8),
          Expanded(child: _TarjetaMetrica(titulo: 'Horas de Video',  valor: '42.5 h', icono: Icons.play_circle, color: cs.secondaryContainer)),
        ]),
      ],
    );
  }
}

class _TarjetaMetrica extends StatelessWidget {
  final String titulo;
  final String valor;
  final IconData icono;
  final Color    color;

  const _TarjetaMetrica({
    required this.titulo,
    required this.valor,
    required this.icono,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icono, size: 28),
            const SizedBox(height: 8),
            Text(valor,  style: text.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
            Text(titulo, style: text.bodySmall),
          ],
        ),
      ),
    );
  }
}

class _PantallaCursos extends StatelessWidget {
  const _PantallaCursos();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: 6,
      itemBuilder: (ctx, i) => Card(
        child: ListTile(
          leading:  Icon(Icons.school, color: cs.primary),
          title:    Text('Curso de Flutter & Dart 0${i + 1}'),
          subtitle: Text('Instructor: Alex López · Módulo ${i + 1}'),
          trailing: Icon(Icons.chevron_right, color: cs.onSurfaceVariant),
          onTap: () {},
        ),
      ),
    );
  }
}

class _PantallaAlertas extends StatelessWidget {
  const _PantallaAlertas();

  @override
  Widget build(BuildContext context) {
    final cs   = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    const alertas = [
      (curso: 'Examen de Dart',       mensaje: 'Calificación reprobatoria (< 6.0)', nivel: 'CRÍTICO'),
      (curso: 'Proyecto de Interfaces',mensaje: 'Pendiente de entrega hoy 23:59',   nivel: 'AVISO'),
      (curso: 'Foro de Discusión',    mensaje: 'Nuevo mensaje del instructor',    nivel: 'NUEVO'),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: alertas.length,
      itemBuilder: (ctx, i) {
        final alerta = alertas[i];
        final esCritico = alerta.nivel == 'CRÍTICO';

        return Card(
          color: esCritico ? cs.errorContainer : cs.tertiaryContainer,
          child: ListTile(
            leading: Icon(
              esCritico ? Icons.error : Icons.info,
              color: esCritico ? cs.onErrorContainer : cs.onTertiaryContainer,
            ),
            title: Text(alerta.curso,
                style: text.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            subtitle: Text(alerta.mensaje),
            trailing: Chip(
              label: Text(alerta.nivel, style: const TextStyle(fontSize: 11)),
              backgroundColor: esCritico ? cs.error : cs.tertiary,
              labelStyle: TextStyle(
                color: esCritico ? cs.onError : cs.onTertiary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}

