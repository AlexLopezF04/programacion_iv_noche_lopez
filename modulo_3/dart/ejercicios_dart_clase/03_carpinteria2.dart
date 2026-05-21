/*
Enunciado
Un taller de carpintería controla la cantidad de tablas cortadas por cada operario durante el día.
Realiza un programa en Dart que use readLineSync() y un ciclo while para ingresar la cantidad de tablas cortadas por trabajador.
Reglas de negocio:
Menos de 15 tablas → “Trabajo lento”
Entre 15 y 40 tablas → “Trabajo eficiente”
Más de 40 tablas → “Trabajo sobresaliente”
El programa debe seguir solicitando datos mientras se ingresen valores mayores a 0.
Cuando el usuario ingrese 0, mostrar:
Total de tablas cortadas
Cantidad de operarios registrados
Promedio de tablas por operario
*/

import 'dart:io';

void main() {
  // Variables acumuladoras para el reporte final (fuera del ciclo)
  int totalTablasGral = 0;
  int cantidadOperarios = 0;

  print('--- CONTROL DE PRODUCCIÓN: TALLER DE CARPINTERÍA ---');

  // Primera lectura: Solicitamos las tablas del primer operario
  stdout.write('\nCantidad de tablas cortadas por el operario (0 para salir): ');
  int tablas = int.parse(stdin.readLineSync()!);

  // El ciclo continúa mientras la cantidad de tablas sea mayor a 0
  while (tablas > 0) {
    
    // --- EVALUACIÓN SEGÚN REGLAS DE NEGOCIO ---
    String evaluacionTrabajo;
    if (tablas < 15) {
      evaluacionTrabajo = 'Trabajo lento';
    } else if (tablas <= 40) {
      evaluacionTrabajo = 'Trabajo eficiente';
    } else {
      evaluacionTrabajo = 'Trabajo sobresaliente';
    }

    // Mostrar el resultado individual de este operario
    print('>> Rendimiento del operario: $evaluacionTrabajo');
    print('--------------------------------------------------');

    // --- ACUMULACIÓN DE DATOS GLOBALES ---
    totalTablasGral += tablas;
    cantidadOperarios++;

    // Volver a solicitar datos para la siguiente iteración
    stdout.write('\nCantidad de tablas cortadas por el siguiente operario (0 para salir): ');
    tablas = int.parse(stdin.readLineSync()!);
  }

  // --- REPORTE FINAL ---
  // Validamos que se haya registrado al menos un operario para evitar la división por cero
  if (cantidadOperarios > 0) {
    double promedioTablasPorOperario = totalTablasGral / cantidadOperarios;

    print('\n==================================================');
    print('                REPORTE FINAL                     ');
    print('==================================================');
    print('Total de tablas cortadas: $totalTablasGral');
    print('Cantidad de operarios registrados: $cantidadOperarios');
    print('Promedio de tablas por operario: ${promedioTablasPorOperario.toStringAsFixed(2)}');
    print('==================================================');
  } else {
    print('\nNo se registraron datos de operarios.');
  }
}