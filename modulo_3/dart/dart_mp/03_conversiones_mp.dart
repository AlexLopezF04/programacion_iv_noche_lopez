void main() {
  // === 1. CONVERSIONES NUMÉRICAS ===
  // Útil para cálculos matemáticos en la pasarela de pago o estadísticas
  int totalLecciones = 42;
  double progresoDecimal = totalLecciones.toDouble(); // 42.0 (para calcular porcentajes)
  String leccionesTexto = totalLecciones.toString();  // "42" (para concatenar en la interfaz gráfica)

  // === 2. STRING → NÚMERO (Formularios de la Plataforma) ===
  // Cuando el administrador ingresa los datos de un curso nuevo en cajas de texto (Input Text)
  int idCursoInput = int.parse('123');              // 123 (ID del curso procesado)
  double precioCursoInput = double.parse('49.99');  // 49.99 (Precio listo para aplicar impuestos)

  // === 3. CONVERSIÓN SEGURA (Evita que la App se caiga si el usuario escribe mal) ===
  // Si un usuario escribe letras en el campo de "cupón" o "precio", tryParse devuelve null en lugar de romper el programa
  int? leccionesInvalidas = int.tryParse('diez');   // null (el usuario metió texto inválido)
  double? descuentoValido = double.tryParse('25');   // 25.0 (conversión exitosa)

  // === 4. VERIFICAR TIPO CON "is" (Smart Cast) ===
  // Ideal cuando recibimos un usuario genérico de la base de datos y queremos saber su rol
  Object usuarioSesion = 'Estudiante'; 
  if (usuarioSesion is String) {
    // Smart cast automático: Dart sabe que dentro de este IF es un String
    print('El rol del usuario tiene una longitud de texto de: ${usuarioSesion.length} caracteres.'); 
  }

  // === 5. CAST EXPLÍCITO CON "as" ===
  // Le aseguramos a Dart que sabemos con certeza qué tipo de dato contiene la variable genérica
  Object datosServidor = 'Curso de Flutter';
  String tituloCurso = datosServidor as String; // Forzamos a que actúe como String
  print('Título casteado: $tituloCurso');

  // === 6. COMPROBAR NULABILIDAD (Manejo de vacíos en progreso) ===
  // Si un alumno es nuevo, su lista de cursos completados puede ser nula (null)
  String? certificadoUrl = null;
  int longitudUrl = certificadoUrl?.length ?? 0; // Si no hay certificado, el tamaño del link es 0
  print('Longitud de la URL del certificado: $longitudUrl'); // 0

  // === 7. NÚMEROS ESPECIALES ===
  // Casos extremos en analíticas o límites de la plataforma
  print(double.infinity);     // Infinity (ej. división para simular un límite sin fin en suscripciones)
  print(double.nan);          // NaN (Not a Number - ej. si se intenta calcular el promedio de 0 calificaciones)
  print(double.maxFinite);    // El valor máximo de almacenamiento numérico que soporta el sistema
}