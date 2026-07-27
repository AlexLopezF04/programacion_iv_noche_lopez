int factorial(int n) {
  if (n <= 1) return 1;
  return n * factorial(n - 1);
}

int fibonacci(int n) {
  if (n <= 1) return n;
  return fibonacci(n - 1) + fibonacci(n - 2);
}

int contarLecciones(Map<String, dynamic> modulo) {
  int total = 0;
  for (final entrada in modulo.entries) {
    if (entrada.value is Map) {
      total += contarLecciones(entrada.value as Map<String, dynamic>);
    } else {
      total++;
    }
  }
  return total;
}

void main() {
  print(factorial(6));
  print(fibonacci(10));

  final estructuraCurso = {
    'Modulo 1': {
      'Leccion 1.1': true,
      'Leccion 1.2': true,
      'Submodulo': {
        'Leccion 1.3.1': true,
        'Leccion 1.3.2': true,
      },
    },
    'Modulo 2': {'Leccion 2.1': true, 'Leccion 2.2': true, 'Leccion 2.3': true},
    'Modulo 3': {'Leccion 3.1': true, 'Leccion 3.2': true},
    'README.md': true,
  };

  print('Total de lecciones: ${contarLecciones(estructuraCurso)}');
}
