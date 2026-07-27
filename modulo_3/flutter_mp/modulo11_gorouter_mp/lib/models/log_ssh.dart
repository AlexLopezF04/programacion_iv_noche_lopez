class LogSSH {
  final String id;
  final String servidorId;
  final String timestamp;
  final String nivel;
  final String mensaje;

  const LogSSH({
    required this.id,
    required this.servidorId,
    required this.timestamp,
    required this.nivel,
    required this.mensaje,
  });
}

const logsSimulados = [
  LogSSH(id: '1', servidorId: '1', timestamp: 'Completado ✓',
      nivel: 'COMPLETO', mensaje: 'Clase 1: Introducción a Dart y Programación Funcional'),
  LogSSH(id: '2', servidorId: '1', timestamp: 'Completado ✓',
      nivel: 'COMPLETO', mensaje: 'Clase 2: Estructuras de datos básicas en Dart'),
  LogSSH(id: '3', servidorId: '1', timestamp: 'En Progreso ⋯',
      nivel: 'PROGRESO', mensaje: 'Clase 3: Widgets Básicos en Flutter'),
  LogSSH(id: '4', servidorId: '1', timestamp: 'Pendiente 𐄂',
      nivel: 'PENDIENTE', mensaje: 'Clase 4: Layouts Complejos y Rows/Columns'),
  LogSSH(id: '5', servidorId: '2', timestamp: 'Completado ✓',
      nivel: 'COMPLETO', mensaje: 'Clase 1: Introducción a Bases de Datos Relacionales'),
  LogSSH(id: '6', servidorId: '2', timestamp: 'Pendiente 𐄂',
      nivel: 'PENDIENTE', mensaje: 'Clase 2: Consultas Avanzadas SELECT & JOIN'),
  LogSSH(id: '7', servidorId: '3', timestamp: 'Completado ✓',
      nivel: 'COMPLETO', mensaje: 'Clase 1: Configurando Node.js y primer Hola Mundo'),
];

