import 'package:flutter/material.dart';
import '../models/dispositivo.dart';
import 'avatar_badge.dart';

class FilaDispositivo extends StatelessWidget {
  final InfoDispositivo dispositivo;

  const FilaDispositivo({super.key, required this.dispositivo});

  IconData get _icono => switch (dispositivo.tipo) {
    'router'   => Icons.router,
    'switch'   => Icons.device_hub,
    'server'   => Icons.dns,
    'endpoint' => Icons.computer,
    _          => Icons.devices,
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // AvatarBadge — Stack del Paso 4
          AvatarBadge(
            nombre:  dispositivo.nombre,
            alertas: dispositivo.alertas,
            activo:  dispositivo.activo,
          ),

          const SizedBox(width: 12),

          // Column: nombre, IP y Wrap de etiquetas
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        dispositivo.nombre,
                        style:    const TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(_icono, size: 16, color: Colors.grey.shade500),
                  ],
                ),
                Text(dispositivo.ip,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 4, runSpacing: 4,
                  children: dispositivo.etiquetas.map((tag) =>
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color:        Colors.indigo.shade50,
                        borderRadius: BorderRadius.circular(4),
                        border:       Border.all(color: Colors.indigo.shade200),
                      ),
                      child: Text(tag,
                          style: TextStyle(
                              fontSize:   10,
                              color:      Colors.indigo.shade700,
                              fontWeight: FontWeight.w500)),
                    ),
                  ).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
