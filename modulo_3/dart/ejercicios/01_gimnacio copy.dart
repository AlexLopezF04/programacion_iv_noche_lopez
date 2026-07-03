/*
Enunciado
Un gimnasio registra la cantidad de minutos que cada cliente entrenó durante el día.
Realiza un programa en Dart que use readLineSync() y un ciclo while para ingresar los minutos de entrenamiento de cada cliente.
Reglas de negocio:
Menos de 30 minutos → “Entrenamiento insuficiente”
Entre 30 y 90 minutos → “Entrenamiento adecuado”
Más de 90 minutos → “Entrenamiento intenso”
El programa debe seguir solicitando datos mientras se ingresen valores mayores a 0.
Cuando el usuario ingrese 0, mostrar:
Total de minutos entrenados
Cantidad de clientes registrados
Promedio de minutos por cliente
*/

import 'dart:io';

void main() {
  // Aquí van las "libretas de anotación" (variables que guardan el progreso)
  int totalMinutos = 0;
  int cantidadClientes = 0;

  // El motor: el ciclo que se repite
  while (true) {
    stdout.write('Ingrese los minutos de entrenamiento (o 0 para salir): ');
    String? input = stdin.readLineSync();
    
    // Convertimos el texto a número. Si es nulo o no es número, asumimos 0.
    int minutos = int.tryParse(input ?? '') ?? 0;

    // REGLA DE SALIDA: ¿Es cero o menor? ¡Rompemos el ciclo!
    if (minutos <= 0) {
      break; // El "break" destruye el ciclo while y nos manda al final
    }

    // PIEZA 2: El filtro (Reglas de negocio)
    if (minutos < 30) {
      print('-> Entrenamiento insuficiente');
    } else if (minutos <= 90) {
      print('-> Entrenamiento adecuado');
    } else {
      print('-> Entrenamiento intenso');
    }

    // PIEZA 3: Anotar en la libreta
    totalMinutos += minutos; // Sumamos los minutos a la bolsa
    cantidadClientes++;      // Sumamos un cliente más
  }

  // AL FINAL (Fuera del ciclo, cuando ya ingresaron 0)
  print('\n--- REPORTE FINAL ---');
  print('Total de minutos entrenados: $totalMinutos');
  print('Cantidad de clientes registrados: $cantidadClientes');
  
  // Evitamos dividir por cero si el primer usuario ingresó 0
  if (cantidadClientes > 0) {
    double promedio = totalMinutos / cantidadClientes;
    print('Promedio de minutos por cliente: ${promedio.toStringAsFixed(2)}');
  } else {
    print('No se registraron clientes.');
  }
}