void main() {
  // === 1. VARIABLES BÁSICAS Y TIPOS ===
  var nombreCurso = 'Dart desde cero';
  var cupoMaximo  = 50;
  var precio      = 89.99;
  var activo      = true;

  String instructor = 'Carlos García';
  int    duracion   = 40;
  double rating     = 4.7;
  bool   certificado = false;

  print('$nombreCurso por $instructor, $duracion h, rating: $rating, cupo: $cupoMaximo, precio: \$$precio, activo: $activo, certificado: $certificado');

  // === 2. FINAL VS CONST ===
  final plataforma = 'Udemy';
  const version    = 1.0;

  final ahora = DateTime.now();

  print('Plataforma: $plataforma v$version, creado: $ahora');

  // === 3. MUTABILIDAD ===
  var totalEstudiantes = 0;
  totalEstudiantes = 1;
  print('Estudiantes: $totalEstudiantes');

  final listaCursos = ['Dart', 'Flutter', 'Kotlin'];
  listaCursos.add('Swift');

  const categorias = ['Programación', 'Diseño', 'Datos'];
  print('Categorías: $categorias');

  // === 4. NULL SAFETY ===
  String email = 'alumno@email.com';
  print('Email: $email');

  String? descuento = null;
  descuento = 'BIENVENIDA10';

  String? codigoPromo2;
  codigoPromo2 = 'DESC50';

  print(codigoPromo2.length);

  String resultado = codigoPromo2;
  print(resultado);

  print(descuento.length);

  // === 5. LATE ===
  late String tokenCurso;
  tokenCurso = 'CUR-001';
  print(tokenCurso);
}
