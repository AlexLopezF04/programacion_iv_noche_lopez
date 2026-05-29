// === 1. CLASE ABSTRACTA (Define el contrato - EL QUÉ) ===
abstract class Recurso {
  String get titulo;
  double calcularProgreso();    // Cada recurso mide el avance del alumno a su manera
  double calcularPuntosXP();    // Recompensa en XP según la complejidad del recurso

  // Método concreto construido directamente sobre los métodos abstractos
  void mostrarDetalleEnConsola() {
    print('[$titulo] 📊 Avance: ${calcularProgreso().toStringAsFixed(1)}% | '
          '🏆 Recompensa: ${calcularPuntosXP().toStringAsFixed(0)} XP');
  }
}

// === 2. IMPLEMENTACIONES CONCRETAS (El CÓMO es específico) ===

// Subclase A: Recurso tipo Video (hereda de Recurso)
class Videoleccion extends Recurso {
  final String nombreClase;
  final double minutosTotales;
  final double minutosVistos;

  Videoleccion(this.nombreClase, this.minutosTotales, this.minutosVistos);

  @override 
  String get titulo => 'Video: $nombreClase';

  @override 
  double calcularProgreso() => (minutosVistos / minutosTotales) * 100;

  @override 
  double calcularPuntosXP() => minutosTotales * 2; // 2 XP por cada minuto de video
}

// Subclase B: Recurso tipo Examen Evaluativo (hereda de Recurso)
class Examen extends Recurso {
  final String tema;
  final int totalPreguntas;
  final int respuestasCorrectas;

  Examen(this.tema, this.totalPreguntas, this.respuestasCorrectas);

  @override 
  String get titulo => '📝 Test: $tema';

  @override 
  double calcularProgreso() => (respuestasCorrectas / totalPreguntas) * 100;

  @override 
  double calcularPuntosXP() => respuestasCorrectas * 50; // Recompensa alta por responder bien
}

void main() {
  // Aplicamos Polimorfismo: Una lista cuyo tipo de dato es la clase abstracta (Recurso),
  // pero que almacena instancias de sus clases hijas (Videoleccion y Examen).
  final temarioDelDia = <Recurso>[
    Videoleccion('Introducción a la Programación Orientada a Objetos', 30.0, 15.0),
    Examen('Fundamentos de Clases Avanzadas', 10, 8)
  ];

  print('=== PROCESANDO EL TEMARIO DEL ESTUDIANTE ===');
  for (final recurso in temarioDelDia) {
    // Polimorfismo en acción: El bucle no sabe (ni le importa) si el recurso es un video o un test,
    // simplemente invoca al método concreto heredado que sabe cómo responder dinámicamente.
    recurso.mostrarDetalleEnConsola();
  }
}