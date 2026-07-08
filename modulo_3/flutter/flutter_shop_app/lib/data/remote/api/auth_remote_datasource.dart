import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/api_exception.dart';
import '../../../domain/model/auth_models.dart';
import 'dio_client.dart';

abstract class AuthRemoteDatasource {
  Future<({AuthTokens tokens, LoggedUser user})> login(
      String username, String password);
  Future<({AuthTokens tokens, LoggedUser user})> register({
    required String username,
    required String email,
    required String password1,
    required String password2,
  });
  Future<AuthTokens> refresh(String refreshToken);
  Future<void> logout();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final Dio _dio;

  AuthRemoteDatasourceImpl(this._dio);

  @override
  Future<({AuthTokens tokens, LoggedUser user})> login(
      String username, String password) async {
    try {
      final res = await _dio.post('/auth/token/', data: {
        'username': username,
        'password': password,
      });
      final data = res.data as Map<String, dynamic>;
      final tokens = AuthTokens(
        access: data['access'] as String,
        refresh: data['refresh'] as String,
      );
      final user = LoggedUser.fromMap(data);
      return (tokens: tokens, user: user);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<({AuthTokens tokens, LoggedUser user})> register({
    required String username,
    required String email,
    required String password1,
    required String password2,
  }) async {
    try {
      final res = await _dio.post('/auth/registration/', data: {
        'username': username,
        'email': email,
        'password1': password1,
        'password2': password2,
      });
      final data = res.data as Map<String, dynamic>;
      final tokens = AuthTokens(
        access: data['access'] as String,
        refresh: data['refresh'] as String,
      );
      final user = LoggedUser.fromMap(data);
      return (tokens: tokens, user: user);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<AuthTokens> refresh(String refreshToken) async {
    try {
      final res = await _dio.post('/auth/token/refresh/', data: {
        'refresh': refreshToken,
      });
      final data = res.data as Map<String, dynamic>;
      return AuthTokens(
        access: data['access'] as String,
        refresh: (data['refresh'] ?? refreshToken) as String,
      );
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _dio.post('/auth/logout/');
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}

final authDatasourceProvider = Provider<AuthRemoteDatasource>((ref) {
  return AuthRemoteDatasourceImpl(ref.watch(dioProvider));
});
