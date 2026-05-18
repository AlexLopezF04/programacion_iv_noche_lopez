void main() {
  String codigoHttp = '404';

  switch (codigoHttp) {
    case '200':
      print('OK');
    case '201':
      print('Creado');
    case '400':
      print('Petición incorrecta');
    case '401':
      print('No autorizado');
    case '404':
      print('No encontrado');
    case '500':
      print('Error del servidor');
    default:
      print('Código desconocido');
  }

  // Switch expresión — asigna el resultado a una variable
  String codigoHttp = '404';

  String descripcion = switch (codigoHttp) {
    '200' => 'OK — solicitud exitosa',
    '201' => 'Created — recurso creado',
    '204' => 'No Content — sin contenido',
    '400' => 'Bad Request — datos inválidos',
    '401' => 'Unauthorized — sin autenticación',
    '403' => 'Forbidden — sin permiso',
    '404' => 'Not Found — recurso no existe',
    '500' => 'Internal Server Error',
    '503' => 'Service Unavailable',
    _     => 'Código HTTP desconocido',  // _ es el caso por defecto
  };

  print(descripcion);  // Not Found — recurso no existe
}
