void main() {
  int    idCurso   = 101;
  double calificacion = idCurso.toDouble();
  String texto        = idCurso.toString();
  print('calificacion: $calificacion, texto: $texto');

  int    num1 = int.parse('123');
  double num2 = double.parse('4.5');
  print('num1: $num1, num2: $num2');

  int?    num3 = int.tryParse('abc');
  double? num4 = double.tryParse('99');
  print('num3: $num3, num4: $num4');

  Object valor = 'curso online';
  if (valor is String) {
    print(valor.length);
  }

  Object obj = 'Flutter';
  String str = obj as String;
  print(str);

  String? nullable = null;
  int longitud = nullable?.length ?? 0;
  print(longitud);

  print(double.infinity);
  print(double.nan);
  print(double.maxFinite);
}
