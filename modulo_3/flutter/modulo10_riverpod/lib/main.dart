import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/metricas_provider.dart';
import 'providers/servidores_provider.dart';
import 'screens/pantalla_dashboard.dart';
import 'screens/pantalla_metricas.dart';
import 'screens/pantalla_servidores.dart';

/// ---------- SELECCIONADOR DE PASOS ----------
/// Paso 1: Provider simple (valor inmutable)
/// Paso 2: NotifierProvider + CRUD
/// Paso 3: StateProvider + Provider derivado (filtro)
/// Paso 4: AsyncNotifierProvider (carga asíncrona)
/// Paso 5: StateProvider + NavigationBar

final contadorProvider = Provider<int>((ref) => 42);

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod - Selector',
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _paso = 1;

  static const _titulos = {
    1: 'Paso 1: Provider simple',
    2: 'Paso 2: NotifierProvider',
    3: 'Paso 3: StateProvider + Provider derivado',
    4: 'Paso 4: AsyncNotifierProvider',
    5: 'Paso 5: NavigationBar con Riverpod',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titulos[_paso]!),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _pasoWidget(),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (_paso > 1)
              TextButton.icon(
                icon: const Icon(Icons.arrow_back),
                label: const Text('Anterior'),
                onPressed: () => setState(() => _paso--),
              )
            else
              const SizedBox(),
            Text('$_paso / 5'),
            if (_paso < 5)
              TextButton.icon(
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Siguiente'),
                onPressed: () => setState(() => _paso++),
              )
            else
              const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget _pasoWidget() {
    switch (_paso) {
      case 1:
        return const _Paso1();
      case 2:
        return const _Paso2();
      case 3:
        return const _Paso3();
      case 4:
        return const _Paso4();
      case 5:
        return const _Paso5();
      default:
        return const Center(child: Text('Paso no válido'));
    }
  }
}

/// Paso 1: Provider simple — valor leído sin modificarlo
class _Paso1 extends ConsumerWidget {
  const _Paso1();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contador = ref.watch(contadorProvider);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Provider<int>',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          Text(
            '$contador',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Valor inmutable — no se puede modificar',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

/// Paso 2: NotifierProvider — CRUD de servidores
class _Paso2 extends ConsumerWidget {
  const _Paso2();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final servidores = ref.watch(servidoresProvider);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            '${servidores.length} servidor(es)',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        Expanded(
          child: ListView.builder(
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
                    ref.read(servidoresProvider.notifier).eliminar(s.id);
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

/// Paso 3: StateProvider + Provider derivado — búsqueda en vivo
class _Paso3 extends ConsumerWidget {
  const _Paso3();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filtrados = ref.watch(servidoresFiltradosProvider);

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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Filtrados: ${filtrados.length} de ${ref.watch(servidoresProvider).length}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filtrados.length,
            itemBuilder: (context, index) {
              final s = filtrados[index];
              return ListTile(
                title: Text(s.nombre),
                subtitle: Text(s.host),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Paso 4: AsyncNotifierProvider — carga asíncrona con loading / error / data
class _Paso4 extends ConsumerWidget {
  const _Paso4();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricasAsync = ref.watch(metricasProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              const Text('Métricas de servidores'),
              const Spacer(),
              TextButton.icon(
                icon: const Icon(Icons.refresh),
                label: const Text('Refrescar'),
                onPressed: () {
                  ref.read(metricasProvider.notifier).refrescar();
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: metricasAsync.when(
            loading: () =>
                const Center(child: CircularProgressIndicator()),
            error: (error, stack) =>
                Center(child: Text('Error: $error')),
            data: (metricas) => ListView.builder(
              itemCount: metricas.length,
              itemBuilder: (context, index) {
                final m = metricas[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 4),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Servidor ${m.servidorId}',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall),
                        const SizedBox(height: 4),
                        _FilaStat('CPU', m.cpu, Colors.blue),
                        _FilaStat('RAM', m.ram, Colors.green),
                        _FilaStat('Disco', m.disco, Colors.orange),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _FilaStat extends StatelessWidget {
  final String label;
  final double valor;
  final Color color;

  const _FilaStat(this.label, this.valor, this.color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(width: 50, child: Text(label)),
          Expanded(
            child: LinearProgressIndicator(
              value: valor / 100,
              minHeight: 10,
              color: color,
              backgroundColor: color.withValues(alpha: 0.1),
            ),
          ),
          const SizedBox(width: 8),
          Text('${valor.toStringAsFixed(0)}%'),
        ],
      ),
    );
  }
}

/// Paso 5: StateProvider + NavigationBar
class _Paso5 extends ConsumerWidget {
  const _Paso5();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final indice = ref.watch(indiceTabProvider);

    return Scaffold(
      body: indice == 0
          ? const PantallaServidores()
          : const PantallaMetricas(),
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
