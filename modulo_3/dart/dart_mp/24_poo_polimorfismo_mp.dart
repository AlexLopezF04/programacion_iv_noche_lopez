// === 1. CLASE ABSTRACTA (Abstracción Base) ===
abstract class ActividadAcademica {
  String get tipoActividad;
  double calcularCalificacionFinal(); // Cada actividad tiene su propio sistema de ponderación
}

// === 2. IMPLEMENTACIONES CONCRETAS (Especializaciones) ===

class TareaEscrita extends ActividadAcademica {
  final double notaContenido;
  final double notaRedaccion;

  TareaEscrita(this.notaContenido, this.notaRedaccion);

  @override 
  String get tipoActividad => 'Ensayo / Tarea Escrita';

  @override 
  double calcularCalificacionFinal() => (notaContenido * 0.7) + (notaRedaccion * 0.3);
}

class RetoDeCodigo extends ActividadAcademica {
  final int pruebasAutomatizadasPasadas;
  final int totalPruebas;

  RetoDeCodigo(this.pruebasAutomatizadasPasadas, this.totalPruebas);

  @override 
  String get tipoActividad => 'Reto Técnico de Programación';

  @override 
  double calcularCalificacionFinal() => (pruebasAutomatizadasPasadas / totalPruebas) * 10.0;
}

class ForoDiscusion extends ActividadAcademica {
  final int interaccionesValidas;

  ForoDiscusion(this.interaccionesValidas);

  @override 
  String get tipoActividad => 'Participación en Comunidad / Foro';

  @override 
  double calcularCalificacionFinal() {
    // Si participó 3 o más veces, obtiene nota máxima (10.0), de lo contrario proporcional
    return interaccionesValidas >= 3 ? 10.0 : (interaccionesValidas * 3.33);
  }
}

// === 3. POLIMORFISMO EN FUNCIÓN GLOBAL ===
// Una sola función trabaja con la abstracción del contrato académico.
// No le importa la implementación interna del cálculo, solo invoca la firma del método.
void reportarNotaEnBoletin(ActividadAcademica actividad) {
  print('${actividad.tipoActividad}: ${actividad.calcularCalificacionFinal().toStringAsFixed(2)} / 10.00 pts');
}

void main() {
  // Inicializamos la colección polimórfica combinando diferentes estructuras hijas
  final calificacionesModulo = <ActividadAcademica>[
    TareaEscrita(8.5, 9.0),             // Ensayo de código limpio
    RetoDeCodigo(8, 10),               // Script de pruebas en Dart
    ForoDiscusion(4),                  // Feedback y debate con el squad
  ];

  print('=== REPORTE ACADÉMICO DEL ESTUDIANTE ===');
  // Recorrido unificado gracias al polimorfismo
  for (final actividad in calificacionesModulo) {
    reportarNotaEnBoletin(actividad);
  }

  // === POLIMORFISMO AVANZADO CON REDUCE ===
  // Buscamos cuál fue la actividad donde el alumno obtuvo el rendimiento más alto.
  // El .reduce evalúa objetos abstractos completos basándose en el retorno de su método polimórfico.
  final mejorActividad = calificacionesModulo.reduce(
    (actual, siguiente) => actual.calcularCalificacionFinal() > siguiente.calcularCalificacionFinal() ? actual : siguiente
  );

  print('\n🎯 Actividad con el desempeño más alto: ${mejorActividad.tipoActividad}');
}