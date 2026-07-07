// lib/screens/pantalla_detalle.dart
import 'package:flutter/material.dart';
import '../models/servidor_ssh.dart';

class PantallaDetalle extends StatelessWidget {
  final String id;
  final ServidorSSH? servidor;

  const PantallaDetalle({
    super.key,
    required this.id,
    this.servidor,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Servidor $id'),
        backgroundColor: cs.primaryContainer,
        foregroundColor: cs.onPrimaryContainer,
      ),
      body: Center(
        child: servidor != null
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Nombre: ${servidor!.nombre}',
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  Text('IP: ${servidor!.ip}'),
                  Text('Puerto: ${servidor!.puerto}'),
                  Text('SSL: ${servidor!.ssl ? "Sí" : "No"}'),
                ],
              )
            : Text('Servidor no encontrado (id: $id)'),
      ),
    );
  }
}
