import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/log_ssh.dart';

class PantallaLogs extends StatelessWidget {
  final String servidorId;

  const PantallaLogs({super.key, required this.servidorId});

  @override
  Widget build(BuildContext context) {
    final logs = logsSimulados.where((l) => l.servidorId == servidorId).toList();
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title:           Text('Logs del servidor $servidorId'),
        backgroundColor: cs.primaryContainer,
        foregroundColor: cs.onPrimaryContainer,
      ),
      body: logs.isEmpty
          ? const Center(child: Text('No hay logs para este servidor'))
          : ListView.builder(
              itemCount: logs.length + 1,
              itemBuilder: (context, i) {
                if (i == logs.length) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: OutlinedButton.icon(
                      onPressed: () => context.pop(),
                      icon:  const Icon(Icons.arrow_back),
                      label: const Text('Volver al detalle'),
                    ),
                  );
                }
                final log = logs[i];
                final colorNivel = switch (log.nivel) {
                  'ERROR' => Colors.red,
                  'WARN'  => Colors.orange,
                  _       => Colors.green,
                };
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: colorNivel.withValues(alpha: 0.2),
                    radius: 18,
                    child: Text(log.nivel[0],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: colorNivel, fontSize: 12)),
                  ),
                  title:       Text(log.mensaje, style: const TextStyle(fontSize: 14)),
                  subtitle:    Text(log.timestamp, style: const TextStyle(fontSize: 11)),
                  isThreeLine: false,
                );
              },
            ),
    );
  }
}
