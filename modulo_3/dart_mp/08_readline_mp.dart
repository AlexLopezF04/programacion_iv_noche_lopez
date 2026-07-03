import 'dart:io';

void main() {
    print('Ingrese su nombre de estudiante:');
    String? nombre = stdin.readLineSync();
    print('Hola $nombre');

    print('Ingrese la calificación del curso:');
    int nota = int.parse(stdin.readLineSync()!);
    print('Nota: $nota');

    print('Ingrese el precio del curso:');
    double precio = double.parse(stdin.readLineSync()!);
    print('Precio: \$$precio');
}
