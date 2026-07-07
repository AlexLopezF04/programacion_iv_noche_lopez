import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/servidor_ssh.dart';

class PantallaServidores extends StatelessWidget {
  const PantallaServidores({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title:           const Text('Servidores'),
        backgroundColor: cs.primaryContainer,
        foregroundColor: cs.onPrimaryContainer,
      ),
      body: ListView.builder(
        itemCount:   servidoresSimulados.length,
        itemBuilder: (context, i) {
          final s = servidoresSimulados[i];
          return ListTile(
            leading: Icon(Icons.dns, color: s.ssl ? Colors.green : Colors.grey),
            title:   Text(s.nombre),
            subtitle: Text('${s.ip}:${s.puerto}'),
            onTap: () => context.push(
              '/servidores/${s.id}',
              extra: s,
            ),
          );
        },
      ),
    );
  }
}
