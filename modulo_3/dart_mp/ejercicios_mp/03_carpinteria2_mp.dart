/*
Enunciado
Una plataforma de cursos online controla la cantidad de lecciones vistas por cada estudiante durante el día.
Realiza un programa en Dart que use readLineSync() y un ciclo while para ingresar la cantidad de lecciones vistas por estudiante.
Reglas de negocio:
Menos de 15 lecciones -> "Ritmo lento"
Entre 15 y 40 lecciones -> "Ritmo eficiente"
Más de 40 lecciones -> "Ritmo sobresaliente"
El programa debe seguir solicitando datos mientras se ingresen valores mayores a 0.
Cuando el usuario ingrese 0, mostrar:
Total de lecciones vistas
Cantidad de estudiantes registrados
Promedio de lecciones por estudiante
*/

import 'dart:io';

void main() {
  int totalLeccionesGral = 0;
  int cantidadEstudiantes = 0;

  print('--- CONTROL DE LECCIONES VISTAS: CURSOS ONLINE ---');

  stdout.write('\nLecciones vistas por el estudiante (0 para salir): ');
  int lecciones = int.parse(stdin.readLineSync()!);

  while (lecciones > 0) {
    
    String evaluacionRitmo;
    if (lecciones < 15) {
      evaluacionRitmo = 'Ritmo lento';
    } else if (lecciones <= 40) {
      evaluacionRitmo = 'Ritmo eficiente';
    } else {
      evaluacionRitmo = 'Ritmo sobresaliente';
    }

    print('>> Rendimiento del estudiante: $evaluacionRitmo');
    print('--------------------------------------------------');

    totalLeccionesGral += lecciones;
    cantidadEstudiantes++;

    stdout.write('\nLecciones vistas por el siguiente estudiante (0 para salir): ');
    lecciones = int.parse(stdin.readLineSync()!);
  }

  if (cantidadEstudiantes > 0) {
    double promedioLeccionesPorEstudiante = totalLeccionesGral / cantidadEstudiantes;

    print('\n==================================================');
    print('                REPORTE FINAL                     ');
    print('==================================================');
    print('Total de lecciones vistas: $totalLeccionesGral');
    print('Cantidad de estudiantes registrados: $cantidadEstudiantes');
    print('Promedio de lecciones por estudiante: ${promedioLeccionesPorEstudiante.toStringAsFixed(2)}');
    print('==================================================');
  } else {
    print('\nNo se registraron datos de estudiantes.');
  }
}
