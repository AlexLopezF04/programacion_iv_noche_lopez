/*
Enunciado
Una carpintería registra la cantidad de muebles fabricados por cada trabajador durante la jornada laboral.
Realiza un programa en Dart que use readLineSync() y un ciclo while para ingresar la cantidad de muebles elaborados por empleado.
Reglas de negocio:
Menos de 3 muebles → “Producción baja”
Entre 3 y 7 muebles → “Producción normal”
Más de 7 muebles → “Producción alta”
El programa debe continuar solicitando datos mientras se ingresen valores mayores a 0.
Cuando el usuario ingrese 0, mostrar:
Total de muebles fabricados
Cantidad de trabajadores registrados
Promedio de muebles por trabajador
*/

import 'dart:io';

void main() {
  // Variables acumuladoras para el reporte final (fuera del ciclo)
  int totalMueblesGral = 0;
  int cantidadTrabajadores = 0;

  print('--- CONTROL DE PRODUCCIÓN: FABRICACIÓN DE MUEBLES ---');

  // Primera lectura: Solicitamos los muebles del primer empleado
  stdout.write('\nCantidad de muebles fabricados por el empleado (0 para salir): ');
  int muebles = int.parse(stdin.readLineSync()!);

  // El ciclo continúa mientras la cantidad de muebles sea mayor a 0
  while (muebles > 0) {
    
    // --- EVALUACIÓN SEGÚN REGLAS DE NEGOCIO ---
    String nivelProduccion;
    if (muebles < 3) {
      nivelProduccion = 'Producción baja';
    } else if (muebles <= 7) {
      nivelProduccion = 'Producción normal';
    } else {
      nivelProduccion = 'Producción alta';
    }

    // Mostrar el resultado individual de este empleado
    print('>> Rendimiento del empleado: $nivelProduccion');
    print('--------------------------------------------------');

    // --- ACUMULACIÓN DE DATOS GLOBALES ---
    totalMueblesGral += muebles;
    cantidadTrabajadores++;

    // Volver a solicitar datos para la siguiente iteración
    stdout.write('\nCantidad de muebles fabricados por el siguiente empleado (0 para salir): ');
    muebles = int.parse(stdin.readLineSync()!);
  }

  // --- REPORTE FINAL ---
  // Validamos que se haya registrado al menos un trabajador para evitar la división por cero
  if (cantidadTrabajadores > 0) {
    double promedioMueblesPorTrabajador = totalMueblesGral / cantidadTrabajadores;

    print('\n==================================================');
    print('                REPORTE FINAL                     ');
    print('==================================================');
    print('Total de muebles fabricados: $totalMueblesGral');
    print('Cantidad de trabajadores registrados: $cantidadTrabajadores');
    print('Promedio de muebles por trabajador: ${promedioMueblesPorTrabajador.toStringAsFixed(2)}');
    print('==================================================');
  } else {
    print('\nNo se registraron datos de empleados.');
  }
}