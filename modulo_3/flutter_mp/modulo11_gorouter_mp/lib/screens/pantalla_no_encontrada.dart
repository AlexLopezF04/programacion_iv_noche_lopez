import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PantallaNoEncontrada extends StatelessWidget {
  final String? ruta;
  const PantallaNoEncontrada({super.key, this.ruta});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, size: 64),
          const Text('Pagina no encontrada',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          if (ruta != null) ...[
            const SizedBox(height: 4),
            Text(ruta!, style: const TextStyle(fontSize: 12)),
          ],
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () => context.go('/'),
            icon:  const Icon(Icons.home),
            label: const Text('Ir al inicio'),
          ),
        ],
      )),
    );
  }
}
