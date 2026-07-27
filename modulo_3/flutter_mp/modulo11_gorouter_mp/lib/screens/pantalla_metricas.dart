import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/metricas_provider.dart';
import '../models/servidor_ssh.dart';

class PantallaMetricas extends ConsumerWidget {
  const PantallaMetricas({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title:           const Text('Métricas Académicas'),
        backgroundColor: cs.primaryContainer,
        foregroundColor: cs.onPrimaryContainer,
      ),
      body: ListView.builder(
        itemCount:   servidoresSimulados.length,
        itemBuilder: (context, i) {
          final s = servidoresSimulados[i];
          final metricasAsync = ref.watch(metricasProvider(s.id));

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(s.nombre,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 8),
                  metricasAsync.when(
                    data: (m) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          _Medidor('Progreso', m.cpu, Colors.indigo, cs, '%'),
                          const SizedBox(width: 12),
                          _Medidor('Estudio', m.ram, Colors.green, cs, ' h'),
                          const SizedBox(width: 12),
                          _Medidor('Evaluación', m.disco, Colors.orange, cs, '%'),
                        ]),
                        const SizedBox(height: 8),
                        Text('Lecciones completadas: ${m.conexionesActivas}'),
                        Text('Último acceso: ${m.ultimoPing}'),
                      ],
                    ),
                    loading: () => const LinearProgressIndicator(),
                    error: (e, _) => Text('Error: $e'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Medidor extends StatelessWidget {
  final String  label;
  final double  valor;
  final Color   color;
  final ColorScheme cs;
  final String sufijo;

  const _Medidor(this.label, this.valor, this.color, this.cs, this.sufijo);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        SizedBox(
          width: 70, height: 70,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 70, height: 70,
                child: CircularProgressIndicator(
                  value:         valor / 100,
                  strokeWidth:   6,
                  backgroundColor: cs.surfaceContainerHighest,
                  valueColor:    AlwaysStoppedAnimation(color),
                ),
              ),
              Text('${valor.toStringAsFixed(0)}$sufijo',
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }
}
