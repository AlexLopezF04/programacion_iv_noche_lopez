// lib/screens/pantalla_ajustes.dart
import 'package:flutter/material.dart';
import 'pantalla_tema.dart';
import 'pantalla_appbar.dart';
import 'pantalla_dialogs.dart';
import '../widgets/catalogo_botones.dart';

class PantallaAjustes extends StatelessWidget {
  final ThemeMode themeMode;
  final Color     seedColor;
  final void Function(ThemeMode) onThemeMode;
  final void Function(Color)     onSeedColor;
  final List<({String nombre, Color color})> paletas;

  const PantallaAjustes({
    super.key,
    required this.themeMode,
    required this.seedColor,
    required this.onThemeMode,
    required this.onSeedColor,
    required this.paletas,
  });

  @override
  Widget build(BuildContext context) {
    final cs   = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title:           const Text('Apariencia'),
        backgroundColor: cs.surfaceContainerHighest,
      ),
      body: ListView(
        children: [

          // ── Sección: Tema ─────────────────────────────────────────
          _SeccionTitulo('Tema'),
          RadioGroup<ThemeMode>(
            groupValue: themeMode,
            onChanged: (v) => onThemeMode(v!),
            child: Column(
              children: [
                ...[
                  (label: 'Sistema', mode: ThemeMode.system, icon: Icons.brightness_auto),
                  (label: 'Claro',   mode: ThemeMode.light,  icon: Icons.light_mode),
                  (label: 'Oscuro',  mode: ThemeMode.dark,   icon: Icons.dark_mode),
                ].map((opcion) => RadioListTile<ThemeMode>(
                  title:     Text(opcion.label),
                  secondary: Icon(opcion.icon),
                  value:     opcion.mode,
                )),
              ],
            ),
          ),

          const Divider(),

          // ── Sección: Color de acento ──────────────────────────────
          _SeccionTitulo('Color de acento'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Wrap(
              spacing: 12,
              children: paletas.map((p) {
                final seleccionado = seedColor == p.color;
                return GestureDetector(
                  onTap: () => onSeedColor(p.color),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width:  48,
                        height: 48,
                        decoration: BoxDecoration(
                          color:  p.color,
                          shape:  BoxShape.circle,
                          border: seleccionado
                              ? Border.all(color: cs.onSurface, width: 3)
                              : null,
                          boxShadow: seleccionado
                              ? [BoxShadow(
                                  color:      p.color.withValues(alpha: 0.5),
                                  blurRadius: 8,
                                )]
                              : null,
                        ),
                        child: seleccionado
                            ? const Icon(Icons.check, color: Colors.white)
                            : null,
                      ),
                      const SizedBox(height: 4),
                      Text(p.nombre, style: text.labelSmall),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          const Divider(),

          // ── Sección: Vista previa ─────────────────────────────────
          _SeccionTitulo('Vista previa'),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Curso de Flutter & Dart',
                            style: text.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold)),
                        Text('Instructor: Alex López · Módulo 1',
                            style: text.bodySmall?.copyWith(
                                color: cs.onSurfaceVariant)),
                        const SizedBox(height: 12),
                        Row(children: [
                          FilledButton.icon(
                            onPressed: () {},
                            icon:  const Icon(Icons.play_circle_fill, size: 16),
                            label: const Text('Clase'),
                          ),
                          const SizedBox(width: 8),
                          OutlinedButton(
                            onPressed: () {},
                            child: const Text('Temario'),
                          ),
                          const SizedBox(width: 8),
                          TextButton(
                            onPressed: () {},
                            child: const Text('Calificar'),
                          ),
                        ]),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text('Colores activos:',
                    style: text.labelMedium?.copyWith(
                        color: cs.onSurfaceVariant)),
                const SizedBox(height: 6),
                Row(children: [
                  _CirculoColor(color: cs.primary,                label: 'P'),
                  _CirculoColor(color: cs.secondary,              label: 'S'),
                  _CirculoColor(color: cs.tertiary,               label: 'T'),
                  _CirculoColor(color: cs.error,                  label: 'E'),
                  _CirculoColor(color: cs.surfaceContainerHighest, label: 'Sf'),
                ]),
              ],
            ),
          ),

          const Divider(height: 32),

          _SeccionTitulo('Componentes del Módulo 8'),
          ListTile(
            leading: const Icon(Icons.palette_outlined),
            title: const Text('Paso 2: Modo de Tema'),
            subtitle: const Text('Tema claro, oscuro y dinámico'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PantallaTema(themeMode: themeMode, onToggle: onThemeMode))),
          ),
          ListTile(
            leading: const Icon(Icons.view_day_outlined),
            title: const Text('Paso 3: AppBar y SliverAppBar'),
            subtitle: const Text('Large AppBar colapsable al hacer scroll'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PantallaAppBar())),
          ),
          ListTile(
            leading: const Icon(Icons.smart_button_outlined),
            title: const Text('Paso 4: Variantes de Botones'),
            subtitle: const Text('Filled, Tonal, Elevated, Outlined, Text'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CatalogoBotones())),
          ),
          ListTile(
            leading: const Icon(Icons.announcement_outlined),
            title: const Text('Paso 6: Diálogos y Avisos'),
            subtitle: const Text('SnackBar y AlertDialog de matrícula'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PantallaDialogs())),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _SeccionTitulo extends StatelessWidget {
  final String texto;
  const _SeccionTitulo(this.texto);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
    child: Text(
      texto,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
        color: Theme.of(context).colorScheme.primary,
      ),
    ),
  );
}

class _CirculoColor extends StatelessWidget {
  final Color  color;
  final String label;
  const _CirculoColor({required this.color, required this.label});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(right: 8),
    child: CircleAvatar(
      radius:          16,
      backgroundColor: color,
      child: Text(
        label,
        style: TextStyle(
          color: color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
          fontSize:   10,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
