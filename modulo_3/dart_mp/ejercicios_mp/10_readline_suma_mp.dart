import 'dart:io';

void main() {
  print('Ingrese la primera calificación:');
  int nota1 = int.parse(stdin.readLineSync()!);
  print('Nota: $nota1');

  print('Ingrese la segunda calificación:');
  int nota2 = int.parse(stdin.readLineSync()!);
  print('Nota: $nota2');

  int suma = nota1 + nota2;
  double promedio = suma / 2;

  print('La suma de notas es: $suma');
  print('El promedio es: $promedio');
}
