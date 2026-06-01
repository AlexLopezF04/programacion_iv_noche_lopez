void main() {
  // === 1. VARIABLES BÁSICAS Y TIPOS ===
  // var — tipo inferido 
  var cursoNombre = 'Desarrollo Web con Flutter';  // String
  var estudiantesInscritos = 1420;                // int
  var cursoPrecio = 49.99;                        // double
  var cursoPublicado = true;                      // bool

  // Tipo explícito
  String instructorNombre = 'Alex';
  int leccionesCount = 45;
  double calificacionPromedio = 4.8;
  bool tieneCertificado = true;

  print('El curso "$cursoNombre" dictado por $instructorNombre tiene $estudiantesInscritos alumnos. Calificación: $calificacionPromedio/5');


  // === 2. FINAL VS CONST ===
  // final — inmutable en tiempo de ejecución (runtime)
  // Útil para datos que vienen del servidor o del sistema al momento de ejecutarse
  final cursoId = 'ST-99214-X';
  final fechaInscripcion = DateTime.now(); // OK — cambia según el momento en que se inscribe el alumno

  // const — constante estricta en tiempo de compilación
  // Valores fijos del negocio que jamás van a cambiar ni dependen de la base de datos
  const maxDescuentoPermitido = 0.75; // 75% máximo con cupones
  const precioMinimoCurso = 9.99;     // Ningún curso puede valer menos de $9.99

  // const fechaInscripcionConst = DateTime.now(); // ERROR — no se conoce en compilación

  print('ID Curso: $cursoId, Registrado el: $fechaInscripcion. Cupón Máximo: $maxDescuentoPermitido');


  // === 3. MUTABILIDAD ===
  // var — mutable (el valor de la variable puede cambiar de dirección)
  var totalCarrito = 0.0;
  totalCarrito = 49.99; // El alumno agrega un curso al carrito

  // final — la estructura de la lista no cambia de dirección, pero su contenido interno sí (Mutable de colección)
  final categoriasCurso = ['Programación', 'Diseño UI/UX'];
  categoriasCurso.add('Bases de Datos'); // OK — agregamos una nueva categoría al curso
  // categoriasCurso = ['Marketing'];     // ERROR — No puedes asignarle otra lista nueva

  // const — inmutable profundo (ni la variable ni su contenido interno pueden cambiar)
  const etiquetasObligatorias = ['Educación', 'Online'];
  // etiquetasObligatorias.add('Tech'); // ERROR en runtime — la lista es un bloque de cemento inmutable


  // === 4. NULL SAFETY ===
  // Tipo no-nullable — Un curso obligatoriamente debe tener un título
  String tituloCurso = 'Master en NestJS';
  // tituloCurso = null; // ERROR de compilación — no puede quedar huérfano de nombre

  // Tipo nullable — El código de un cupón de descuento puede no existir (el alumno paga precio completo)
  String? cuponDescuento = null; // OK — no hay cupón aplicado
  cuponDescuento = 'PROMO_NUEVO'; // OK — ahora aplicó un cupón

  // Operadores de null safety para cupones
  String? comentarioAlumno; // Por defecto es null (no ha dejado reseña)

  // ?. — safe call (Acceso seguro)
  print(comentarioAlumno?.length); // Imprime "null" — no rompe la app si no hay texto

  // ?? — operador Elvis (Valor por defecto)
  String resenaTexto = comentarioAlumno ?? 'El estudiante no dejó ningún comentario escrito.';
  print(resenaTexto); 

  // Null check clásico con if
  if (cuponDescuento != null) {
    print('Cupón activo detectado. Longitud del código: ${cuponDescuento.length}'); // Smart cast seguro
  }


  // === 5. LATE (Inicialización diferida) ===
  // Ideal para datos que sabemos que se van a cargar, pero un segundo después (como una petición HTTP)
  late String urlVideoLeccion;
  
  // Simulamos que el servidor responde y le asignamos la URL antes de reproducir
  urlVideoLeccion = 'https://video.plataforma.com/leccion1.mp4'; 
  print('Cargando reproductor con: $urlVideoLeccion');

  // NOTA: Si descomentas esto, romperá la app porque 'comentarioAlumno' sigue siendo null
  // String comentarioObligatorio = comentarioAlumno!; 
}