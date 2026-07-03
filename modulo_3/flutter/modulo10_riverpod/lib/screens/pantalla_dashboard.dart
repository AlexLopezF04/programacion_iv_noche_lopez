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
        title: Text(indice == 0 ? 'Servidores' : 'Métricas'),
      ),
      body: paginas[indice],
      bottomNavigationBar: NavigationBar(
        selectedIndex: indice,
        onDestinationSelected: (i) {
          ref.read(indiceTabProvider.notifier).cambiar(i);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dns_outlined),
            selectedIcon: Icon(Icons.dns),
            label: 'Servidores',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart),
            label: 'Métricas',
          ),
        ],
      ),
    );
  }
}
