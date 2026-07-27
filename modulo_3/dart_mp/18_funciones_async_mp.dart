Future<String> obtenerCatalogoCursos() async {
  print("cargando...");
  await Future.delayed(Duration(milliseconds: 200));
  print("listo");
  return 'Dart, Flutter, Kotlin, Swift';
}

void main() async {
  print('Consultando catálogo...');
  final catalogo = await obtenerCatalogoCursos();
  print('Cursos disponibles: $catalogo');
  print('Consulta completada');
}
