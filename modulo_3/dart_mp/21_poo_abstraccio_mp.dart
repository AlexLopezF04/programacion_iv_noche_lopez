abstract class Contenido {
  String get titulo;
  int get duracionMinutos;
  String get tipoContenido;

  void reproducir() {
    print('Reproduciendo $tipoContenido: "$titulo" (${duracionMinutos} min)');
  }
}

class Video extends Contenido {
  final String titulo;
  final int duracionMinutos;
  final String url;

  Video(this.titulo, this.duracionMinutos, this.url);

  @override String get tipoContenido => 'Video';
}

class Articulo extends Contenido {
  final String titulo;
  final int duracionMinutos;
  final String texto;

  Articulo(this.titulo, this.duracionMinutos, this.texto);

  @override String get tipoContenido => 'Artículo';
}

class Quiz extends Contenido {
  final String titulo;
  final int duracionMinutos;
  final List<String> preguntas;

  Quiz(this.titulo, this.duracionMinutos, this.preguntas);

  @override String get tipoContenido => 'Quiz';
}

void main() {
  final contenidos = <Contenido>[
    Video('Variables en Dart', 15, 'https://video.com/var'),
    Articulo('Tipos de Datos', 8, 'Los tipos básicos son...'),
    Quiz('Evaluación Módulo 1', 10, ['¿Qué es var?', '¿Qué es final?']),
  ];
  for (final c in contenidos) {
    c.reproducir();
  }
}
