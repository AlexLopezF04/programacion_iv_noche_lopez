void main() {
  // === 1. WHILE (Comprueba la condición ANTES de ejecutar) ===
  // Caso de uso: Descarga secuencial del contenido multimedia de una lección por partes (búfer).
  // Deja de ejecutarse inmediatamente en cuanto el video se descarga por completo (megabytes = 0).
  int fragmentosDescargados = 0;
  int videoTamanoMegabytes = 1050; // Tamaño total del video del curso

  print('--- Iniciando descarga de la videolección ---');
  while (videoTamanoMegabytes > 0) {
    // Descarga en bloques máximos de 256 MB para no saturar la memoria
    final bloqueDescarga = videoTamanoMegabytes > 256 ? 256 : videoTamanoMegabytes;
    fragmentosDescargados++;
    videoTamanoMegabytes -= bloqueDescarga;
    
    print('Fragmento $fragmentosDescargados descargado: $bloqueDescarga MB (Restan: $videoTamanoMegabytes MB por procesar)');
  }


  // === 2. DO-WHILE (Ejecuta AL MENOS UNA VEZ antes de comprobar la condición) ===
  // Caso de uso: Sistema de reintentos para conectar al servidor de exámenes en vivo.
  // Garantiza que el estudiante intente conectarse al menos una vez antes de verificar si el servidor respondió.
  int intentosConexion = 0;
  bool conexionExitosa = false;

  print('\n--- Conectando al servidor de evaluaciones ---');
  do {
    intentosConexion++;
    print('Intentando enlazar con la base de datos de preguntas (Intento #$intentosConexion)...');
    
    // Simulamos que el servidor responde de manera exitosa exactamente en el tercer intento
    if (intentosConexion == 3) {
      conexionExitosa = true;
    }
  } while (!conexionExitosa && intentosConexion < 5);

  // Mensaje final en la interfaz del alumno usando el operador ternario
  print(conexionExitosa
      ? '✅ Acceso concedido: Conexión establecida tras $intentosConexion intentos.'
      : '❌ Error de red: No se pudo conectar al servidor de exámenes. Inténtelo más tarde.');
}