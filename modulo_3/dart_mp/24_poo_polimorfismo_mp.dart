abstract class Pago {
  String get tipo;
  double calcularComision();
}

class PagoTarjeta extends Pago {
  final double monto;
  PagoTarjeta(this.monto);
  @override String get tipo => 'Tarjeta';
  @override double calcularComision() => monto * 0.035;
}

class PagoTransferencia extends Pago {
  final double monto;
  PagoTransferencia(this.monto);
  @override String get tipo => 'Transferencia';
  @override double calcularComision() => monto * 0.01;
}

class PagoPayPal extends Pago {
  final double monto;
  PagoPayPal(this.monto);
  @override String get tipo => 'PayPal';
  @override double calcularComision() => monto * 0.05;
}

void mostrarComision(Pago pago) {
  print('${pago.tipo}: comisión de \$${pago.calcularComision().toStringAsFixed(2)}');
}

void main() {
  final pagos = <Pago>[
    PagoTarjeta(100.0),
    PagoTransferencia(100.0),
    PagoPayPal(100.0),
  ];

  for (final p in pagos) {
    mostrarComision(p);
  }

  final mayorComision = pagos.reduce((a, b) => a.calcularComision() > b.calcularComision() ? a : b);
  print('\nMayor comisión: ${mayorComision.tipo}');
}
