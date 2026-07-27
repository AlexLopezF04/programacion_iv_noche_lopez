import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'api_error.dart';

class HttpClient {
  static const String _baseUrl = 'https://api.escuelajs.co/api/v1';
  static const Duration _timeout = Duration(seconds: 10);

  Future<dynamic> get(String path) async {
    final uri = Uri.parse('$_baseUrl$path');
    try {
      final res = await http.get(uri).timeout(_timeout);
      if (res.statusCode != 200) throw ServidorError(res.statusCode);
      return jsonDecode(res.body);
    } on SocketException {
      throw const SinConexion();
    } on ApiError {
      rethrow;
    } on Exception catch (e) {
      throw FormatoError(e.toString());
    }
  }
}
