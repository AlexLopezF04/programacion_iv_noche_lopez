import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/servidores_provider.dart';

class PantallaServidores extends ConsumerWidget {
  const PantallaServidores({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final servidores = ref.watch(servidoresFiltradosProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            decoration: const InputDecoration(
              labelText: 'Buscar servidor',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (valor) {
              ref.read(busquedaProvider.notifier).cambiar(valor);
            },
          ),
        ),
        Expanded(
          child: servidores.isEmpty
              ? const Center(child: Text('Sin resultados'))
              : ListView.builder(
                  itemCount: servidores.length,
                  itemBuilder: (context, index) {
                    final s = servidores[index];
                    return ListTile(
                      title: Text(s.nombre),
                      subtitle: Text('${s.host}:${s.puerto}'),
                      leading: IconButton(
                        icon: Icon(
                          s.esFavorito ? Icons.star : Icons.star_border,
                          color: s.esFavorito ? Colors.amber : null,
                        ),
                        onPressed: () {
                          ref
                              .read(servidoresProvider.notifier)
                              .toggleFavorito(s.id);
                        },
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          ref
                              .read(servidoresProvider.notifier)
                              .eliminar(s.id);
                        },
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
