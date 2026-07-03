class Curso {
  final String id;
  final String titulo;
  String       instructor;
  bool         _publicado = false;

  Curso({
    required this.id,
    required this.titulo,
    required this.instructor,
  });

  bool   get publicado => _publicado;
  String get estado    => _publicado ? 'publicado' : 'borrador';

  set estadoPublicado(bool valor) {
    _publicado = valor;
    print('$titulo: ${valor ? "publicado" : "en borrador"}');
  }

  void publicar() {
    _publicado = true;
    print('$titulo publicado por $instructor');
  }

  void ocultar() {
    _publicado = false;
    print('$titulo ocultado');
  }

  String resumen() => 'ID: $id | Curso: $titulo | Instructor: $instructor | Estado: $estado';

  @override
  String toString() => 'Curso($titulo, $instructor, $estado)';
}

void main() {
  final curso = Curso(
    id:     'CUR-001',
    titulo: 'Dart desde Cero',
    instructor: 'Carlos García',
  );

  curso.publicar();
  print(curso.estado);
  print(curso.resumen());
  print(curso);

  curso.estadoPublicado = false;
  print(curso.publicado);
}
