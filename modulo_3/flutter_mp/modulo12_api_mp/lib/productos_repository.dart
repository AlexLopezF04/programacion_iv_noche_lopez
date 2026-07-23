import 'http_client.dart';
import 'producto.dart';
import 'producto_dto.dart';

class ProductosRepository {
  final HttpClient _client;
  const ProductosRepository(this._client);

  Future<List<Producto>> listar({int limit = 20, int offset = 0}) async {
    final data = await _client.get('/products?limit=$limit&offset=$offset');
    return (data as List)
        .map((e) => ProductoDto.fromJson(e as Map<String, dynamic>).toDomain())
        .toList();
  }

  Future<List<Producto>> buscar(String termino) async {
    final data = await _client.get('/products/?title=$termino');
    return (data as List)
        .map((e) => ProductoDto.fromJson(e as Map<String, dynamic>).toDomain())
        .toList();
  }
}
