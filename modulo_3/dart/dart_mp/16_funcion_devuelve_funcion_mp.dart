// === 1. FÁBRICA DE FUNCIONES (Devuelve una función configurada) ===
// Genera multiplicadores de puntos de experiencia (XP) según el evento de la plataforma.
// Retorna una función de tipo: int Function(int)
int Function(int) crearMultiplicadorXP(int factorEvento) {
  // Retorna una función anónima que "recuerda" el factor guardado en memoria
  return (int puntosBaseLeccion) => puntosBaseLeccion * factorEvento;
}

void main() {
  // Creamos diferentes configuraciones de multiplicadores según el día
  final xpDiaNormal   = crearMultiplicadorXP(1);  // Mantiene los puntos estándar
  final xpFinDeSemana = crearMultiplicadorXP(2);  // Duplica los puntos por estudiar sábados/domingos
  final xpCyberWeek   = crearMultiplicadorXP(5);  // Quintuplica los puntos como incentivo especial

  print('=== SISTEMA DE GAMIFICACIÓN (Cálculo de XP) ===');
  print('Estudiante completó clase en día normal: ${xpDiaNormal(10)} XP');   // 10
  print('Estudiante completó clase en fin de semana: ${xpFinDeSemana(10)} XP'); // 20
  print('Estudiante completó clase en CyberWeek: ${xpCyberWeek(10)} XP');    // 50


  // === 2. GENERADOR DE VALIDADORES CONFIGURABLES (Closures para Filtros) ===
  // Retorna una función evaluadora que valida si el costo de un curso cae en un rango monetario.
  bool Function(double) crearValidadorRangoPrecio(double min, double max) {
    return (precioCurso) => precioCurso >= min && precioCurso <= max;
  }

  // Configuramos filtros específicos basados en el presupuesto del usuario
  final esCategoriaEconomica = crearValidadorRangoPrecio(0, 49.99);
  final esCategoriaPremium   = crearValidadorRangoPrecio(150.00, double.infinity);

  print('\n=== FILTROS DE RANGOS DE PRECIO ===');
  print('¿El curso de \$35.00 es económico?: ${esCategoriaEconomica(35.00)}');  // true
  print('¿El curso de \$249.99 es Premium?: ${esCategoriaPremium(249.99)}');    // true
  print('¿El curso de \$45.00 es Premium?: ${esCategoriaPremium(45.00)}');       // false
}