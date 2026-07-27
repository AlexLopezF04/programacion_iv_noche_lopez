import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/metricas_provider.dart';
import 'providers/servidores_provider.dart';
import 'screens/pantalla_dashboard.dart';
import 'screens/pantalla_metricas.dart';
import 'screens/pantalla_servidores.dart';
import 'models/servidor_ssh.dart';

/// ---------- SELECCIONADOR DE PASOS ----------
/// Paso 1: Provider simple (valor inmutable)
/// Paso 2: NotifierProvider + CRUD (Cursos)
/// Paso 3: StateProvider + Provider derivado (Filtro)
/// Paso 4: AsyncNotifierProvider (Métricas de Cursos)
/// Paso 5: StateProvider + NavigationBar

final contadorProvider = Provider<int>((ref) => 4); // 4 cursos disponibles

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod - Cursos',
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
    1: 'Paso 1: Provider simple (Cursos Iniciales)',
    2: 'Paso 2: NotifierProvider (CRUD Cursos)',
    3: 'Paso 3: StateProvider + Provider derivado (Filtros)',
    4: 'Paso 4: AsyncNotifierProvider (Progreso Académico)',
    5: 'Paso 5: NavigationBar con Riverpod (Dashboard)',
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
            'Provider<int> (Cursos Totales)',
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
            'Valor inmutable — total de cursos disponibles inicialmente',
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
            '${servidores.length} curso(s) matriculado(s)',
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
                subtitle: Text('Instructor: ${s.host} · ${s.puerto} clases'),
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
              labelText: 'Buscar curso',
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
            'Cursos filtrados: ${filtrados.length} de ${ref.watch(servidoresProvider).length}',
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
                subtitle: Text('Instructor: ${s.host} · ${s.puerto} clases'),
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
    final servidores = ref.watch(servidoresProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              const Text('Rendimiento y Progreso del Alumno'),
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
                final curso = servidores.firstWhere(
                  (s) => s.id == m.servidorId,
                  orElse: () => ServidorSSH(id: m.servidorId, nombre: 'Curso ${m.servidorId}', host: ''),
                );

                return Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 4),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(curso.nombre,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        _FilaStat('Progreso', m.cpu, Colors.indigo, '%'),
                        _FilaStat('Estudio', m.ram / 2, Colors.green, ' h'),
                        _FilaStat('Examen', m.disco / 10, Colors.orange, '/10'),
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
  final String sufijo;

  const _FilaStat(this.label, this.valor, this.color, this.sufijo);

  @override
  Widget build(BuildContext context) {
    double progresoLinear = valor / 100;
    if (sufijo == '/10') {
      progresoLinear = valor / 10;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(width: 80, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500))),
          Expanded(
            child: LinearProgressIndicator(
              value: progresoLinear.clamp(0.0, 1.0),
              minHeight: 10,
              color: color,
              backgroundColor: color.withValues(alpha: 0.1),
            ),
          ),
          const SizedBox(width: 8),
          Text('${valor.toStringAsFixed(1)}$sufijo'),
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

