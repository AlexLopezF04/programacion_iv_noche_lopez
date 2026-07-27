void main() {
  double calificacion = 85;

  if (calificacion >= 90) {
    print('Excelente');
  } else if (calificacion >= 70) {
    print('Aprobado');
  } else {
    print('Reprobado');
  }

  String estado = calificacion >= 70 ? 'Aprobado' : 'Reprobado';
  print(estado);

  String? codigoDescuento = 'BIENVENIDA';

  String display2 = codigoDescuento.toUpperCase();
  print(display2);
}
