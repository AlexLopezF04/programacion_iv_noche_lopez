void main() {
  final paquetesRed = [64, 128, 512, -1, 256, 1024, -1, 32];
  //                              ↑         ↑
  //                         paquete malo  paquete malo

  // continue — salta el paquete corrupto y continúa
  print('=== Procesando con continue ===');
  for (final paquete in paquetesRed) {
    if (paquete < 0) {
      print('Paquete corrupto ignorado');
      continue;  // salta al siguiente
    }
    print('Procesando paquete de $paquete bytes');
  }

  // break — detiene completamente al encontrar error crítico
  print('\n=== Procesando con break ===');
  for (final paquete in paquetesRed) {
    if (paquete < 0) {
      print('Error crítico — deteniendo procesamiento');
      break;  // sale del bucle
    }
    print('Procesando paquete de $paquete bytes');
  }
}