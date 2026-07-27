// lib/widgets/formulario_servidor.dart
import 'package:flutter/material.dart';

class FormularioServidor extends StatefulWidget {
  final void Function(Map<String, String> datos) onGuardar;
  const FormularioServidor({super.key, required this.onGuardar});

  @override
  State<FormularioServidor> createState() => _FormularioServidorState();
}

class _FormularioServidorState extends State<FormularioServidor> {
  final _formKey  = GlobalKey<FormState>();

  final _ctrlNombre  = TextEditingController();
  final _ctrlIp      = TextEditingController(); // Instructor
  final _ctrlPuerto  = TextEditingController(text: '12'); // Clases
  final _ctrlUsuario = TextEditingController(text: 'Desarrollo'); // Categoría

  final _focusIp      = FocusNode();
  final _focusPuerto  = FocusNode();
  final _focusUsuario = FocusNode();

  String _so  = 'Intermedio'; // Nivel
  bool   _ssl = true; // Publicado

  @override
  void dispose() {
    _ctrlNombre.dispose();
    _ctrlIp.dispose();
    _ctrlPuerto.dispose();
    _ctrlUsuario.dispose();
    _focusIp.dispose();
    _focusPuerto.dispose();
    _focusUsuario.dispose();
    super.dispose();
  }

  void _guardar() {
    if (!_formKey.currentState!.validate()) return;

    widget.onGuardar({
      'nombre':  _ctrlNombre.text,
      'ip':      _ctrlIp.text,
      'puerto':  _ctrlPuerto.text,
      'usuario': _ctrlUsuario.text,
      'so':      _so,
      'ssl':     _ssl.toString(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          // ── Título del Curso ──────────────────────────────────────
          TextFormField(
            controller:      _ctrlNombre,
            decoration:      const InputDecoration(
              labelText:  'Título del Curso',
              hintText:   'Desarrollo Flutter Avanzado',
              prefixIcon: Icon(Icons.school),
              border:     OutlineInputBorder(),
            ),
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) => _focusIp.requestFocus(),
            validator: (v) {
              if (v == null || v.trim().isEmpty) { return 'El título es obligatorio'; }
              if (v.length < 3) { return 'Mínimo 3 caracteres'; }
              return null;
            },
          ),
          const SizedBox(height: 12),

          // ── Instructor ──────────────────────────────────────────
          TextFormField(
            controller:      _ctrlIp,
            focusNode:       _focusIp,
            decoration:      const InputDecoration(
              labelText:  'Nombre del Instructor',
              hintText:   'Alex López',
              prefixIcon: Icon(Icons.person),
              border:     OutlineInputBorder(),
            ),
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) => _focusPuerto.requestFocus(),
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'El instructor es obligatorio';
              return null;
            },
          ),
          const SizedBox(height: 12),

          // ── Cantidad de Clases ─────────────────────────────────────
          TextFormField(
            controller:      _ctrlPuerto,
            focusNode:       _focusPuerto,
            decoration:      const InputDecoration(
              labelText:  'Cantidad de Lecciones',
              prefixIcon: Icon(Icons.list),
              border:     OutlineInputBorder(),
            ),
            keyboardType:    TextInputType.number,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) => _focusUsuario.requestFocus(),
            validator: (v) {
              final clases = int.tryParse(v ?? '');
              if (clases == null)              return 'Debe ser un número válido';
              if (clases < 1 || clases > 500)   return 'Cantidad entre 1 y 500 clases';
              return null;
            },
          ),
          const SizedBox(height: 12),

          // ── Categoría ─────────────────────────────────────────────
          TextFormField(
            controller:      _ctrlUsuario,
            focusNode:       _focusUsuario,
            decoration:      const InputDecoration(
              labelText:  'Categoría',
              prefixIcon: Icon(Icons.category),
              border:     OutlineInputBorder(),
            ),
            textInputAction: TextInputAction.next,
            validator: (v) =>
                v == null || v.trim().isEmpty ? 'La categoría es obligatoria' : null,
          ),
          const SizedBox(height: 12),

          // ── Nivel — DropdownButtonFormField ───────────────────────
          DropdownButtonFormField<String>(
            initialValue: _so,
            decoration: const InputDecoration(
              labelText:  'Nivel del Curso',
              prefixIcon: Icon(Icons.trending_up),
              border:     OutlineInputBorder(),
            ),
            items: [
              'Principiante', 'Intermedio', 'Avanzado', 'Especialización',
            ].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
            onChanged: (v) => setState(() => _so = v!),
          ),
          const SizedBox(height: 8),

          // ── Publicado — SwitchListTile ────────────────────────────
          SwitchListTile(
            title:     const Text('Publicado inmediatamente'),
            subtitle:  const Text('Hacer visible para los estudiantes'),
            value:     _ssl,
            onChanged: (v) => setState(() => _ssl = v),
            secondary: const Icon(Icons.visibility),
          ),
          const SizedBox(height: 16),

          // ── Botones ───────────────────────────────────────────────
          Row(children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => _formKey.currentState?.reset(),
                child: const Text('Limpiar'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: FilledButton.icon(
                onPressed: _guardar,
                icon:  const Icon(Icons.save),
                label: const Text('Guardar curso'),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}

