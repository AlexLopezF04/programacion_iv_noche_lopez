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
  LogSSH(id: '1', servidorId: '1', timestamp: '2024-01-15 10:30:00',
      nivel: 'INFO', mensaje: 'Conexion SSH establecida'),
  LogSSH(id: '2', servidorId: '1', timestamp: '2024-01-15 10:31:15',
      nivel: 'INFO', mensaje: 'Autenticacion exitosa'),
  LogSSH(id: '3', servidorId: '1', timestamp: '2024-01-15 10:32:00',
      nivel: 'WARN', mensaje: 'Uso de CPU superior al 80%'),
  LogSSH(id: '4', servidorId: '1', timestamp: '2024-01-15 10:33:30',
      nivel: 'ERROR', mensaje: 'Timeout en conexion a base de datos'),
  LogSSH(id: '5', servidorId: '2', timestamp: '2024-01-15 09:00:00',
      nivel: 'INFO', mensaje: 'Servicio reiniciado correctamente'),
  LogSSH(id: '6', servidorId: '2', timestamp: '2024-01-15 09:05:20',
      nivel: 'INFO', mensaje: 'Backup completado'),
  LogSSH(id: '7', servidorId: '3', timestamp: '2024-01-14 18:00:00',
      nivel: 'WARN', mensaje: 'Puerto 2222 no estandar detectado'),
];
