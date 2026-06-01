import 'dart:io';

void main() {
  // === 1. LECTURA DE TEXTO BÁSICA (String nullable) ===
  // Simula el registro del nombre de un nuevo estudiante
  print('--- REGISTRO DE NUEVO ESTUDIANTE ---');
  print('Ingrese el nombre completo del estudiante:');
  
  // stdin.readLineSync() puede devolver null si la consola se cierra inesperadamente, 
  // por eso lo guardamos de forma segura en un String? (nullable)
  String? estudianteNombre = stdin.readLineSync();
  print('✅ Estudiante registrado exitosamente: $estudianteNombre\n');


  // === 2. LECTURA Y CONVERSIÓN ENTERA (int con !) ===
  // Simula la configuración de la cantidad de lecciones de un curso
  print('--- CONFIGURACIÓN DEL CURSO ---');
  print('Ingrese la cantidad total de lecciones para el curso:');
  
  // Usamos el operador "!" (null-assertion) para asegurarle a Dart que el usuario 
  // va a escribir algo en la consola y no enviará un valor nulo. Luego parseamos a int.
  int totalLecciones = int.parse(stdin.readLineSync()!);
  print('✅ Estructura actualizada: El curso contendrá $totalLecciones lecciones.\n');


  // === 3. LECTURA Y CONVERSIÓN DECIMAL (double con !) ===
  // Simula la asignación del precio de lanzamiento del curso
  print('--- CONFIGURACIÓN DE PRECIOS ---');
  print('Ingrese el precio sugerido de venta (ej. 49.99):');
  
  // Leemos la entrada de consola, aseguramos que no es nula con "!" y la transformamos a double
  double precioCurso = double.parse(stdin.readLineSync()!);
  print('✅ Catálogo actualizado: El precio final de venta es \$$precioCurso USD');
}