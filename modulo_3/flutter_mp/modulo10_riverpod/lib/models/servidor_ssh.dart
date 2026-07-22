class ServidorSSH {
  final String id;
  final String nombre;
  final String host;
  final int puerto;
  final bool esFavorito;

  const ServidorSSH({
    required this.id,
    required this.nombre,
    required this.host,
    this.puerto = 22,
    this.esFavorito = false,
  });

  ServidorSSH copyWith({
    String? id,
    String? nombre,
    String? host,
    int? puerto,
    bool? esFavorito,
  }) {
    return ServidorSSH(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      host: host ?? this.host,
      puerto: puerto ?? this.puerto,
      esFavorito: esFavorito ?? this.esFavorito,
    );
  }
}
