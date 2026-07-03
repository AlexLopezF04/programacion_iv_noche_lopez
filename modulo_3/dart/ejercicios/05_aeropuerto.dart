/*
Enunciado
Un aeropuerto controla la operación diaria de sus agentes de embarque, registrando vuelos, pasajeros y retrasos.
Realiza un programa en Dart que use readLineSync() y un ciclo while para ingresar por cada agente:
Cantidad de vuelos atendidos
Cantidad de pasajeros procesados
Minutos totales de retraso
Dentro del ciclo, calcular:
Pasajeros por vuelo
Índice de retraso por vuelo:
[
\text{Retraso por vuelo} = \frac{\text{Minutos de retraso}}{\text{Vuelos}}
]
Reglas de negocio:
Menos de 50 pasajeros por vuelo → “Baja eficiencia”
Entre 50 y 120 pasajeros por vuelo → “Eficiencia normal”
Más de 120 pasajeros por vuelo → “Alta eficiencia”
El programa debe continuar mientras la cantidad de vuelos sea mayor a 0.
Al finalizar, mostrar:
Total de pasajeros procesados
Total de minutos de retraso acumulados
Cantidad de agentes registrados
Promedio de pasajeros por agente
Promedio general de retraso por vuelo
*/

import 'dart:io';

void main() {
  int totalPasajerosGral = 0;
  int totalRetrasoGral = 0;
  int totalVuelosGral = 0;
  int cantidadAgentes = 0;

  print('--- REGISTRO DE OPERACIONES DEL AEROPUERTO ---');

  stdout.write('\nCantidad de vuelos atendidos por el agente (0 para salir): ');
  int vuelos = int.parse(stdin.readLineSync()!);

  while (vuelos > 0) {
    stdout.write('Cantidad de pasajeros procesados: ');
    int pasajeros = int.parse(stdin.readLineSync()!);

    stdout.write('Minutos totales de retraso: ');
    int minutosRetraso = int.parse(stdin.readLineSync()!);

    double pasajerosPorVuelo = pasajeros / vuelos;
    double retrasoPorVuelo = minutosRetraso / vuelos;

    String eficiencia;
    if (pasajerosPorVuelo < 50) {
      eficiencia = 'Baja eficiencia';
    } else if (pasajerosPorVuelo <= 120) {
      eficiencia = 'Eficiencia normal';
    } else {
      eficiencia = 'Alta eficiencia';
    }

    print('\n>> Resultados del Agente:');
    print('   - Pasajeros por vuelo: ${pasajerosPorVuelo.toStringAsFixed(2)} ($eficiencia)');
    print('   - Índice de retraso por vuelo: ${retrasoPorVuelo.toStringAsFixed(2)} min/vuelo');
    print('--------------------------------------------------');

    totalPasajerosGral += pasajeros;
    totalRetrasoGral += minutosRetraso;
    totalVuelosGral += vuelos;
    cantidadAgentes++;

    stdout.write('\nCantidad de vuelos atendidos por el siguiente agente (0 para salir): ');
    vuelos = int.parse(stdin.readLineSync()!);
  }

  if (cantidadAgentes > 0) {
    double promedioPasajerosPorAgente = totalPasajerosGral / cantidadAgentes;
    double promedioGralRetrasoPorVuelo = totalRetrasoGral / totalVuelosGral;

    print('\n==================================================');
    print('                REPORTE FINAL                     ');
    print('==================================================');
    print('Total de pasajeros procesados: $totalPasajerosGral');
    print('Total de minutos de retraso acumulados: $totalRetrasoGral min');
    print('Cantidad de agentes registrados: $cantidadAgentes');
    print('Promedio de pasajeros por agente: ${promedioPasajerosPorAgente.toStringAsFixed(2)}');
    print('Promedio general de retraso por vuelo: ${promedioGralRetrasoPorVuelo.toStringAsFixed(2)} min/vuelo');
    print('==================================================');
  } else {
    print('\nNo se registraron datos de agentes.');
  }
}