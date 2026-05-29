void main() {
  // === 1. LAMBDA DE EXPRESIÓN RESTRITA (Asignada a una variable) ===
  // Calcula el porcentaje de progreso de un estudiante en base a sus clases vistas.
  final calcularProgresoHito = (int clasesVistas) => clasesVistas * 10; 
  print('Puntos extras por hitos alcanzados: ${calcularProgresoHito(7)} pts'); // 70 pts


  // === 2. LAMBDA DE CUERPO COMPLETO (Bloque con código y retorno explícito) ===
  // Calcula el costo final de una membresía aplicando un cupón de descuento variable.
  // Tu ejemplo original de descuentos ya encajaba muy bien, lo adaptamos al entorno e-learning.
  final aplicarCuponInscripcion = (double precioCurso, double porcentajeDescuento) {
    final montoDescuento = precioCurso * (porcentajeDescuento / 100);
    return precioCurso - montoDescuento;
  };
  print('Total a pagar por la matrícula: \$${aplicarCuponInscripcion(100.0, 15.0)} USD'); // 85.0


  // === 3. LAMBDA EN LÍNEA (Pasada directamente como argumento) ===
  // Ideal para ordenar listas complejas de datos dinámicamente en la interfaz de usuario (UI).
  // Imagina que estos números representan las valoraciones o estrellas de los cursos en el buscador.
  final calificacionesCursos = [3, 1, 4, 1, 5, 9, 2, 6];
  
  // Ordenamos las calificaciones de forma descendente usando una función anónima en línea
  // para que los cursos mejor puntuados aparezcan primero en la web.
  calificacionesCursos.sort((cursoA, cursoB) => cursoB.compareTo(cursoA)); 
  
  print('Cursos ordenados por mejor calificación (Top a Bottom):');
  print(calificacionesCursos); // [9, 6, 5, 4, 3, 2, 1, 1]
}