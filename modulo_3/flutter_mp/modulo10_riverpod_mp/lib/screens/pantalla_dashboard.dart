import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'pantalla_metricas.dart';
import 'pantalla_servidores.dart';

class IndiceTabNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void cambiar(int indice) => state = indice;
}

final indiceTabProvider =
    NotifierProvider<IndiceTabNotifier, int>(IndiceTabNotifier.new);

class PantallaDashboard extends ConsumerWidget {
  const PantallaDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final indice = ref.watch(indiceTabProvider);

    final paginas = <Widget>[
      const PantallaServidores(),
      const PantallaMetricas(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(indice == 0 ? 'Mis Cursos' : 'Mis Métricas'),
      ),
      body: paginas[indice],
      bottomNavigationBar: NavigationBar(
        selectedIndex: indice,
        onDestinationSelected: (i) {
          ref.read(indiceTabProvider.notifier).cambiar(i);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.school_outlined),
            selectedIcon: Icon(Icons.school),
            label: 'Cursos',
          ),
          NavigationDestination(
            icon: Icon(Icons.analytics_outlined),
            selectedIcon: Icon(Icons.analytics),
            label: 'Métricas',
          ),
        ],
      ),
    );
  }
}
