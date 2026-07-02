class Servidor {
  final String nombre;
  final double cpu;
  final double ram;
  final int    conexiones;
  final bool   activo;

  const Servidor({
    required this.nombre,
    required this.cpu,
    required this.ram,
    required this.conexiones,
    required this.activo,
  });

  bool get esCritico => cpu > 85 || ram > 90;
}
