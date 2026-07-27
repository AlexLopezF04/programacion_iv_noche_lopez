void main() {
  final cursosIds = [101, 203, 305, -1, 404, 512, -1, 608];

  print('=== Procesando con continue ===');
  for (final id in cursosIds) {
    if (id < 0) {
      print('ID de curso inválido ignorado');
      continue;
    }
    print('Procesando curso ID: $id');
  }

  print('\n=== Procesando con break ===');
  for (final id in cursosIds) {
    if (id < 0) {
      print('Error crítico — deteniendo carga de cursos');
      break;
    }
    print('Procesando curso ID: $id');
  }
}
