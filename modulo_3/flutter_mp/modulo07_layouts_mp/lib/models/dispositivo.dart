class InfoCurso {
  final String       nombre;
  final String       categoria;  // 'Frontend', 'Backend', 'Database', 'Mobile'
  final String       instructor;
  final bool         activo;
  final int          leccionesNuevas;
  final List<String> etiquetas;
  final int          progreso; // Porcentaje de progreso (0 - 100)

  const InfoCurso({
    required this.nombre,
    required this.categoria,
    required this.instructor,
    required this.activo,
    this.leccionesNuevas = 0,
    this.etiquetas = const [],
    this.progreso = 0,
  });
}

