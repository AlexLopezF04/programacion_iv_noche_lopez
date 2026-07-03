class Curso {
  final String titulo;
  final String instructor;
  final double precio;
  final bool   certificado;

  Curso({
    required this.titulo,
    required this.instructor,
    required this.precio,
    this.certificado = false,
  });

  Curso.gratuito({required this.titulo, required this.instructor})
      : precio = 0.0,
        certificado = false;

  Curso.premium({required this.titulo, required this.instructor})
      : precio  = 99.99,
        certificado = true;

  factory Curso.desdeJson(Map<String, dynamic> json) {
    return Curso(
      titulo:      json['titulo'] as String,
      instructor:  json['instructor'] as String,
      precio:      (json['precio'] as num).toDouble(),
      certificado: json['certificado'] as bool? ?? false,
    );
  }

  @override
  String toString() =>
      '$titulo por $instructor — \$$precio${certificado ? " (certificado)" : ""}';
}

void main() {
  final c1 = Curso(titulo: 'Dart Básico', instructor: 'Ana López', precio: 29.99);
  final c2 = Curso.gratuito(titulo: 'Introducción a la Programación', instructor: 'Luis Pérez');
  final c3 = Curso.premium(titulo: 'Flutter Avanzado', instructor: 'Ana López');
  final c4 = Curso.desdeJson({
    'titulo': 'Kotlin desde Cero',
    'instructor': 'Pedro Gómez',
    'precio': 49.99,
    'certificado': true,
  });

  print(c1);
  print(c2);
  print(c3);
  print(c4);
}
