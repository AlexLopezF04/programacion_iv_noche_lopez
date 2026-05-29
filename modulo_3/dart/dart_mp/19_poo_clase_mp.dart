class Curso {
  // === 1. PROPIEDADES ===
  final String id;
  final String titulo;
  double       precio;
  bool         _publicado = false;  // El guion bajo (_) lo vuelve privado para uso interno del archivo

  // === 2. CONSTRUCTOR CON PARÁMETROS NOMBRADOS ===
  Curso({
    required this.id,
    required this.titulo,
    required this.precio,
  });

  // === 3. GETTERS (Propiedades derivadas de solo lectura) ===
  bool   get publicado => _publicado;
  String get estado    => _publicado ? 'disponible' : 'en borrador';

  // === 4. SETTER (Escritura y validación controlada) ===
  set cambiarEstadoPublicacion(bool valor) {
    _publicado = valor;
    print('Cambio de estado en "$titulo": ${valor ? "Publicado oficialmente" : "Movido a borrador"}');
  }

  // === 5. MÉTODOS DE INSTANCIA ===
  void lanzarCurso() {
    _publicado = true;
    print('🚀 El curso "$titulo" ya está en línea al precio de \$$precio USD.');
  }

  void deshabilitarCurso() {
    _publicado = false;
    print('⚠️ El curso "$titulo" ha sido retirado temporalmente de la tienda.');
  }

  String resumen() => 'ID: $id | Curso: $titulo | Costo: \$$precio | Estado: $estado';

  // === 6. TOSTRING OVERRIDE (Personaliza la impresión del objeto en consola) ===
  @override
  String toString() => 'Curso($titulo, \$$precio, $estado)';
}

void main() {
  // Crear una instancia de la clase Curso
  final cursoBackend = Curso(
    id:     'CUR-044',
    titulo: 'Desarrollo Backend con NestJS y PostgreSQL',
    precio: 49.99,
  );

  // Usar los métodos y propiedades de la instancia
  cursoBackend.lanzarCurso();
  print(cursoBackend.estado);       // disponible
  print(cursoBackend.resumen());
  print(cursoBackend);              // Llama al método toString() modificado automáticamente

  // Modificar el estado usando el Setter expuesto
  cursoBackend.cambiarEstadoPublicacion = false; // Usa el setter
  print(cursoBackend.publicado);   // false
}