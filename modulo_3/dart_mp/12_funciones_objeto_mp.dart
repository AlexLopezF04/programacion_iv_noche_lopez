double precioConDescuento(double p)  => p * 0.9;
double precioConIva(double p) => p * 1.15;

void main() {
  double Function(double) operacion;

  operacion = precioConDescuento;
  print(operacion(100.0));

  operacion = precioConIva;
  print(operacion(100.0));

  final transformaciones = <double Function(double)>[precioConDescuento, precioConIva];
  for (final fn in transformaciones) {
    print(fn(200.0));
  }
}
