import 'dart:io';

void main() {
  print('--- SISTEMA DE ESTUDIANTES PENDIENTES ---');

  int cantidad = 0;
  int totalEstudiantes = 0;

  stdout.write('Ingrese la cantidad de estudiantes pendientes de revisión (0 para salir): ');
  cantidad = int.parse(stdin.readLineSync()!);

  while (cantidad > 0) {
    totalEstudiantes += cantidad;
    print('$cantidad estudiantes procesados. Total acumulado: $totalEstudiantes');
    
    stdout.write('Ingrese la siguiente cantidad de estudiantes pendientes (0 para salir): ');
    cantidad = int.parse(stdin.readLineSync()!);
  }

  print('Total de estudiantes procesados: $totalEstudiantes');
}
