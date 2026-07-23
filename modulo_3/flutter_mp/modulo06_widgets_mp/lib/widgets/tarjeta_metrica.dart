import 'package:flutter/material.dart';

class TarjetaMetrica extends StatelessWidget {
  final String   titulo;
  final String   valor;
  final IconData icono;
  final Color    colorIcono;
  final String?  subtitulo;

  const TarjetaMetrica({
    super.key,
    required this.titulo,
    required this.valor,
    required this.icono,
    required this.colorIcono,
    this.subtitulo,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding:    const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color:        colorIcono.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icono, color: colorIcono, size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(valor,  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  Text(titulo, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                  if (subtitulo != null)
                    Text(subtitulo!, style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
