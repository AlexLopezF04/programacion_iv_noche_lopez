// lib/screens/pantalla_dialogs.dart
import 'package:flutter/material.dart';

class PantallaDialogs extends StatelessWidget {
  const PantallaDialogs({super.key});

  void _mostrarSnackBar(BuildContext context, {bool esError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(esError
            ? 'Error: no se pudo matricular al curso'
            : 'Matrícula al curso procesada exitosamente'),
        backgroundColor: esError
            ? Theme.of(context).colorScheme.error
            : null,
        action: SnackBarAction(
          label:    'Deshacer',
          onPressed: () {},
        ),
        behavior:  SnackBarBehavior.floating,
        shape:     RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration:  const Duration(seconds: 3),
      ),
    );
  }

  Future<void> _mostrarConfirmacion(BuildContext context) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        icon:    const Icon(Icons.warning_amber, color: Colors.orange),
        title:   const Text('Dar de baja curso'),
        content: const Text(
          '¿Estás seguro de que deseas darte de baja de Especialidad en Flutter?\n'
          'Tu progreso se guardará pero perderás acceso a las videoclases.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child:     const Text('Cancelar'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(ctx).colorScheme.error,
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Darse de baja'),
          ),
        ],
      ),
    );

    if (!context.mounted) return;

    if (confirmar == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Curso dado de baja correctamente')),
      );
    }
  }

  Future<void> _mostrarFormulario(BuildContext context) async {
    final formKey = GlobalKey<FormState>();
    final ctrlNombre = TextEditingController();
    final ctrlCategoria = TextEditingController();

    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Sugerir nuevo curso'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller:  ctrlNombre,
                decoration:  const InputDecoration(labelText: 'Título del Curso'),
                validator:   (v) => v == null || v.isEmpty ? 'Campo requerido' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: ctrlCategoria,
                decoration: const InputDecoration(labelText: 'Categoría (Frontend, Backend, etc.)'),
                validator:  (v) => v == null || v.isEmpty ? 'Campo requerido' : null,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child:     const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.pop(ctx);
              }
            },
            child: const Text('Sugerir'),
          ),
        ],
      ),
    );

    if (!context.mounted) return;
    if (ctrlNombre.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sugerencia de curso "${ctrlNombre.text}" recibida')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs   = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title:           const Text('Acciones e Interacciones'),
        backgroundColor: cs.surfaceContainerHighest,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          // ── SnackBar ──────────────────────────────────────────────
          Text('Mensajes Rápidos (SnackBar)', style: text.labelLarge?.copyWith(color: cs.primary)),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: () => _mostrarSnackBar(context),
            icon:  const Icon(Icons.check_circle_outline),
            label: const Text('Matricularse (Éxito)'),
          ),
          const SizedBox(height: 8),
          FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: cs.error,
              foregroundColor: cs.onError,
            ),
            onPressed: () => _mostrarSnackBar(context, esError: true),
            icon:  const Icon(Icons.error_outline),
            label: const Text('Matricularse (Error)'),
          ),

          const Divider(height: 32),

          // ── AlertDialog ───────────────────────────────────────────
          Text('Alertas de Confirmación (Dialog)', style: text.labelLarge?.copyWith(color: cs.primary)),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: cs.error,
              side: BorderSide(color: cs.error),
            ),
            onPressed: () => _mostrarConfirmacion(context),
            icon:  const Icon(Icons.delete_outline),
            label: const Text('Dar de baja curso (Confirmación)'),
          ),
          const SizedBox(height: 8),
          FilledButton.tonal(
            onPressed: () => _mostrarFormulario(context),
            child: const Text('Sugerir curso (Formulario)'),
          ),
        ],
      ),
    );
  }
}

