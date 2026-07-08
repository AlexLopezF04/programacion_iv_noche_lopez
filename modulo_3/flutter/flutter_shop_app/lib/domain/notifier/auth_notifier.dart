import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/auth_models.dart';
import '../model/auth_state.dart';
import '../repository/auth_repository_impl.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepositoryImpl _repository;

  AuthNotifier(this._repository) : super(const AuthState());

  Future<void> checkSession() async {
    state = const AuthState(status: AuthStatus.loading);
    final loggedIn = await _repository.isLoggedIn();
    if (!loggedIn) {
      state = const AuthState(status: AuthStatus.unauthenticated);
      return;
    }
    final userData = await _repository.getUser();
    if (userData == null) {
      state = const AuthState(status: AuthStatus.unauthenticated);
      return;
    }
    state = AuthState(
      status: AuthStatus.authenticated,
      user: LoggedUser(
        id: int.parse(userData['id']!),
        username: userData['username']!,
        email: userData['email']!,
        isStaff: userData['is_staff'] == 'true',
      ),
    );
  }

  Future<void> login(String username, String password) async {
    state = const AuthState(status: AuthStatus.loading);
    try {
      final result = await _repository.login(username, password);
      state = AuthState(
        status: AuthStatus.authenticated,
        user: result.user,
      );
    } catch (e) {
      state = AuthState(
        status: AuthStatus.error,
        error: e.toString(),
      );
    }
  }

  Future<void> register({
    required String username,
    required String email,
    required String password1,
    required String password2,
  }) async {
    state = const AuthState(status: AuthStatus.loading);
    try {
      final result = await _repository.register(
        username: username,
        email: email,
        password1: password1,
        password2: password2,
      );
      state = AuthState(
        status: AuthStatus.authenticated,
        user: result.user,
      );
    } catch (e) {
      state = AuthState(
        status: AuthStatus.error,
        error: e.toString(),
      );
    }
  }

  Future<void> logout() async {
    await _repository.logout();
    state = const AuthState(status: AuthStatus.unauthenticated);
  }

  void clearError() {
    if (state.status == AuthStatus.error) {
      state = state.copyWith(status: AuthStatus.unauthenticated, error: null);
    }
  }
}

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider) as AuthRepositoryImpl;
  return AuthNotifier(repository);
});
