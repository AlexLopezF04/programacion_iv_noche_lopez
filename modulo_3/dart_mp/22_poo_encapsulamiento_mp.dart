class Inscripcion {
  final String estudiante;
  final String curso;
  double _progreso;

  Inscripcion(this.estudiante, this.curso, double progresoInicial)
      : _progreso = progresoInicial;

  double get progreso => _progreso;

  void avanzar(double porcentaje) {
    if (porcentaje <= 0) throw ArgumentError('El avance debe ser positivo');
    if (_progreso + porcentaje > 100) {
      _progreso = 100;
      print('$estudiante completó el curso "$curso"');
    } else {
      _progreso += porcentaje;
      print('$estudiante avanza ${porcentaje}%. Progreso: ${_progreso.toStringAsFixed(1)}%');
    }
  }

  void reiniciar() {
    _progreso = 0;
    print('$estudiante reinició "$curso"');
  }
}

void main() {
  final insc = Inscripcion('Ana López', 'Dart desde Cero', 0.0);

  insc.avanzar(25.0);
  insc.avanzar(40.0);
  print(insc.progreso);
}
