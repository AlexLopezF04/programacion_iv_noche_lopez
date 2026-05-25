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
  int totalMueblesGral = 0;
  int cantidadTrabajadores = 0;

  print('--- CONTROL DE PRODUCCIÓN: FABRICACIÓN DE MUEBLES ---');

  stdout.write('\nCantidad de muebles fabricados por el empleado (0 para salir): ');
  int muebles = int.parse(stdin.readLineSync()!);

  while (muebles > 0) {
    
    String nivelProduccion;
    if (muebles < 3) {
      nivelProduccion = 'Producción baja';
    } else if (muebles <= 7) {
      nivelProduccion = 'Producción normal';
    } else {
      nivelProduccion = 'Producción alta';
    }

    print('>> Rendimiento del empleado: $nivelProduccion');
    print('--------------------------------------------------');

    totalMueblesGral += muebles;
    cantidadTrabajadores++;

    stdout.write('\nCantidad de muebles fabricados por el siguiente empleado (0 para salir): ');
    muebles = int.parse(stdin.readLineSync()!);
  }

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