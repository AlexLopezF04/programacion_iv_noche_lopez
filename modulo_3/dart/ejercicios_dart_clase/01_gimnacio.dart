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
  int totalMinutosGral = 0;
  int cantidadClientes = 0;

  print('--- SISTEMA DE CONTROL DE ENTRENAMIENTO ---');

  stdout.write('\nMinutos de entrenamiento del cliente (0 para salir): ');
  int minutos = int.parse(stdin.readLineSync()!);

  while (minutos > 0) {
    
    String tipoEntrenamiento;
    if (minutos < 30) {
      tipoEntrenamiento = 'Entrenamiento insuficiente';
    } else if (minutos <= 90) {
      tipoEntrenamiento = 'Entrenamiento adecuado';
    } else {
      tipoEntrenamiento = 'Entrenamiento intenso';
    }

    print('>> Evaluación del cliente: $tipoEntrenamiento');
    print('--------------------------------------------------');

    totalMinutosGral += minutos;
    cantidadClientes++;

    stdout.write('\nMinutos de entrenamiento del siguiente cliente (0 para salir): ');
    minutos = int.parse(stdin.readLineSync()!);
  }

  if (cantidadClientes > 0) {
    double promedioMinutosPorCliente = totalMinutosGral / cantidadClientes;

    print('\n==================================================');
    print('                REPORTE FINAL                     ');
    print('==================================================');
    print('Total de minutos entrenados: $totalMinutosGral min');
    print('Cantidad de clientes registrados: $cantidadClientes');
    print('Promedio de minutos por cliente: ${promedioMinutosPorCliente.toStringAsFixed(2)} min');
    print('==================================================');
  } else {
    print('\nNo se registraron datos de clientes.');
  }
}