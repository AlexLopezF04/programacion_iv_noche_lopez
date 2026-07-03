String generarUrlCurso(String plataforma, String curso, [int? leccion]) {
  if (leccion != null) {
    return 'https://$plataforma/curso/$curso/leccion/$leccion';
  }
  return 'https://$plataforma/curso/$curso';
}

String generarUrlCursoV2(String plataforma, String curso, [int leccion = 1]) {
  return 'https://$plataforma/curso/$curso/leccion/$leccion';
}

void configurarCurso({
  required String titulo,
  required double precio,
  bool   certificado    = true,
  int    cupoMaximo     = 100,
}) {
  final cert = certificado ? 'con certificado' : 'sin certificado';
  print('$titulo — \$$precio, $cert, cupo: $cupoMaximo');
}

void main() {
  print(generarUrlCurso('udemy.com', 'dart-desde-cero'));
  print(generarUrlCurso('udemy.com', 'dart-desde-cero', 5));
  print(generarUrlCursoV2('udemy.com', 'flutter-apps'));

  configurarCurso(
    titulo:      'Dart Completo',
    precio:      49.99,
    certificado: true,
    cupoMaximo:  50,
  );

  configurarCurso(
    titulo: 'Dart Express',
    precio: 19.99,
  );
}
