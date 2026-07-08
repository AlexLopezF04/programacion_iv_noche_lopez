import '../model/auth_models.dart';

abstract class AuthRepository {
  Future<({AuthTokens tokens, LoggedUser user})> login(
      String username, String password);
  Future<({AuthTokens tokens, LoggedUser user})> register({
    required String username,
    required String email,
    required String password1,
    required String password2,
  });
  Future<void> logout();
  Future<bool> isLoggedIn();
  Future<Map<String, String>?> getUser();
  Future<void> clearSession();
}
