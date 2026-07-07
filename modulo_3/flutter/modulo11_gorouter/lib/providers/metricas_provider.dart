import 'package:flutter_riverpod/flutter_riverpod.dart';

class Metricas {
  final double cpu;
  final double ram;
  final double disco;
  final int conexionesActivas;
  final String ultimoPing;

  const Metricas({
    required this.cpu,
    required this.ram,
    required this.disco,
    required this.conexionesActivas,
    required this.ultimoPing,
  });
}

final metricasProvider = FutureProvider.family<Metricas, String>((ref, servidorId) async {
  await Future.delayed(const Duration(milliseconds: 600));

  final datos = <String, Metricas>{
    '1': const Metricas(
      cpu: 45.2, ram: 62.8, disco: 71.3,
      conexionesActivas: 12, ultimoPing: '15 ms'),
    '2': const Metricas(
      cpu: 23.7, ram: 41.5, disco: 55.0,
      conexionesActivas: 8, ultimoPing: '22 ms'),
    '3': const Metricas(
      cpu: 12.1, ram: 18.3, disco: 32.9,
      conexionesActivas: 3, ultimoPing: '48 ms'),
  };

  return datos[servidorId] ?? const Metricas(
    cpu: 0, ram: 0, disco: 0,
    conexionesActivas: 0, ultimoPing: 'N/A');
});
