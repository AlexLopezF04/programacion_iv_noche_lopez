import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/metricas_provider.dart';

class PantallaMetricas extends ConsumerWidget {
  const PantallaMetricas({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricasAsync = ref.watch(metricasProvider);

    return metricasAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
      data: (metricas) {
        if (metricas.isEmpty) {
          return const Center(child: Text('Sin métricas disponibles'));
        }
        return ListView.builder(
          itemCount: metricas.length,
          itemBuilder: (context, index) {
            final m = metricas[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Servidor ${m.servidorId}',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    _BarraProgreso('CPU', m.cpu, Colors.blue),
                    _BarraProgreso('RAM', m.ram, Colors.green),
                    _BarraProgreso('Disco', m.disco, Colors.orange),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _BarraProgreso extends StatelessWidget {
  final String label;
  final double valor;
  final Color color;

  const _BarraProgreso(this.label, this.valor, this.color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(width: 60, child: Text(label)),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: valor / 100,
                minHeight: 12,
                color: color,
                backgroundColor: color.withValues(alpha: 0.1),
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
              width: 40, child: Text('${valor.toStringAsFixed(0)}%')),
        ],
      ),
    );
  }
}
