import 'package:flutter/material.dart';

class FilaEstado extends StatelessWidget {
  final String nombre;
  final String detalle;
  final bool   activo;

  const FilaEstado({
    super.key,
    required this.nombre,
    required this.detalle,
    required this.activo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          // Ícono de estado
          Icon(
            activo ? Icons.check_circle : Icons.pause_circle_filled,
            color: activo ? Colors.green : Colors.orange,
            size:  20,
          ),
          const SizedBox(width: 12),

          // Expanded — el Column ocupa todo el espacio restante
          // Sin Expanded, un nombre largo desbordaría la Row
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize:       MainAxisSize.min,
              children: [
                Text(nombre,
                    style:    const TextStyle(fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis),
                Text(detalle,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // Chip de estado — queda pegado al borde derecho gracias a Expanded
          Container(
            padding:    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color:        (activo ? Colors.green : Colors.orange).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              activo ? 'En Curso' : 'Pausado',
              style: TextStyle(
                fontSize:   11,
                color:      activo ? Colors.green.shade700 : Colors.orange.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
