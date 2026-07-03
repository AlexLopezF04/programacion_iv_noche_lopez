void main() {
  int leccionesPendientes = 10;
  int leccionesCompletadas = 0;

  while (leccionesPendientes > 0) {
    final lote = leccionesPendientes > 3 ? 3 : leccionesPendientes;
    leccionesCompletadas += lote;
    leccionesPendientes -= lote;
    print('Completadas $lote lecciones (restan: $leccionesPendientes)');
  }
  print('Total de lecciones completadas: $leccionesCompletadas');

  int intentos = 0;
  bool cursoComprado = false;

  do {
    intentos++;
    print('Intento de pago #$intentos...');
    if (intentos == 3) cursoComprado = true;
  } while (!cursoComprado && intentos < 5);

  print(cursoComprado
      ? 'Curso comprado tras $intentos intentos'
      : 'No se pudo completar la compra');
}
