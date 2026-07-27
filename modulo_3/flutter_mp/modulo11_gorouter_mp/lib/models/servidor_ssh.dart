class ServidorSSH {
  final String id;
  final String nombre;
  final String ip; // Instructor
  final int    puerto; // Clases
  final bool   ssl; // Publicado

  const ServidorSSH({
    required this.id,
    required this.nombre,
    required this.ip,
    required this.puerto,
    required this.ssl,
  });
}

// Lista simulada — en una app real vendría de un provider
const servidoresSimulados = [
  ServidorSSH(id: '1', nombre: 'Desarrollo Flutter & Dart', ip: 'Alex López',   puerto: 45,   ssl: true),
  ServidorSSH(id: '2', nombre: 'Bases de Datos SQL',  ip: 'Ing. Gómez',   puerto: 20,   ssl: true),
  ServidorSSH(id: '3', nombre: 'Backend Node.js & Express', ip: 'Lic. Ruiz',   puerto: 35,   ssl: false),
];