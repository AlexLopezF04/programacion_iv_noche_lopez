class InfoDispositivo {
  final String       nombre;
  final String       tipo;       // 'router', 'switch', 'server', 'endpoint'
  final String       ip;
  final bool         activo;
  final int          alertas;
  final List<String> etiquetas;

  const InfoDispositivo({
    required this.nombre,
    required this.tipo,
    required this.ip,
    required this.activo,
    this.alertas   = 0,
    this.etiquetas = const [],
  });
}
