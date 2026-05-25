/*
Enunciado 2
Una empresa de transporte registra los kilómetros recorridos por sus conductores durante un turno de 5 viajes.
Realiza un programa en Dart que use readLineSync() y un ciclo for para ingresar los kilómetros de cada viaje.
Dentro del ciclo, calcular:
Total de kilómetros recorridos
Consumo estimado de combustible (1 litro por cada 12 km):
  litros=km/12
Reglas de negocio:
Menos de 50 km por viaje → “Ruta corta”
Entre 50 y 150 km por viaje → “Ruta media”
Más de 150 km por viaje → “Ruta larga”
Al finalizar, mostrar:
Total de kilómetros recorridos
Total de combustible estimado
Promedio de kilómetros por viaje
*/

import 'dart:io';

void main() {
  double totalKilometros = 0;

  print('--- REGISTRO DE KILÓMETROS - EMPRESA DE TRANSPORTE ---');

  for (int viaje = 1; viaje <= 5; viaje++) {
    
    stdout.write('\nIngrese los kilómetros del viaje $viaje: ');
    
    double kmViaje = double.parse(stdin.readLineSync()!);

    String tipoRuta;
    if (kmViaje < 50) {
      tipoRuta = 'Ruta corta';
    } else if (kmViaje <= 150) {
      tipoRuta = 'Ruta media';
    } else {
      tipoRuta = 'Ruta larga';
    }

    print('   -> Clasificación del viaje $viaje: $tipoRuta');

    totalKilometros = totalKilometros + kmViaje;
  }

  double combustibleTotal = totalKilometros / 12;

  double promedioKm = totalKilometros / 5;

  print('\n==================================================');
  print('                REPORTE DEL TURNO                 ');
  print('==================================================');
  print('Total de kilómetros recorridos: ${totalKilometros.toStringAsFixed(1)} km');
  print('Total de combustible estimado: ${combustibleTotal.toStringAsFixed(2)} litros');
  print('Promedio de kilómetros por viaje: ${promedioKm.toStringAsFixed(2)} km/viaje');
  print('==================================================');
}