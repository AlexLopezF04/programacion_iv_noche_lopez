/*
Enunciado
Una plataforma de cursos online controla la operación diaria de sus instructores, registrando cursos, estudiantes y calificaciones.
Realiza un programa en Dart que use readLineSync() y un ciclo while para ingresar por cada instructor:
Cantidad de cursos publicados
Cantidad de estudiantes inscritos
Minutos totales de contenido grabado
Dentro del ciclo, calcular:
Estudiantes por curso
Minutos de contenido por curso
Reglas de negocio:
Menos de 50 estudiantes por curso -> "Baja demanda"
Entre 50 y 120 estudiantes por curso -> "Demanda normal"
Más de 120 estudiantes por curso -> "Alta demanda"
El programa debe continuar mientras la cantidad de cursos sea mayor a 0.
Al finalizar, mostrar:
Total de estudiantes inscritos
Total de minutos de contenido grabados
Cantidad de instructores registrados
Promedio de estudiantes por instructor
Promedio general de minutos por curso
*/

import 'dart:io';

void main() {
  int totalEstudiantesGral = 0;
  int totalMinutosGral = 0;
  int totalCursosGral = 0;
  int cantidadInstructores = 0;

  print('--- REGISTRO DE OPERACIONES DE CURSOS ONLINE ---');

  stdout.write('\nCursos publicados por el instructor (0 para salir): ');
  int cursos = int.parse(stdin.readLineSync()!);

  while (cursos > 0) {
    stdout.write('Estudiantes inscritos: ');
    int estudiantes = int.parse(stdin.readLineSync()!);

    stdout.write('Minutos totales de contenido grabado: ');
    int minutosContenido = int.parse(stdin.readLineSync()!);

    double estudiantesPorCurso = estudiantes / cursos;
    double minutosPorCurso = minutosContenido / cursos;

    String demanda;
    if (estudiantesPorCurso < 50) {
      demanda = 'Baja demanda';
    } else if (estudiantesPorCurso <= 120) {
      demanda = 'Demanda normal';
    } else {
      demanda = 'Alta demanda';
    }

    print('\n>> Resultados del Instructor:');
    print('   - Estudiantes por curso: ${estudiantesPorCurso.toStringAsFixed(2)} ($demanda)');
    print('   - Minutos de contenido por curso: ${minutosPorCurso.toStringAsFixed(2)} min/curso');
    print('--------------------------------------------------');

    totalEstudiantesGral += estudiantes;
    totalMinutosGral += minutosContenido;
    totalCursosGral += cursos;
    cantidadInstructores++;

    stdout.write('\nCursos publicados por el siguiente instructor (0 para salir): ');
    cursos = int.parse(stdin.readLineSync()!);
  }

  if (cantidadInstructores > 0) {
    double promedioEstudiantesPorInstructor = totalEstudiantesGral / cantidadInstructores;
    double promedioGralMinutosPorCurso = totalMinutosGral / totalCursosGral;

    print('\n==================================================');
    print('                REPORTE FINAL                     ');
    print('==================================================');
    print('Total de estudiantes inscritos: $totalEstudiantesGral');
    print('Total de minutos de contenido grabados: $totalMinutosGral min');
    print('Cantidad de instructores registrados: $cantidadInstructores');
    print('Promedio de estudiantes por instructor: ${promedioEstudiantesPorInstructor.toStringAsFixed(2)}');
    print('Promedio general de minutos por curso: ${promedioGralMinutosPorCurso.toStringAsFixed(2)} min/curso');
    print('==================================================');
  } else {
    print('\nNo se registraron datos de instructores.');
  }
}
