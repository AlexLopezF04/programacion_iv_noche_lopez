void main() {
  // === 1. FORMA BÁSICA (Estructura condicional if / else if / else) ===
  // Determina el nivel de acceso o categoría de un estudiante según su progreso
  int leccionesCompletadas = 38;

  if (leccionesCompletadas >= 40) {
    print('Estado: Curso completado con éxito. ¡Listo para reclamar certificado!');
  } else if (leccionesCompletadas > 10) {
    print('Estado: Estudiante activo. Vas a mitad de camino, ¡sigue así!');
  } else {
    print('Estado: Estudiante rezagado. Aún no has iniciado tus lecciones principales.');
  }


  // === 2. OPERADOR TERNARIO (Decisiones rápidas de una sola línea) ===
  // condición ? valorSiVerdadero : valorSiFalso
  // Útil para cambiar etiquetas dinámicas en la interfaz visual (UI)
  double calificacionExamen = 7.5;
  String estadoMatricula = calificacionExamen >= 7.0 ? 'Aprobado ✅' : 'Reprobado ❌';
  print('Resultado del módulo: $estadoMatricula');


  // === 3. MANEJO DE VACÍOS CON EL OPERADOR TERNARIO ===
  // Si la base de datos no tiene registrado el avatar (foto de perfil) del usuario
  String? avatarUrl; // Viene nulo porque el alumno no ha subido foto

  String fotoMostrada = avatarUrl != null ? avatarUrl : 'https://plataforma.com/images/default-avatar.png';
  print('Imagen de perfil actual: $fotoMostrada');


  // === 4. FORMA MÁS CONCISA Y IDIOMÁTICA CON OPERADOR NULL-AWARE (??) ===
  // El mismo ejemplo anterior, pero optimizado al estilo profesional de Dart
  // Si 'avatarUrl' es nulo, automáticamente usa el valor por defecto de la derecha
  String fotoMostradaOptimizada = avatarUrl ?? 'https://plataforma.com/images/default-avatar.png';
  print('Imagen de perfil (Optimizado): $fotoMostradaOptimizada');
  
  // Otro caso de uso común: Mostrar el nombre de la empresa de facturación si existe, o el nombre personal si no
  String? razonSocial;
  String nombreFactura = razonSocial?.toUpperCase() ?? 'CONSUMIDOR FINAL';
  print('Facturar a nombre de: $nombreFactura'); // CONSUMIDOR FINAL
}