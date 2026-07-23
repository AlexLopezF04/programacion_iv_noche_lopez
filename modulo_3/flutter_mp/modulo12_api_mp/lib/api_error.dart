sealed class ApiError implements Exception {
  const ApiError();
  String get mensaje;
}

class SinConexion extends ApiError {
  const SinConexion();
  @override
  String get mensaje => 'Sin conexión a internet';
}

class Timeout extends ApiError {
  const Timeout();
  @override
  String get mensaje => 'Tiempo de espera agotado';
}

class ServidorError extends ApiError {
  final int codigo;
  const ServidorError(this.codigo);
  @override
  String get mensaje => 'Error del servidor ($codigo)';
}

class FormatoError extends ApiError {
  final String detalle;
  const FormatoError(this.detalle);
  @override
  String get mensaje => 'Respuesta inesperada: $detalle';
}

sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

class Failure<T> extends Result<T> {
  final ApiError error;
  const Failure(this.error);
}
