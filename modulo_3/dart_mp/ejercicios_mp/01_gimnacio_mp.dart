/*
Enunciado
Una plataforma de cursos online registra los minutos de video que cada estudiante consume durante el día.
Realiza un programa en Dart que use readLineSync() y un ciclo while para ingresar los minutos de video vistos por cada estudiante.
Reglas de negocio:
Menos de 30 minutos -> "Consumo bajo"
Entre 30 y 90 minutos -> "Consumo adecuado"
Más de 90 minutos -> "Consumo intenso"
El programa debe seguir solicitando datos mientras se ingresen valores mayores a 0.
Cuando el usuario ingrese 0, mostrar:
Total de minutos consumidos
Cantidad de estudiantes registrados
Promedio de minutos por estudiante
*/

import 'dart:io';

void main() {
  int totalMinutosGral = 0;
  int cantidadEstudiantes = 0;

  print('--- SISTEMA DE CONSUMO DE CURSOS ONLINE ---');

  stdout.write('\nMinutos de video vistos por el estudiante (0 para salir): ');
  int minutos = int.parse(stdin.readLineSync()!);

  while (minutos > 0) {
    
    String tipoConsumo;
    if (minutos < 30) {
      tipoConsumo = 'Consumo bajo';
    } else if (minutos <= 90) {
      tipoConsumo = 'Consumo adecuado';
    } else {
      tipoConsumo = 'Consumo intenso';
    }

    print('>> Evaluación del estudiante: $tipoConsumo');
    print('--------------------------------------------------');

    totalMinutosGral += minutos;
    cantidadEstudiantes++;

    stdout.write('\nMinutos de video del siguiente estudiante (0 para salir): ');
    minutos = int.parse(stdin.readLineSync()!);
  }

  if (cantidadEstudiantes > 0) {
    double promedioMinutosPorEstudiante = totalMinutosGral / cantidadEstudiantes;

    print('\n==================================================');
    print('                REPORTE FINAL                     ');
    print('==================================================');
    print('Total de minutos consumidos: $totalMinutosGral min');
    print('Cantidad de estudiantes registrados: $cantidadEstudiantes');
    print('Promedio de minutos por estudiante: ${promedioMinutosPorEstudiante.toStringAsFixed(2)} min');
    print('==================================================');
  } else {
    print('\nNo se registraron datos de estudiantes.');
  }
}
