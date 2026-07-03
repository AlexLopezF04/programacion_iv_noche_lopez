import 'dart:io';

void main() {
  
  print('Ingrese la calificación del estudiante: ');
  int nota = int.parse(stdin.readLineSync()!);
  print('Nota: $nota');

  if (nota >= 90) {
    print('La nota $nota es Excelente');
  } else if (nota >= 70) {
    print('La nota $nota es Aprobatoria');
  } else if (nota >= 0) {
    print('La nota $nota es Reprobatoria');
  } else {
    print('Nota inválida');
  }
}
