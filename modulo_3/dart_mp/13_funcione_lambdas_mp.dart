void main() {
  final alCuadrado = (int n) => n * n;
  print(alCuadrado(7));

  final calcularDescuentoCurso = (double precio, double pct) {
    final descuento = precio * (pct / 100);
    return precio - descuento;
  };
  print(calcularDescuentoCurso(100.0, 15.0));

  final precios = [29.99, 49.50, 15.00, 99.99];
  precios.sort((a, b) => b.compareTo(a));
  print(precios);
}
