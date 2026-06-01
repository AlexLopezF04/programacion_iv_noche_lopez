// === 1. PARÁMETRO POSICIONAL OPCIONAL NULLABLE ===
// Construye la ruta de un recurso multimedia o archivo complementario del curso.
// El tercer parámetro (version) es opcional; si no se envía, se genera la ruta estándar.
String construirRutaVideo(String dominio, String leccionSlug, [int? version]) {
  if (version != null) {
    return 'https://$dominio/v$version/content/$leccionSlug.mp4';
  }
  return 'https://$dominio/content/$leccionSlug.mp4';
}

// === 2. PARÁMETRO POSICIONAL CON VALOR POR DEFECTO ===
// Evita evaluar nulos dándole un valor estándar al parámetro opcional.
// Por defecto, asumimos que los videos se cargan en calidad estándar (1080p).
String construirRutaVideoV2(String dominio, String leccionSlug, [int calidadP = 1080]) {
  return 'https://$dominio/res-$calidadP/$leccionSlug.mp4';
}

// === 3. PARÁMETROS NOMBRADOS (required + opcionales con valor por defecto) ===
// Ideal para inicializar conexiones críticas de la plataforma.
// host y puerto de la base de datos son obligatorios, el estado del SSL y el timeout tienen valores por defecto.
void conectarServidorBD({
  required String host,
  required int puerto,
  bool usarSSL = true,
  int tiempoEsperaSeg = 30,
}) {
  final protocolo = usarSSL ? 'Servicios Protegidos (HTTPS/WSS)' : 'Modo Inseguro (HTTP)';
  print('Conectando la plataforma a: $host:$puerto | Protocolo: $protocolo | Espera máxima: ${tiempoEsperaSeg}s');
}

void main() {
  // Pruebas de construcción de rutas multimedia
  print(construirRutaVideo('cdn.edutesh.com', 'introduccion-dart')); 
  // Resultado: https://cdn.edutesh.com/content/introduccion-dart.mp4

  print(construirRutaVideo('cdn.edutesh.com', 'introduccion-dart', 2)); 
  // Resultado: https://cdn.edutesh.com/v2/content/introduccion-dart.mp4

  print(construirRutaVideoV2('cdn.edutesh.com', 'programacion-orientada-objetos'));
  // Resultado: https://cdn.edutesh.com/res-1080/programacion-orientada-objetos.mp4


  // === LLAMADAS A PARÁMETROS NOMBRADOS ===

  // Caso A: Pasando todos los parámetros en cualquier orden (Conexión a la BD local o de pruebas)
  conectarServidorBD(
    host: 'db.edutesh.internal',
    puerto: 5432, // Servidor PostgreSQL de los cursos
    usarSSL: false, // Localmente podemos trabajar sin certificados
    tiempoEsperaSeg: 60,
  );

  // Caso B: Enviando únicamente los campos requeridos (Conexión de producción a la API)
  // Al omitir usarSSL y tiempoEsperaSeg, Dart les asigna automáticamente "true" y "30".
  conectarServidorBD(
    host: 'api.edutesh.com',
    puerto: 443,
  );
}