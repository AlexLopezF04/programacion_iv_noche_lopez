void main() {
  // === 1. FOR CON ÍNDICE (Listar elementos con su número de orden) ===
  // Útil para mostrar el índice o el número de lección en el temario de un módulo
  for (int i = 1; i <= 5; i++) {
    print('Lección $i: Introducción a la arquitectura');
  }


  // === 2. FOR CON PASO DISTINTO (Incrementos personalizados) ===
  // Tu ejemplo original de progreso ya encajaba genial en e-learning. 
  // Lo mapeamos al avance de un estudiante al completar hitos del curso.
  for (int porciento = 0; porciento <= 100; porciento += 25) {
    print('Progreso del estudiante: $porciento% completado');
  }


  // === 3. FOR DECRECIENTE (Cuentas regresivas) ===
  // Ideal para controlar el tiempo restante en un examen de certificación antes de cerrarse
  for (int minutosRestantes = 5; minutosRestantes >= 1; minutosRestantes--) {
    print('¡Atención! Faltan $minutosRestantes minutos para que termine la prueba.');
  }


  // === 4. FOR-IN (La forma idiomática para recorrer colecciones) ===
  // Es la manera más limpia en Dart de recorrer listas, por ejemplo, los nombres de los instructores
  final instructores = ['Alex', 'BaconJ', 'Pachar', 'Ana', 'Carlos'];

  for (final instructor in instructores) {
    print('Instructor destacado: $instructor');
  }


  // === 5. FOREACH CON LAMBDA / FUNCIÓN ANÓNIMA (Alternativa funcional) ===
  // Útil para operaciones rápidas en una sola línea, como formatear etiquetas (tags)
  final categorias = ['DESARROLLO', 'DISEÑO', 'MARKETING'];
  categorias.forEach((cat) => print('Categoría formateada: ${cat.toLowerCase()}'));


  // === 6. FOR-IN SOBRE UN MAP (Llave y Valor) ===
  // Excelente para recorrer estructuras de datos complejas, como los precios asociados a cada tipo de curso
  final catalogoPrecios = {
    'Curso de NestJS': 49.99,
    'Master en Flutter': 89.99,
    'Bases de Datos con PostgreSQL': 29.99
  };

  for (final item in catalogoPrecios.entries) {
    print('El curso "${item.key}" tiene un costo de: \$${item.value}');
  }


  // === 7. FOR-IN SOBRE CARACTERES DE UN STRING (Corregido y Adaptado) ===
  // Como un String no es iterable por sí mismo, usamos .split('') para separarlo en letras individuales.
  // Útil para enmascarar o validar contraseñas o tokens de la plataforma.
  final siglaPlataforma = 'EDUTESH';
  
  print('Generando logo animado letra por letra:');
  for (final letra in siglaPlataforma.split('')) {
    print(' -> $letra');
  }
}