double Function(double) crearMultiplicadorDescuento(double factor) {
  return (double precio) => precio * factor;
}

void main() {
  final descuento10  = crearMultiplicadorDescuento(0.9);
  final descuento20  = crearMultiplicadorDescuento(0.8);
  final descuento50  = crearMultiplicadorDescuento(0.5);

  print(descuento10(100));
  print(descuento20(100));
  print(descuento50(100));

  bool Function(double) crearValidadorPrecio(double min, double max) {
    return (precio) => precio >= min && precio <= max;
  }

  final esEconomico  = crearValidadorPrecio(0, 50);
  final esPremium    = crearValidadorPrecio(200, double.infinity);

  print(esEconomico(35.0));
  print(esPremium(249.99));
  print(esPremium(45.0));
}
