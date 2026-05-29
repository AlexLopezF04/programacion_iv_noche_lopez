void main() {
  // Lista con los IDs o estados de carga de las videolecciones en un módulo.
  // El valor -1 representa una lección que falló al cargar el video en el servidor.
  final listaVideosModulo = [10, 15, 22, -1, 45, 60, -1, 5];

  // === 1. CONTINUE — Salta el error menor y sigue con la reproducción ===
  print('=== MODO PLAYLIST: Procesando con CONTINUE ===');
  for (final videoId in listaVideosModulo) {
    if (videoId < 0) {
      print('⚠️ Video corrupto o no encontrado. Saltando a la siguiente clase...');
      continue; // Salta esta iteración y pasa inmediatamente al siguiente video de la lista
    }
    print('▶️ Reproduciendo con éxito la lección con ID: $videoId');
  }


  // === 2. BREAK — Detiene todo el proceso ante un evento crítico ===
  print('\n=== MODO EXAMEN: Procesando con BREAK ===');
  // Imagina que la lista ahora representa las respuestas de un examen monitorizado
  // El valor -1 representa que el sistema detectó que el alumno minimizó la ventana del test
  final logsExamenSeguro = [1, 1, 1, -1, 1, 0, 1]; 

  for (final estadoLog in logsExamenSeguro) {
    if (estadoLog < 0) {
      print('🚨 Alerta de seguridad: Intento de copia detectado.');
      print('❌ Cancelando el examen inmediatamente. Bloqueando intento.');
      break; // Rompe y sale por completo del bucle, ignorando las preguntas restantes
    }
    print('✍️ Procesando respuesta del estudiante... [Válida]');
  }
}