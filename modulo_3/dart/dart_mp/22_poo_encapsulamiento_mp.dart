class ProgresoEstudiante {
  final String estudiante;
  final String cursoTitulo;
  int _minutosVistos; // Propiedad privada — protegida contra modificaciones externas directas

  ProgresoEstudiante(this.estudiante, this.cursoTitulo, int minutosIniciales)
      : _minutosVistos = minutosIniciales;

  // Getter — Permite leer el progreso de forma pública pero impide su sobreescritura directa
  int get minutosVistos => _minutosVistos;

  // === ÚNICOS CAMINOS PERMITIDOS PARA MODIFICAR EL ESTADO INTERNO ===

  // Método para registrar tiempo de estudio consumido en el reproductor de video
  void registrarAvanceVideo(int minutosEstudiados) {
    if (minutosEstudiados <= 0) {
      throw ArgumentError('El tiempo reproducido debe ser un valor positivo.');
    }
    _minutosVistos += minutosEstudiados;
    print('▶️ [$estudiante] Estudió $minutosEstudiados min más en "$cursoTitulo". Total acumulado: $_minutosVistos min.');
  }

  // Método para corregir o restar tiempo en caso de auditoría (ej. si el sistema detecta inactividad)
  void auditarTiempoInactivo(int minutosPenalizados) {
    if (minutosPenalizados <= 0) {
      throw ArgumentError('El tiempo a penalizar debe ser un valor positivo.');
    }
    if (minutosPenalizados > _minutosVistos) {
      throw StateError('No se puede restar más tiempo del progreso acumulado actual.');
    }
    _minutosVistos -= minutosPenalizados;
    print('⚠️ [Auditoría] Se descontaron $minutosPenalizados min por inactividad. Total actual: $_minutosVistos min.');
  }
}

void main() {
  // Inicializamos el progreso del estudiante con 120 minutos ya completados
  final progreso = ProgresoEstudiante('Alex Lopez', 'Master en NestJS con Dart', 120);

  // El sistema interactúa de forma segura a través de los métodos públicos
  progreso.registrarAvanceVideo(45);   // Agrega minutos con éxito
  progreso.auditarTiempoInactivo(20);  // Resta minutos tras validar las reglas
  
  // === NOTA DE SINTAXIS SOBRE LA PRIVACIDAD EN DART ===
  // Como 'main' y 'ProgresoEstudiante' residen en este mismo archivo, Dart permite leer '_minutosVistos':
  print('Consulta interna (mismo archivo): ${progreso._minutosVistos}'); 

  // REGLA DE ORO: Si mueves la clase 'ProgresoEstudiante' a su propio archivo independiente 
  // e intentas hacer esto desde el main, Dart lanzará un error de compilación definitivo:
  // progreso._minutosVistos = 9999; // ❌ ERROR: El miembro '_minutosVistos' no está definido para la clase.
}