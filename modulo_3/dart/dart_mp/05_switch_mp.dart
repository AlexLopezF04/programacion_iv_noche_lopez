void main() {
  // === 1. SWITCH TRADICIONAL (Flujo del estado de compra de un curso) ===
  // Nota: En Dart moderno (Dart 3+), ya no es obligatorio usar "break" en cada caso.
  String estadoPagoCurso = 'RECHAZADO';

  switch (estadoPagoCurso) {
    case 'PENDIENTE':
      print('El estudiante está intentando pagar. Mantener acceso bloqueado.');
    case 'PROCESANDO':
      print('Validando fondos con la pasarela de pagos (Stripe/PayPal).');
    case 'APROBADO':
      print('¡Pago exitoso! Matricular al alumno y desbloquear las lecciones.');
    case 'RECHAZADO':
      print('El pago no procedió. Notificar al alumno para que intente con otra tarjeta.');
    case 'REEMBOLSADO':
      print('Dinero devuelto. Revocar acceso al curso y emitir nota de crédito.');
    default:
      print('Estado de orden no identificado. Revisar logs del sistema.');
  }


  // === 2. SWITCH EXPRÉSIÓN (Asigna el resultado directo a una variable) ===
  // Ideal para mapear etiquetas visuales cortas o descripciones según el rol del usuario
  String tipoMembresia = 'PLATINUM';

  // Usamos el switch como expresión. El caracter "_" reemplaza al "default".
  String beneficiosEstudiante = switch (tipoMembresia) {
    'FREE'     => 'Acceso únicamente a los cursos gratuitos de la semana.',
    'BRONZE'   => 'Acceso a cursos básicos. Soporte en el foro por la comunidad.',
    'SILVER'   => 'Acceso a todas las rutas de desarrollo web + Certificados estándar.',
    'GOLD'     => 'Acceso total ilimitado + Mentorías grupales en vivo semanales.',
    'PLATINUM' => 'Acceso total + Revisiones de código 1-a-1 de tus proyectos de Git.',
    _          => 'Plan no reconocido. Redirigiendo a la sección de precios.', 
  };

  print('Tu suscripción actual te otorga: $beneficiosEstudiante');
}