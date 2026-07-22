import 'package:flutter/material.dart';

class GridPuertos extends StatelessWidget {
  const GridPuertos({super.key});

  @override
  Widget build(BuildContext context) {
    final estados = List.generate(24, (i) {
      if (i < 10) return _EstadoPuerto.activo;
      if (i < 16) return _EstadoPuerto.libre;
      if (i < 20) return _EstadoPuerto.error;
      return _EstadoPuerto.bloqueado;
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Puertos del Switch')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(24, (i) {
            return Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: _colorEstado(estados[i]),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: _colorEstado(estados[i]).withValues(alpha: 0.5),
                ),
              ),
              child: Center(
                child: Text(
                  '${i + 1}',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: _textoColor(estados[i]),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Color _colorEstado(_EstadoPuerto e) => switch (e) {
    _EstadoPuerto.activo    => Colors.green,
    _EstadoPuerto.libre     => Colors.grey.shade300,
    _EstadoPuerto.error     => Colors.orange,
    _EstadoPuerto.bloqueado => Colors.red,
  };

  Color _textoColor(_EstadoPuerto e) => switch (e) {
    _EstadoPuerto.activo    => Colors.white,
    _EstadoPuerto.libre     => Colors.grey.shade600,
    _EstadoPuerto.error     => Colors.white,
    _EstadoPuerto.bloqueado => Colors.white,
  };
}

enum _EstadoPuerto { activo, libre, error, bloqueado }
