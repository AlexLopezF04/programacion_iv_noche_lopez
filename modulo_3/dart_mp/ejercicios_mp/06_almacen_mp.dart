/*
Enunciado 1
Una plataforma de cursos online registra los cursos creados por un instructor durante una semana.
Realiza un programa en Dart que use readLineSync() y un ciclo for para ingresar los cursos creados en 7 días por cada instructor.
Dentro del ciclo, calcular:
Total de cursos creados
Promedio diario de cursos
Reglas de negocio:
Menos de 10 cursos diarios -> "Baja productividad"
Entre 10 y 25 cursos diarios -> "Productividad normal"
Más de 25 cursos diarios -> "Alta productividad"
Al finalizar, mostrar:
Total de cursos creados
Promedio de cursos
Clasificación de productividad
*/

import 'dart:io';

void main() {
  int totalCursos = 0;

  print('--- CONTROL DE CREACIÓN DE CURSOS ---');

  for (int dia = 1; dia <= 7; dia++) {
    
    stdout.write('Ingrese los cursos creados el día $dia: ');
    
    int cursosDelDia = int.parse(stdin.readLineSync()!);

    String productividadDelDia;
    if (cursosDelDia < 10) {
      productividadDelDia = 'Baja productividad';
    } else if (cursosDelDia <= 25) {
      productividadDelDia = 'Productividad normal';
    } else {
      productividadDelDia = 'Alta productividad';
    }

    print('   -> Productividad del día $dia: $productividadDelDia');

    totalCursos = totalCursos + cursosDelDia; 
  }

    double promedioCursos = totalCursos / 7;

  String productividadGeneral;
  if (promedioCursos < 10) {
    productividadGeneral = 'Baja productividad';
  } else if (promedioCursos <= 25) {
    productividadGeneral = 'Productividad normal';
  } else {
    productividadGeneral = 'Alta productividad';
  }

  print('\n==================================================');
  print('          REPORTE FINAL DEL INSTRUCTOR             ');
  print('==================================================');
  print('Total de cursos creados en la semana: $totalCursos');
  print('Promedio de cursos diarios: ${promedioCursos.toStringAsFixed(2)}');
  print('Clasificación final: $productividadGeneral');
  print('==================================================');
}
