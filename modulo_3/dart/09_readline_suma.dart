import 'dart:io';

void main() {
  print('Ingrese un primer número:');
  int numero1 = int.parse(stdin.readLineSync()!);
  print('Número: $numero1');

  print('Ingrese un segundo número:');
  int numero2 = int.parse(stdin.readLineSync()!);
  print('Número: $numero2');

  int suma = numero1 + numero2;

  print('La suma es: $suma');
  
}