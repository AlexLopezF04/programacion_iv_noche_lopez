import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/servidores_provider.dart';

class PantallaBusqueda extends ConsumerWidget {
  const PantallaBusqueda({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SearchBar(
        hintText: 'Buscar servidores...',
        leading: const Icon(Icons.search),
        onChanged: (valor) {
          ref.read(busquedaProvider.notifier).cambiar(valor);
        },
      ),
    );
  }
}
