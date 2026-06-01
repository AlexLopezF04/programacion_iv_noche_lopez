// Funciones secundarias que realizan cálculos específicos de precios
double calcularPrecioRegular(double base) => base;
double calcularDescuentoCyber(double base) => base * 0.70; // 30% de descuento

void main() {
  // === 1. ASIGNAR FUNCIONES A VARIABLES ===
  // La variable 'estrategiaPrecio' almacena una función que recibe un double y retorna un double.
  // Tipo: double Function(double)
  double Function(double) estrategiaPrecio;

  // Aplicamos la estrategia normal
  estrategiaPrecio = calcularPrecioRegular;
  print('Precio al público normal: \$${estrategiaPrecio(100.0)}'); // 100.0

  // Cambiamos dinámicamente la estrategia de precios para un evento comercial
  estrategiaPrecio = calcularDescuentoCyber;
  print('Precio con oferta Cyber: \$${estrategiaPrecio(100.0)}'); // 70.0


  // === 2. COLECCIONES DE FUNCIONES (Lista de transformaciones) ===
  // Útil si queremos aplicar una serie de filtros o cálculos consecutivos al carrito de un estudiante.
  final flujoDeCajaSimulado = <double Function(double)>[
    calcularPrecioRegular, 
    calcularDescuentoCyber
  ];

  print('\n--- Simulando transacciones con una base de \$50.0 ---');
  for (final aplicarTarifa in flujoDeCajaSimulado) {
    print('Resultado del procesamiento: \$${aplicarTarifa(50.0)}'); 
    // Imprime 50.0 (Precio base) y luego 35.0 (Precio con el 30% de descuento aplicado)
  }
}