/*
Enunciado 1
Un almacén registra las ventas diarias de productos durante una semana para cada vendedor.
Realiza un programa en Dart que use readLineSync() y un ciclo for para ingresar las ventas de 7 días por cada vendedor.
Dentro del ciclo, calcular:
Total de ventas por vendedor
Promedio diario de ventas
Reglas de negocio:
Menos de 10 ventas diarias → “Bajo rendimiento”
Entre 10 y 25 ventas diarias → “Rendimiento normal”
Más de 25 ventas diarias → “Alto rendimiento”
Al finalizar cada vendedor, mostrar:
Total de ventas
Promedio de ventas
Clasificación de rendimiento
*/

import 'dart:io';

void main() {
  // 1. Creamos una caja (variable) para ir sumando las ventas de los 7 días
  int totalVentasVendedor = 0;

  print('--- CONTROL DE VENTAS SEMANALES ---');

  // 2. ¡Aquí empieza el ciclo FOR! 
  // Decimos: "Empezamos en el día 1, avanza de 1 en 1, y detente cuando pases del día 7"
  for (int dia = 1; dia <= 7; dia++) {
    
    // Pedimos la venta del día actual
    stdout.write('Ingrese las ventas del día $dia: ');
    
    // Leemos lo que el usuario escribe. 
    // int.parse() transforma el texto en un número entero para poder sumarlo.
    int ventasDelDia = int.parse(stdin.readLineSync()!);

    // Evaluamos el rendimiento de ESTE DÍA según las reglas
    String rendimientoDelDia;
    if (ventasDelDia < 10) {
      rendimientoDelDia = 'Bajo rendimiento';
    } else if (ventasDelDia <= 25) {
      rendimientoDelDia = 'Rendimiento normal';
    } else {
      rendimientoDelDia = 'Alto rendimiento';
    }

    print('   -> Rendimiento del día $dia: $rendimientoDelDia');

    totalVentasVendedor = totalVentasVendedor + ventasDelDia; 
  }

    double promedioVentas = totalVentasVendedor / 7;

  String rendimientoGeneral;
  if (promedioVentas < 10) {
    rendimientoGeneral = 'Bajo rendimiento';
  } else if (promedioVentas <= 25) {
    rendimientoGeneral = 'Rendimiento normal';
  } else {
    rendimientoGeneral = 'Alto rendimiento';
  }

  print('\n==================================================');
  print('          REPORTE FINAL DEL VENDEDOR              ');
  print('==================================================');
  print('Total de ventas en la semana: $totalVentasVendedor');
  print('Promedio de ventas diarias: ${promedioVentas.toStringAsFixed(2)}');
  print('Clasificación final: $rendimientoGeneral');
  print('==================================================');
}