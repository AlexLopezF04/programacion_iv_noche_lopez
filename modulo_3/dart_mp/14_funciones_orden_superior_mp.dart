void main() {
  final precios = [29.99, 49.50, 15.00, 99.99];

  final preciosConIva = precios.map((p) => p * 1.15);
  print(preciosConIva.toList());

  final cursos = ['/dart-basico', '/flutter-apps', '/kotlin-avanzado'];
  final urls = cursos.map((c) => 'https://udemy.com/curso$c');
  print(urls.toList());

  final calificaciones = [3.1, 4.8, 2.2, 4.5, 3.7, 1.9];

  final buenos = calificaciones.where((c) => c > 3.5);
  print(buenos.toList());

  final medios = calificaciones.where((c) => c >= 2.0 && c <= 3.5);
  print(medios.toList());

  final ventasCursos = [1500.0, 2300.0, 980.0, 3100.0, 750.0];

  final total = ventasCursos.reduce((acum, venta) => acum + venta);
  print('Total: \$${total.toStringAsFixed(2)}');

  final totalFold = ventasCursos.fold(0.0, (acum, venta) => acum + venta);
  print('Total (fold): \$${totalFold.toStringAsFixed(2)}');

  final maximo = ventasCursos.reduce((a, b) => a > b ? a : b);
  print('Curso más vendido: \$$maximo');
}
