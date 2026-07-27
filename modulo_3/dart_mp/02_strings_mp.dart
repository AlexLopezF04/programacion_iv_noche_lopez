void main() {
  final curso = 'Dart Avanzado';
  final instructor = 'Ana López';

  // Interpolación con $
  print('Bienvenido a $curso');

  // Expresión con ${ }
  print('${curso.toUpperCase()} impartido por $instructor');

  // String multilinea con triple comillas
  final ficha =
      '''
Curso:    $curso
Instructor: $instructor
Duración:  ${40 ~/ 1} horas
  ''';
  print(ficha);

  // Raw string — ignora el escape
  final ruta = r'C:\Cursos\Dart\material';
  print(ruta);

  // Concatenación
  final saludo = 'Hola, ' + instructor + '!';
  print(saludo);

  // Métodos útiles de String
  print('flutter'.toUpperCase());
  print('  Flutter  '.trim());
  print('Flutter'.contains('lut'));
  print('Flutter'.replaceAll('t', 'T'));
  print('a,b,c'.split(','));
  print('Flutter'.substring(0, 4));
  print('Flutter'.startsWith('Flu'));
  print('abc'.padLeft(5, '0'));
}
