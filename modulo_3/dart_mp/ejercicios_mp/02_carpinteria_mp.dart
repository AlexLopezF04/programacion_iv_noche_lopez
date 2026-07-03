/*
Enunciado
Una plataforma de cursos online registra la cantidad de módulos completados por cada estudiante durante la semana.
Realiza un programa en Dart que use readLineSync() y un ciclo while para ingresar la cantidad de módulos completados por estudiante.
Reglas de negocio:
Menos de 3 módulos -> "Avance lento"
Entre 3 y 7 módulos -> "Avance normal"
Más de 7 módulos -> "Avance rápido"
El programa debe continuar solicitando datos mientras se ingresen valores mayores a 0.
Cuando el usuario ingrese 0, mostrar:
Total de módulos completados
Cantidad de estudiantes registrados
Promedio de módulos por estudiante
*/

import 'dart:io';

void main() {
  int totalModulosGral = 0;
  int cantidadEstudiantes = 0;

  print('--- CONTROL DE AVANCE: CURSOS ONLINE ---');

  stdout.write('\nMódulos completados por el estudiante (0 para salir): ');
  int modulos = int.parse(stdin.readLineSync()!);

  while (modulos > 0) {
    
    String nivelAvance;
    if (modulos < 3) {
      nivelAvance = 'Avance lento';
    } else if (modulos <= 7) {
      nivelAvance = 'Avance normal';
    } else {
      nivelAvance = 'Avance rápido';
    }

    print('>> Rendimiento del estudiante: $nivelAvance');
    print('--------------------------------------------------');

    totalModulosGral += modulos;
    cantidadEstudiantes++;

    stdout.write('\nMódulos completados por el siguiente estudiante (0 para salir): ');
    modulos = int.parse(stdin.readLineSync()!);
  }

  if (cantidadEstudiantes > 0) {
    double promedioModulosPorEstudiante = totalModulosGral / cantidadEstudiantes;

    print('\n==================================================');
    print('                REPORTE FINAL                     ');
    print('==================================================');
    print('Total de módulos completados: $totalModulosGral');
    print('Cantidad de estudiantes registrados: $cantidadEstudiantes');
    print('Promedio de módulos por estudiante: ${promedioModulosPorEstudiante.toStringAsFixed(2)}');
    print('==================================================');
  } else {
    print('\nNo se registraron datos de estudiantes.');
  }
}
