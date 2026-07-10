import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/error/api_exception.dart';
import '../../data/remote/api/auth_remote_datasource.dart';

class ForgotPasswordState {
  final bool     isSubmitting;
  final bool     isSuccess;
  final String?  error;

  const ForgotPasswordState({
    required this.isSubmitting,
    required this.isSuccess,
    this.error,
  });

  const ForgotPasswordState.initial()
      : isSubmitting = false,
        isSuccess    = false,
        error        = null;

  const ForgotPasswordState.submitting()
      : isSubmitting = true,
        isSuccess    = false,
        error        = null;

  const ForgotPasswordState.success()
      : isSubmitting = false,
        isSuccess    = true,
        error        = null;

  const ForgotPasswordState.failure(this.error)
      : isSubmitting = false,
        isSuccess    = false;
}

class ForgotPasswordNotifier extends StateNotifier<ForgotPasswordState> {
  final AuthRemoteDatasource _datasource;

  ForgotPasswordNotifier(this._datasource) : super(const ForgotPasswordState.initial());

  Future<void> submit(String email) async {
    state = const ForgotPasswordState.submitting();
    try {
      await _datasource.requestPasswordReset(email.trim());
      state = const ForgotPasswordState.success();
    } on ApiException catch (e) {
      state = ForgotPasswordState.failure(e.message);
    } catch (_) {
      state = const ForgotPasswordState.failure('Error inesperado. Intenta de nuevo.');
    }
  }
}

final forgotPasswordProvider =
    StateNotifierProvider<ForgotPasswordNotifier, ForgotPasswordState>((ref) {
  return ForgotPasswordNotifier(ref.watch(authDatasourceProvider));
});
