/*
Enunciado
Un consultorio médico registra la cantidad de pacientes atendidos y las horas trabajadas por cada doctor.
Realiza un programa en Dart que use readLineSync() y un ciclo while para ingresar:
Horas trabajadas
Cantidad de pacientes atendidos
Dentro del ciclo, calcular los pacientes atendidos por hora.
Reglas de negocio:
Menos de 3 pacientes por hora → “Atención lenta”
Entre 3 y 6 pacientes por hora → “Atención normal”
Más de 6 pacientes por hora → “Atención rápida”
El programa debe continuar mientras las horas trabajadas sean mayores a 0.
Al finalizar, mostrar:
Total de pacientes atendidos
Cantidad de doctores registrados
Promedio de pacientes por doctor
*/

import 'dart:io';

void main() {
  // Variables acumuladoras para el reporte final (fuera del ciclo)
  int totalPacientesGral = 0;
  int cantidadDoctores = 0;

  print('--- REGISTRO DE CONTROL MÉDICO ---');

  // Primera lectura para evaluar la condición del bucle
  stdout.write('\nHoras trabajadas por el doctor (0 para salir): ');
  int horas = int.parse(stdin.readLineSync()!);

  // El ciclo continúa mientras las horas sean mayores a 0
  while (horas > 0) {
    stdout.write('Cantidad de pacientes atendidos: ');
    int pacientes = int.parse(stdin.readLineSync()!);

    // --- CÁLCULOS POR DOCTOR ---
    double pacientesPorHora = pacientes / horas;

    // Determinar el ritmo de atención según las reglas de negocio
    String ritmoAtencion;
    if (pacientesPorHora < 3) {
      ritmoAtencion = 'Atención lenta';
    } else if (pacientesPorHora <= 6) {
      ritmoAtencion = 'Atención normal';
    } else {
      ritmoAtencion = 'Atención rápida';
    }

    // Mostrar el resultado individual de este doctor
    print('\n>> Resultados del Doctor:');
    print('   - Pacientes por hora: ${pacientesPorHora.toStringAsFixed(2)} ($ritmoAtencion)');
    print('--------------------------------------------------');

    // --- ACUMULACIÓN DE DATOS GLOBALES ---
    totalPacientesGral += pacientes;
    cantidadDoctores++;

    // Volver a pedir las horas para la siguiente iteración
    stdout.write('\nHoras trabajadas por el siguiente doctor (0 para salir): ');
    horas = int.parse(stdin.readLineSync()!);
  }

  // --- REPORTE FINAL ---
  // Validamos que se haya registrado al menos un doctor para evitar dividir por cero
  if (cantidadDoctores > 0) {
    double promedioPacientesPorDoctor = totalPacientesGral / cantidadDoctores;

    print('\n==================================================');
    print('                REPORTE FINAL                     ');
    print('==================================================');
    print('Total de pacientes atendidos: $totalPacientesGral');
    print('Cantidad de doctores registrados: $cantidadDoctores');
    print('Promedio de pacientes por doctor: ${promedioPacientesPorDoctor.toStringAsFixed(2)}');
    print('==================================================');
  } else {
    print('\nNo se registraron datos de doctores.');
  }
}