class MetricaServidor {
  final String servidorId;
  final double cpu;
  final double ram;
  final double disco;
  final DateTime timestamp;

  const MetricaServidor({
    required this.servidorId,
    required this.cpu,
    required this.ram,
    required this.disco,
    required this.timestamp,
  });
}
