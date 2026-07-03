List<double> filtrarCursos(List<double> lista, bool Function(double) criterio) {
  return lista.where(criterio).toList();
}

bool esBarato(double p)    => p < 50;
bool esPremium(double p) => p > 150;

void main() {
  final precios = [12.99, 7.50, 200.0, 4.99, 150.0, 33.0, 88.0, 301.0];

  print(filtrarCursos(precios, esBarato));
  print(filtrarCursos(precios, esPremium));

  print(filtrarCursos(precios, (p) => p > 30 && p < 100));
}
