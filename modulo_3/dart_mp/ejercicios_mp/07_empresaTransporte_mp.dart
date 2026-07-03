/*
Enunciado 2
Una plataforma de cursos online registra las horas de contenido por módulo que cada instructor crea durante un curso de 5 módulos.
Realiza un programa en Dart que use readLineSync() y un ciclo for para ingresar las horas de contenido de cada módulo.
Dentro del ciclo, calcular:
Total de horas de contenido
Consumo estimado de ancho de banda (1 GB por cada 12 h):
  gb=horas/12
Reglas de negocio:
Menos de 50 h por módulo -> "Módulo corto"
Entre 50 y 150 h por módulo -> "Módulo estándar"
Más de 150 h por módulo -> "Módulo extenso"
Al finalizar, mostrar:
Total de horas de contenido
Total de ancho de banda estimado
Promedio de horas por módulo
*/

import 'dart:io';

void main() {
  double totalHoras = 0;

  print('--- REGISTRO DE HORAS DE CONTENIDO - CURSOS ONLINE ---');

  for (int modulo = 1; modulo <= 5; modulo++) {
    
    stdout.write('\nIngrese las horas de contenido del módulo $modulo: ');
    
    double horasModulo = double.parse(stdin.readLineSync()!);

    String tipoModulo;
    if (horasModulo < 50) {
      tipoModulo = 'Módulo corto';
    } else if (horasModulo <= 150) {
      tipoModulo = 'Módulo estándar';
    } else {
      tipoModulo = 'Módulo extenso';
    }

    print('   -> Clasificación del módulo $modulo: $tipoModulo');

    totalHoras = totalHoras + horasModulo;
  }

  double anchoBandaTotal = totalHoras / 12;

  double promedioHoras = totalHoras / 5;

  print('\n==================================================');
  print('                REPORTE DEL CURSO                 ');
  print('==================================================');
  print('Total de horas de contenido: ${totalHoras.toStringAsFixed(1)} h');
  print('Total de ancho de banda estimado: ${anchoBandaTotal.toStringAsFixed(2)} GB');
  print('Promedio de horas por módulo: ${promedioHoras.toStringAsFixed(2)} h/módulo');
  print('==================================================');
}
