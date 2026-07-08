import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/local/secure_storage.dart';
import '../../data/remote/api/auth_remote_datasource.dart';
import '../model/auth_models.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource _datasource;
  final SecureStorage _storage;

  AuthRepositoryImpl(this._datasource, this._storage);

  @override
  Future<({AuthTokens tokens, LoggedUser user})> login(
      String username, String password) async {
    final result = await _datasource.login(username, password);
    await _storage.saveTokens(result.tokens.access, result.tokens.refresh);
    await _storage.saveUser(
      id: result.user.id,
      username: result.user.username,
      email: result.user.email,
      isStaff: result.user.isStaff,
    );
    return result;
  }

  @override
  Future<({AuthTokens tokens, LoggedUser user})> register({
    required String username,
    required String email,
    required String password1,
    required String password2,
  }) async {
    final result = await _datasource.register(
      username: username,
      email: email,
      password1: password1,
      password2: password2,
    );
    await _storage.saveTokens(result.tokens.access, result.tokens.refresh);
    await _storage.saveUser(
      id: result.user.id,
      username: result.user.username,
      email: result.user.email,
      isStaff: result.user.isStaff,
    );
    return result;
  }

  @override
  Future<void> logout() async {
    try {
      await _datasource.logout();
    } catch (_) {}
    await _storage.clearSession();
  }

  @override
  Future<void> clearSession() => _storage.clearSession();

  @override
  Future<bool> isLoggedIn() => _storage.isLoggedIn();

  @override
  Future<Map<String, String>?> getUser() => _storage.getUser();
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final datasource = ref.watch(authDatasourceProvider);
  final storage = ref.watch(secureStorageProvider);
  return AuthRepositoryImpl(datasource, storage);
});
