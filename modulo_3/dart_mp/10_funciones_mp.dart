void mostrarBienvenida() {
  print('Bienvenido a la plataforma de cursos');
}

void saludarEstudiante(String nombre) {
  print('Hola $nombre');
}

String obtenerNombreCurso() {
  return 'Dart para Principiantes';
}

double calcularPrecioFinal(double precio, double descuento) {
  return precio - (precio * descuento / 100);
}

double aplicarIva(double precio) => precio * 1.15;

void inscribirEstudiante(String nombre, [String curso = 'Sin curso']){
  print("$nombre inscrito en $curso");
}

void registrarCurso({
  required String titulo,
  required int duracion,
}){
  print("Curso: $titulo, duración: $duracion h");
}

void main() {
  mostrarBienvenida();
  saludarEstudiante('Pedro López');
  String curso = obtenerNombreCurso();
  print(curso);
  print('Precio final: \$${calcularPrecioFinal(100, 15)}');
  print('Con IVA: \$${aplicarIva(85)}');
  inscribirEstudiante('Alex', 'Flutter Intermedio');
  inscribirEstudiante('Alex');
  registrarCurso(titulo: 'Dart Avanzado', duracion: 30);
}
