// === 1. CLASE BASE (Comportamiento y datos comunes) ===
class Certificado {
  final String estudianteNombre;
  final String codigoVerificacion;

  Certificado(this.estudianteNombre, this.codigoVerificacion);

  // Método que cada subclase va a especializar mediante anulación (@override)
  String obtenerTipoCredencial() => 'Credencial Genérica';

  // Método común — Reutilizado de forma idéntica por todas las subclases hijas
  void generarDocumentoOficial() {
    print('📜 Certificado [$codigoVerificacion] emitido para: $estudianteNombre | Tipo: ${obtenerTipoCredencial()}');
  }
}

// === 2. HERENCIA: Reutilizan la clase madre y la especializan ===

// Subclase A: Certificado específico para un curso individual
class CertificadoCurso extends Certificado {
  // Usamos "super.nombrePropiedad" para delegar la inicialización directo al constructor base
  CertificadoCurso(super.estudianteNombre, super.codigoVerificacion);

  @override
  String obtenerTipoCredencial() => 'Acreditación de Curso Individual ✔️';

  // Método exclusivo de esta subclase
  void compartirEnLinkedIn() => print('🔗 $estudianteNombre publicó su insignia de curso en su perfil profesional.');
}

// Subclase B: Certificado de Alta Complejidad para una Carrera Completa
class CertificadoCarrera extends Certificado {
  CertificadoCarrera(super.estudianteNombre, super.codigoVerificacion);

  @override
  String obtenerTipoCredencial() => 'Diploma de Carrera / Full-Stack Track 🎓';

  // Método exclusivo de esta subclase
  void descargarHistorialProyectos() => print('🗂️ Descargando el portafolio de proyectos aprobados ligado al código: $codigoVerificacion.');
}

void main() {
  // Instanciación de las subclases hijas pasándole datos a través del super constructor
  final certIndividual = CertificadoCurso('Alex Lopez', 'CERT-CUR-884');
  final certEspecializado = CertificadoCarrera('BaconJ Pachar', 'CERT-TRACK-001');

  // Ejecución de métodos heredados de la clase base
  certIndividual.generarDocumentoOficial(); 
  certEspecializado.generarDocumentoOficial(); 

  // Ejecución de comportamientos especializados y únicos de cada objeto
  certIndividual.compartirEnLinkedIn();
  
  // SE ELIMINÓ LA LÍNEA DEL ERROR (customAction)
  certEspecializado.descargarHistorialProyectos();
}