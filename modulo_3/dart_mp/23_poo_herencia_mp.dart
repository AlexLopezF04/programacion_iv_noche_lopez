class Usuario {
  final String nombre;
  final String email;

  Usuario(this.nombre, this.email);

  String obtenerRol() => 'Usuario';

  void presentarse() {
    print('Soy $nombre ($email), rol: ${obtenerRol()}');
  }
}

class Estudiante extends Usuario {
  Estudiante(super.nombre, super.email);

  @override
  String obtenerRol() => 'Estudiante';

  void inscribirCurso(String curso) => print('$nombre se inscribió en $curso');
}

class Instructor extends Usuario {
  Instructor(super.nombre, super.email);

  @override
  String obtenerRol() => 'Instructor';

  void crearCurso(String curso) => print('$nombre creó el curso $curso');
}

void main() {
  final estudiante = Estudiante('Ana López', 'ana@email.com');
  final instructor = Instructor('Carlos García', 'carlos@email.com');

  estudiante.presentarse();
  instructor.presentarse();

  estudiante.inscribirCurso('Flutter Intermedio');
  instructor.crearCurso('Dart Avanzado');
}
