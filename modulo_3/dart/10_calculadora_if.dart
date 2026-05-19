import 'dart:io';

void main() {
  // Forma básica
  
  print('Ingrese un número entero: ');
  int numero = int.parse(stdin.readLineSync()!);
  print ('Número: $numero');

  if (numero > 0) {
    print('El numero $numero es Positivo');
  } else if (numero < 0) {
    print('El numero $numero es Negativo');
  } else {
    print('El numero $numero es Cero');
  }

}