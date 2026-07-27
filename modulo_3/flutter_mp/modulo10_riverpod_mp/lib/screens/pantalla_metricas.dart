import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/metricas_provider.dart';
import '../providers/servidores_provider.dart';
import '../models/servidor_ssh.dart';

class PantallaMetricas extends ConsumerWidget {
  const PantallaMetricas({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricasAsync = ref.watch(metricasProvider);
    final servidores = ref.watch(servidoresProvider);

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
            final curso = servidores.firstWhere(
              (s) => s.id == m.servidorId,
              orElse: () => ServidorSSH(id: m.servidorId, nombre: 'Curso ${m.servidorId}', host: ''),
            );

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(curso.nombre,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    _BarraProgreso('Progreso', m.cpu, Colors.indigo, '%'),
                    _BarraProgreso('Estudio', m.ram / 2, Colors.green, ' h'),
                    _BarraProgreso('Nota Prom.', m.disco / 10, Colors.orange, '/10'),
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
  final String sufijo;

  const _BarraProgreso(this.label, this.valor, this.color, this.sufijo);

  @override
  Widget build(BuildContext context) {
    // Normalizar valor para el indicador lineal (0.0 a 1.0)
    // Para nota promedio (0-10) o progreso (0-100) o estudio
    double progresoLinear = valor / 100;
    if (sufijo == '/10') {
      progresoLinear = valor / 10;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(width: 80, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500))),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progresoLinear.clamp(0.0, 1.0),
                minHeight: 12,
                color: color,
                backgroundColor: color.withValues(alpha: 0.1),
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
              width: 55, child: Text('${valor.toStringAsFixed(1)}$sufijo')),
        ],
      ),
    );
  }
}

