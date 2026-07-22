import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/metrica_servidor.dart';

class MetricasNotifier extends AsyncNotifier<List<MetricaServidor>> {
  @override
  Future<List<MetricaServidor>> build() async {
    return fetchMetricas();
  }

  Future<List<MetricaServidor>> fetchMetricas() async {
    await Future.delayed(const Duration(seconds: 1));
    final random = Random();
    return List.generate(4, (i) {
      return MetricaServidor(
        servidorId: '${i + 1}',
        cpu: random.nextDouble() * 100,
        ram: random.nextDouble() * 100,
        disco: random.nextDouble() * 100,
        timestamp: DateTime.now(),
      );
    });
  }

  Future<void> refrescar() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => fetchMetricas());
  }
}

final metricasProvider =
    AsyncNotifierProvider<MetricasNotifier, List<MetricaServidor>>(
  MetricasNotifier.new,
);
