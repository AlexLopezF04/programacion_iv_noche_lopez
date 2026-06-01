void main() {
  final estudianteNombre = 'Ana';
  final cursoPrecio = 49.99;

  // === 1. INTERPOLACIÓN BÁSICA ($) ===
  // Ideal para mensajes rápidos y personalizados al estudiante
  print('Bienvenido a la plataforma, $estudianteNombre!'); 


  // === 2. EXPRESIONES DENTRO DE STRINGS (${ }) ===
  // Útil para cálculos rápidos de facturación o formateo de nombres en la interfaz
  print('Cupón de bienvenida: ${estudianteNombre.toUpperCase()}50'); 
  print('Con el 50% de descuento, el curso te queda en: \$${cursoPrecio / 2}');


  // === 3. STRING MULTILÍNEA (Triple comilla) ===
  // Perfecto para plantillas de correos electrónicos de confirmación de compra o recibos
  final reciboMatricula = '''
  =====================================
  	RECIBO DE MATRÍCULA ONLINE       
  =====================================
  Estudiante: $estudianteNombre
  Curso:      Desarrollo Mobile con Flutter
  Total:      \$$cursoPrecio
  Acceso:     ${cursoPrecio > 0 ? 'Inmediato (Pago aprobado)' : 'Pendiente de pago'}
  =====================================
  ''';
  print(reciboMatricula);


  // === 4. RAW STRING (r'...') ===
  // Muy útil en backend/scripts para definir rutas de almacenamiento de recursos 
  // (como los archivos PDF de los certificados) en servidores Windows sin que los '\' se rompan.
  final rutaCertificado = r'C:\PlataformaCursos\Certificados\Ana_García.pdf'; 
  print('Guardando certificado en: $rutaCertificado');


  // === 5. CONCATENACIÓN CLÁSICA (+) ===
  // Menos idiomático en Dart, pero útil para unir partes fijas de texto
  final alertaInscripcion = '¡Felicidades, ' + estudianteNombre + ' ya estás dentro del curso!';
  print(alertaInscripcion);


  // === 6. MÉTODOS ÚTILES DE STRING EN ACCIÓN ===
  
  // Convertir cupones a mayúsculas para evitar errores si el usuario escribe "flutter" en minúsculas
  print('flutter50'.toUpperCase()); // FLUTTER50
  
  // Limpiar espacios en blanco innecesarios cuando el usuario escribe su correo en el formulario de login
  print('   alex@correo.com   '.trim()); // alex@correo.com
  
  // Buscar palabras clave en el buscador de la plataforma
  print('Curso Completo de NestJS'.contains('NestJS')); // true
  
  // Corregir nombres de archivos reemplazando caracteres
  print('clase-01.mp4'.replaceAll('-', '_')); // clase_01.mp4
  
  // Separar las etiquetas (tags) de un curso ingresadas por el instructor separadas por comas
  print('web,mobile,cloud'.split(',')); // [web, mobile, cloud]
  
  // Recortar un texto largo para la vista previa de la tarjeta del curso (Card UI)
  print('Aprende Dart y Flutter desde cero paso a paso...'.substring(0, 18) + '...'); // Aprende Dart y Flu...
  
  // Verificar si un enlace de video cargado por el instructor es seguro
  print('https://videos.cursos.com/v1'.startsWith('https')); // true
  
  // Formatear códigos de lecciones o IDs para que tengan un estándar visual (ej. Sección 00001)
  print('45'.padLeft(5, '0')); // 00045
}