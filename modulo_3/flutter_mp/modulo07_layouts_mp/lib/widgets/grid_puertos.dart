import 'package:flutter/material.dart';

class GridModulos extends StatelessWidget {
  const GridModulos({super.key});

  @override
  Widget build(BuildContext context) {
    final estados = List.generate(24, (i) {
      if (i < 12) return _EstadoModulo.completado;
      if (i < 15) return _EstadoModulo.enProgreso;
      if (i < 20) return _EstadoModulo.pendiente;
      return _EstadoModulo.bloqueado;
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Progreso por Capítulos (Módulos)',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(24, (i) {
            return Tooltip(
              message: 'Capítulo ${i + 1}: ${_descripcionEstado(estados[i])}',
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: _colorEstado(estados[i]).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _colorEstado(estados[i]),
                    width: 1.5,
                  ),
                ),
                child: Center(
                  child: Text(
                    'C${i + 1}',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: _colorEstado(estados[i]).shade900,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 12),
        // Leyenda del mapa
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _LeyendaItem(color: Colors.green, texto: 'Visto'),
            _LeyendaItem(color: Colors.orange, texto: 'En Curso'),
            _LeyendaItem(color: Colors.grey, texto: 'Pendiente'),
            _LeyendaItem(color: Colors.red, texto: 'Bloqueado'),
          ],
        ),
      ],
    );
  }

  MaterialColor _colorEstado(_EstadoModulo e) => switch (e) {
    _EstadoModulo.completado => Colors.green,
    _EstadoModulo.pendiente  => Colors.grey,
    _EstadoModulo.enProgreso  => Colors.orange,
    _EstadoModulo.bloqueado  => Colors.red,
  };

  String _descripcionEstado(_EstadoModulo e) => switch (e) {
    _EstadoModulo.completado => 'Completado',
    _EstadoModulo.pendiente  => 'Pendiente',
    _EstadoModulo.enProgreso  => 'En Progreso',
    _EstadoModulo.bloqueado  => 'Bloqueado por prerrequisitos',
  };
}

class _LeyendaItem extends StatelessWidget {
  final Color color;
  final String texto;
  const _LeyendaItem({required this.color, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 4),
        Text(texto, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500)),
      ],
    );
  }
}

enum _EstadoModulo { completado, pendiente, enProgreso, bloqueado }
