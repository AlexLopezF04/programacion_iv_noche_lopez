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
  // 1. Creamos la caja (variable) para ir sumando todos los kilómetros del turno
  double totalKilometros = 0;

  print('--- REGISTRO DE KILÓMETROS - EMPRESA DE TRANSPORTE ---');

  // 2. ¡Empezamos el ciclo FOR!
  // Decimos: "Empieza en el viaje 1, avanza de 1 en 1, y para cuando termines el viaje 5"
  for (int viaje = 1; viaje <= 5; viaje++) {
    
    // Pedimos los kilómetros del viaje actual
    stdout.write('\nIngrese los kilómetros del viaje $viaje: ');
    
    // Guardamos el número. Usamos double.parse() porque los kilómetros pueden tener decimales (ej. 45.5 km)
    double kmViaje = double.parse(stdin.readLineSync()!);

    // Evaluamos qué tipo de ruta fue ESTE viaje según las reglas
    String tipoRuta;
    if (kmViaje < 50) {
      tipoRuta = 'Ruta corta';
    } else if (kmViaje <= 150) {
      tipoRuta = 'Ruta media';
    } else {
      tipoRuta = 'Ruta larga';
    }

    // Le mostramos al usuario la clasificación de este viaje en específico
    print('   -> Clasificación del viaje $viaje: $tipoRuta');

    // ¡Súper importante! Sumamos los kilómetros de este viaje al total acumulado
    totalKilometros = totalKilometros + kmViaje;
  }

  // 3. Ya salimos del ciclo (ya se registraron los 5 viajes). Ahora hacemos los cálculos finales.

  // Calculamos el combustible total usando la fórmula que nos dieron: litros = km / 12
  double combustibleTotal = totalKilometros / 12;

  // Calculamos el promedio de kilómetros dividiendo el total para los 5 viajes
  double promedioKm = totalKilometros / 5;

  // 4. Mostramos el reporte final en la pantalla de forma ordenada
  print('\n==================================================');
  print('                REPORTE DEL TURNO                 ');
  print('==================================================');
  print('Total de kilómetros recorridos: ${totalKilometros.toStringAsFixed(1)} km');
  print('Total de combustible estimado: ${combustibleTotal.toStringAsFixed(2)} litros');
  print('Promedio de kilómetros por viaje: ${promedioKm.toStringAsFixed(2)} km/viaje');
  print('==================================================');
}