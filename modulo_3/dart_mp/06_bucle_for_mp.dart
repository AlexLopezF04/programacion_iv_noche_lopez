void main() {
  for (int i = 0; i < 5; i++) {
    print('Módulo ${i + 1}');
  }

  for (int i = 0; i <= 100; i += 25) {
    print('Progreso del curso: $i%');
  }

  for (int i = 5; i >= 1; i--) {
    print('Lecciones restantes: $i');
  }

  final modulos = ['Introducción', 'Variables', 'Funciones', 'POO', 'Async'];

  for (final modulo in modulos) {
    print(modulo);
  }

  modulos.forEach((m) => print(m.toLowerCase()));

  final duraciones = {'Introducción': 120, 'Variables': 90, 'Funciones': 150};
  for (final entrada in duraciones.entries) {
    print('${entrada.key} → ${entrada.value} min');
  }
}
