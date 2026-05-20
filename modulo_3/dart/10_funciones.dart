// funcion sin parametros y sin retorno
void saludar() {
  print('Hola mundo');
}

// funcion con parametros y sin retorno
void saludarConParametro(String nombre) {
  print('Hola $nombre');
}

// funcion sin parametros y con retorno
int obtenerNumero() {
  return 10;
}

// funcion sin parametros y con retorno
int sumar(int a, int b) {
  return a + b;
}

//funcion flecha (arrow function)
int multiplicacar(int a, int b) => a * b;

//funcion con parametro
void saludarOpcional(String nombre, [String apellido = 'Sin apellido']){
  print("Hola $nombre $apellido");
}

// funcion con parametros nombres
void registroUsuario({
  required String nombre,
  required int edad,
}){
  print("Hola $nombre edad: $edad");
}

void main() {
  saludar();
  saludarConParametro('Pedro Lopez');
  int numero = obtenerNumero();
  print(numero);
  print('el numero es: ${obtenerNumero()}');
  print('la suma: ${sumar(5, 5)}');
  print('la multiplicacion: ${multiplicacar(5, 5)}');
  saludarOpcional('alex', 'lopez');
  saludarOpcional('alex');
  registroUsuario(nombre: 'Alex', edad: 26);
} 
