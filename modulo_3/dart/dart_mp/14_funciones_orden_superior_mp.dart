void main() {
  // ==========================================
  // === 1. METODO .map() (Transformación) ===
  // ==========================================
  
  // Caso A: Tu ejemplo de precios con IVA encaja perfecto en la facturación del e-learning.
  // Nota: En Ecuador se maneja justamente el IVA al 15%, ideal para el cálculo local.
  final preciosCursos = [29.99, 49.50, 15.00, 99.99];

  // .map() devuelve un Iterable. Lo convertimos a lista con .toList() para imprimirlo.
  final preciosConIva = preciosCursos.map((precio) => precio * 1.15);
  print('=== Precios de Cursos con IVA (15%) ===');
  print(preciosConIva.toList());


  // Caso B: Transformar slugs o endpoints en URLs completas para consumir la API de videos.
  final rutasLecciones = ['/introduccion', '/variables-dart', '/poo-avanzado'];
  final urlVideosCompletas = rutasLecciones.map((ruta) => 'https://api.edutesh.com/v1$ruta');
  
  print('\n=== URLs de streaming generadas para el reproductor ===');
  print(urlVideosCompletas.toList());


  // ==========================================
  // === 2. METODO .where() (Filtrado)     ===
  // ==========================================
  
  // Cambiamos la lista de temperaturas por las calificaciones obtenidas por los alumnos en un examen.
  final calificacionesExamen = [6.1, 7.8, 9.2, 6.5, 8.7, 5.9];

  // Filtramos los estudiantes que aprobaron el examen (nota mayor o igual a 7.0)
  final alumnosAprobados = calificacionesExamen.where((nota) => nota >= 7.0);
  print('\n=== Calificaciones aprobadas (>= 7.0) ===');
  print(alumnosAprobados.toList()); // [7.8, 9.2, 8.7]

  // Filtramos los estudiantes que se quedaron supletorios o reprobados (< 7.0)
  final alumnosReprobados = calificacionesExamen.where((nota) => nota < 7.0);
  print('=== Calificaciones reprobadas (< 7.0) ===');
  print(alumnosReprobados.toList());  // [6.1, 6.5, 5.9]


  // =======================================================
  // === 3. METODOS .reduce() y .fold() (Acumulación)   ===
  // =======================================================
  
  // Lista de ingresos diarios por concepto de inscripciones en la plataforma
  final ingresosInscripciones = [150.0, 230.0, 98.0, 310.0, 75.0];

  // .reduce() — Combina todos los elementos en un único valor. 
  // OJO: Lanza error si la lista llega a estar completamente vacía.
  final totalIngresosReduce = ingresosInscripciones.reduce((acumulador, venta) => acumulador + venta);
  print('\n=== Métricas de Venta Semanal ===');
  print('Total ganado (reduce): \$${totalIngresosReduce.toStringAsFixed(2)} USD');

  // .fold() — Más seguro que reduce. Recibe un valor inicial (0.0 en este caso) 
  // y si la lista está vacía, no rompe la app, simplemente retorna ese valor inicial.
  final totalIngresosFold = ingresosInscripciones.fold(0.0, (acumulador, venta) => acumulador + venta);
  print('Total ganado (fold seguro): \$${totalIngresosFold.toStringAsFixed(2)} USD');

  // Encontrar el curso que generó la venta más alta o la matrícula más costosa
  final mayorIngresoUnico = ingresosInscripciones.reduce((a, b) => a > b ? a : b);
  print('La matrícula más alta registrada fue de: \$$mayorIngresoUnico USD'); // $310.0
}