import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/log_ssh.dart';
import '../models/servidor_ssh.dart';

class PantallaLogs extends StatelessWidget {
  final String servidorId;

  const PantallaLogs({super.key, required this.servidorId});

  @override
  Widget build(BuildContext context) {
    final logs = logsSimulados.where((l) => l.servidorId == servidorId).toList();
    final cs = Theme.of(context).colorScheme;
    final curso = servidoresSimulados.firstWhere(
      (s) => s.id == servidorId,
      orElse: () => ServidorSSH(id: servidorId, nombre: 'Curso $servidorId', ip: '', puerto: 0, ssl: false),
    );

    return Scaffold(
      appBar: AppBar(
        title:           Text('Lecciones: ${curso.nombre}'),
        backgroundColor: cs.primaryContainer,
        foregroundColor: cs.onPrimaryContainer,
      ),
      body: logs.isEmpty
          ? const Center(child: Text('No hay lecciones para este curso'))
          : ListView.builder(
              itemCount: logs.length + 1,
              itemBuilder: (context, i) {
                if (i == logs.length) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: OutlinedButton.icon(
                      onPressed: () => context.pop(),
                      icon:  const Icon(Icons.arrow_back),
                      label: const Text('Volver al curso'),
                    ),
                  );
                }
                final log = logs[i];
                final colorNivel = switch (log.nivel) {
                  'PENDIENTE' => Colors.grey,
                  'PROGRESO'  => Colors.orange,
                  _           => Colors.green,
                };
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: colorNivel.withValues(alpha: 0.1),
                    radius: 18,
                    child: Icon(
                      switch (log.nivel) {
                        'PENDIENTE' => Icons.radio_button_unchecked,
                        'PROGRESO'  => Icons.play_circle_outline,
                        _           => Icons.check_circle,
                      },
                      color: colorNivel,
                      size: 20,
                    ),
                  ),
                  title:       Text(log.mensaje, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                  subtitle:    Text(log.timestamp, style: TextStyle(fontSize: 11, color: colorNivel)),
                  isThreeLine: false,
                );
              },
            ),
    );
  }
}

