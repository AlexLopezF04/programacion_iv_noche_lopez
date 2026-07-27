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
      cpu: 85.0, ram: 62.0, disco: 92.0,
      conexionesActivas: 25, ultimoPing: 'Hace 5 min'),
    '2': const Metricas(
      cpu: 45.0, ram: 20.0, disco: 80.0,
      conexionesActivas: 10, ultimoPing: 'Ayer'),
    '3': const Metricas(
      cpu: 15.0, ram: 5.0, disco: 75.0,
      conexionesActivas: 2, ultimoPing: 'Hace 3 días'),
  };

  return datos[servidorId] ?? const Metricas(
    cpu: 0, ram: 0, disco: 0,
    conexionesActivas: 0, ultimoPing: 'N/A');
});
