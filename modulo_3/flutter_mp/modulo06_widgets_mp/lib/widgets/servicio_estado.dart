import 'package:flutter/material.dart';

class CursoEstado extends StatefulWidget {
  final String nombre;
  const CursoEstado({super.key, required this.nombre});

  @override
  State<CursoEstado> createState() => _CursoEstadoState();
}

class _CursoEstadoState extends State<CursoEstado> {
  bool _inscrito = false;
  int _cambiosMatricula = 0;

  static const int _maxCambios = 3;

  void _toggleInscripcion() {
    setState(() {
      _inscrito = !_inscrito;
      _cambiosMatricula++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final enLimite = _cambiosMatricula >= _maxCambios;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _inscrito ? Icons.school : Icons.book_outlined,
            size: 72,
            color: _inscrito ? Colors.indigo : Colors.grey,
          ),
          const SizedBox(height: 8),

          Text(
            widget.nombre,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),

          Text(
            _inscrito ? 'Inscrito en el curso' : 'No inscrito',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: _inscrito ? Colors.indigo.shade700 : Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 16),

          if (!_inscrito)
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.amber.shade300),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 16),
                  SizedBox(width: 6),
                  Text(
                    'Curso recomendado para ti',
                    style: TextStyle(color: Colors.brown, fontSize: 13),
                  ),
                ],
              ),
            ),

          FilledButton.icon(
            onPressed: enLimite ? null : _toggleInscripcion,
            icon: Icon(_inscrito ? Icons.remove_circle_outline : Icons.add_circle_outline),
            label: Text(_inscrito ? 'Darse de baja' : 'Matricularse ahora'),
            style: FilledButton.styleFrom(
              backgroundColor: _inscrito
                  ? Colors.red.shade600
                  : Colors.indigo.shade600,
            ),
          ),
          const SizedBox(height: 12),

          Opacity(
            opacity: enLimite ? 0.4 : 1.0,
            child: Text(
              'Cambios de matrícula: $_cambiosMatricula / $_maxCambios',
              style: TextStyle(
                fontSize: 13,
                color: enLimite ? Colors.red : Colors.grey.shade600,
              ),
            ),
          ),

          if (enLimite)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'Límite de cambios de matrícula alcanzado',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.red.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

