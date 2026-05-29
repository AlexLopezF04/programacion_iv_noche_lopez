import 'dart:io';

// async → la función ahora retorna un Future<String> que se resolverá en el futuro
Future<String> verificarEstadoSuscripción(String estudianteId) async {
  print("📡 [API] Conectando con el servidor de pasarela de pagos...");
  
  // await suspende temporalmente la ejecución de esta función hasta que el Future termine
  await Future.delayed(Duration(milliseconds: 2000));  // Simula 2 segundos de latencia de red
  
  print("📥 [API] Respuesta recibida desde el servidor.");
  return 'PLAN_GOLD_ACTIVO';
}

// void main también se marca como async para poder usar 'await' en su interior
void main() async {
  print('🚀 [App] Iniciando validación de acceso para el usuario...');
  
  // La ejecución de main espera pacientemente aquí sin congelar la interfaz de usuario
  final estadoPlan = await verificarEstadoSuscripción('USR-9942');
  
  print('🔒 [App] Nivel de acceso del alumno: $estadoPlan');
  print('✅ [App] Contenido multimedia desbloqueado con éxito.');
}