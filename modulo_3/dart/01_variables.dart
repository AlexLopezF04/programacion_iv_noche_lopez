void main() {
  // === 1. VARIABLES BÁSICAS Y TIPOS ===
  // var — tipo inferido (como val en Kotlin)
  var nombre = 'Ana';           // String
  var edad   = 28;              // int
  var precio = 89.99;           // double
  var activo = true;            // bool

  // Tipo explícito
  String apellido = 'García'; 
  int    stock    = 100;
  double pi       = 3.14159;
  bool   visible  = false;

  print('$nombre $apellido tiene $edad años. Stock: $stock, Activo: $activo');


  // === 2. FINAL VS CONST ===
  // final — no se puede reasignar
  final ciudad = 'Madrid';
  // ciudad = 'Barcelona';  // ERROR — final no se puede reasignar

  // const — constante en tiempo de compilación
  const gravedad = 9.8;
  const pi2      = 3.14159;

  // Diferencia clave: final vs const
  final ahora  = DateTime.now();   // OK — se evalúa en runtime
  // const ahora = DateTime.now(); // ERROR 

  print('Gravedad: $gravedad, Pi2: $pi2, Hora actual: $ahora');


  // === 3. MUTABILIDAD ===
  // var — mutable, tipo inferido
  var contador = 0;
  contador = 1;          // OK — Ahora está dentro de main

  // final — inmutable referencia, evaluado en runtime
  final lista = [1, 2, 3];
  lista.add(4);          // OK — la referencia es final, no el contenido
  // lista = [5, 6];     // ERROR 

  // const — inmutable profundo, evaluado en compilación
  const colores = ['rojo', 'azul'];
  // colores.add('verde'); // ERROR en runtime — lista const es completamente inmutable


  // === 4. NULL SAFETY ===
  // Tipo no-nullable — NUNCA puede ser null (Ya no duplicamos 'nombre', usamos 'nombre2')
  String nombre2 = 'Carlos';
  // nombre2 = null;       // ERROR de compilación

  // Tipo nullable — puede ser null (añadir ?) (Modificamos el 'apellido' existente)
  String? apellidoNullable = null;   // OK
  apellidoNullable = 'Gómez';        // OK

  // Operadores de null safety
  String? otraCiudad; // Por defecto es null

  // ?. — safe call
  print(otraCiudad?.length);      // null — no lanza excepción

  // ?? — operador Elvis
  String resultado = otraCiudad ?? 'Sin ciudad';
  print(resultado);           // Sin ciudad

  // Null check con if
  if (apellidoNullable != null) {
    print(apellidoNullable.length);   // smart cast — seguro aquí
  }


  // === 5. LATE (Inicialización diferida) ===
  late String token;
  token = 'abc123';           // se asigna antes de usar
  print(token);

  // NOTA: Dejo el test de '!' al final porque va a lanzar una excepción a propósito si 'otraCiudad' es null
  // String ciudadSegura = otraCiudad!; 
}