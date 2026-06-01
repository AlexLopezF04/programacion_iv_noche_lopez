// 1. Función sin parámetros y sin retorno
// Ideal para disparar acciones fijas, como limpiar la sesión actual del usuario.
void cerrarSesionPlataforma() {
  print('Cerrando sesión de usuario... Redirigiendo a la página de login.');
}

// 2. Función con parámetros y sin retorno
// Útil para enviar notificaciones personalizadas instantáneas.
void enviarAlertaInscripcion(String cursoNombre) {
  print('🔔 NOTIFICACIÓN: ¡Te has inscrito con éxito al "$cursoNombre"!');
}

// 3. Función sin parámetros y con retorno
// Simula consultar un límite estático de la plataforma desde las configuraciones.
int obtenerLimiteCursosGratis() {
  return 3; // Un usuario gratis solo puede ver 3 cursos de prueba
}

// 4. Función con parámetros y con retorno
// Lógica para acumular el tiempo total de reproducción que lleva un estudiante.
int acumularMinutos(int minutosVistos, int minutosNuevos) {
  return minutosVistos + minutosNuevos;
}

// 5. Función flecha (Arrow Function)
// Expresiones compactas ideales para cálculos rápidos de facturación, como aplicar cupones.
double aplicarDescuento(double precio, double descuento) => precio * (1 - descuento);

// 6. Función con parámetro posicional opcional (entre corchetes [ ])
// Útil cuando el segundo apellido del estudiante o un código de referido no son obligatorios.
void mostrarPerfilEstudiante(String primerNombre, [String segundoNombre = '']) {
  if (segundoNombre.isEmpty) {
    print('Estudiante: $primerNombre');
  } else {
    print('Estudiante: $primerNombre $segundoNombre');
  }
}

// 7. Función con parámetros nombrados (entre llaves { }) y obligatorios (required)
// Es el estándar más usado en Flutter y Dart profesional. Evita errores de orden al enviar datos del formulario.
void registrarInstructor({
  required String nombreCompleto,
  required String especialidad,
}) {
  print('🚀 Nuevo instructor creado: $nombreCompleto | Especialidad: $especialidad');
}

void main() {
  // Ejecución de la función sin parámetros ni retorno
  cerrarSesionPlataforma();

  // Ejecución con parámetros posicionales
  enviarAlertaInscripcion('Master en NestJS con Spring Boot');

  // Captura y uso de retornos de datos
  int limiteCursos = obtenerLimiteCursosGratis();
  print('Límite actual: $limiteCursos');
  print('Cursos permitidos en el plan free: ${obtenerLimiteCursosGratis()}');

  // Operaciones aritméticas encapsuladas en funciones
  print('Tiempo total de estudio: ${acumularMinutos(120, 45)} minutos');

  // Uso de la función flecha para precios
  print('Precio con descuento de preventa: \$${aplicarDescuento(49.99, 0.20)}');

  // Parámetros opcionales en acción (con y sin el segundo argumento)
  mostrarPerfilEstudiante('Alex', 'Alexander');
  mostrarPerfilEstudiante('BaconJ');

  // Parámetros nombrados. Nota cómo especificas la etiqueta de cada campo (clave: valor)
  // lo cual hace que el código sea autodocumentado y súper fácil de leer.
  registrarInstructor(nombreCompleto: 'Pachar Dev', especialidad: 'Cybersecurity & Cloud');
}