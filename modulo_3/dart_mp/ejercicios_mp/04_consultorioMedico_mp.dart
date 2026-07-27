/*
Enunciado
Una plataforma de cursos online registra la cantidad de estudiantes inscritos y las horas de contenido completadas por cada instructor.
Realiza un programa en Dart que use readLineSync() y un ciclo while para ingresar:
Horas de contenido completadas
Cantidad de estudiantes inscritos
Dentro del ciclo, calcular los estudiantes por hora de contenido.
Reglas de negocio:
Menos de 3 estudiantes por hora -> "Demanda baja"
Entre 3 y 6 estudiantes por hora -> "Demanda normal"
Más de 6 estudiantes por hora -> "Demanda alta"
El programa debe continuar mientras las horas de contenido sean mayores a 0.
Al finalizar, mostrar:
Total de estudiantes inscritos
Cantidad de instructores registrados
Promedio de estudiantes por instructor
*/

import 'dart:io';

void main() {
  int totalEstudiantesGral = 0;
  int cantidadInstructores = 0;

  print('--- REGISTRO DE DEMANDA DE CURSOS ONLINE ---');

  stdout.write('\nHoras de contenido completadas por el instructor (0 para salir): ');
  int horas = int.parse(stdin.readLineSync()!);

  while (horas > 0) {
    stdout.write('Cantidad de estudiantes inscritos: ');
    int estudiantes = int.parse(stdin.readLineSync()!);

    double estudiantesPorHora = estudiantes / horas;

    String nivelDemanda;
    if (estudiantesPorHora < 3) {
      nivelDemanda = 'Demanda baja';
    } else if (estudiantesPorHora <= 6) {
      nivelDemanda = 'Demanda normal';
    } else {
      nivelDemanda = 'Demanda alta';
    }

    print('\n>> Resultados del Instructor:');
    print('   - Estudiantes por hora: ${estudiantesPorHora.toStringAsFixed(2)} ($nivelDemanda)');
    print('--------------------------------------------------');

    totalEstudiantesGral += estudiantes;
    cantidadInstructores++;

    stdout.write('\nHoras de contenido del siguiente instructor (0 para salir): ');
    horas = int.parse(stdin.readLineSync()!);
  }

  if (cantidadInstructores > 0) {
    double promedioEstudiantesPorInstructor = totalEstudiantesGral / cantidadInstructores;

    print('\n==================================================');
    print('                REPORTE FINAL                     ');
    print('==================================================');
    print('Total de estudiantes inscritos: $totalEstudiantesGral');
    print('Cantidad de instructores registrados: $cantidadInstructores');
    print('Promedio de estudiantes por instructor: ${promedioEstudiantesPorInstructor.toStringAsFixed(2)}');
    print('==================================================');
  } else {
    print('\nNo se registraron datos de instructores.');
  }
}
