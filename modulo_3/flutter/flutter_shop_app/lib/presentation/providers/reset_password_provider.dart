import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/error/api_exception.dart';
import '../../data/remote/api/auth_remote_datasource.dart';

class ResetPasswordState {
  final bool     isSubmitting;
  final bool     isSuccess;
  final String?  error;

  const ResetPasswordState({
    required this.isSubmitting,
    required this.isSuccess,
    this.error,
  });

  const ResetPasswordState.initial()
      : isSubmitting = false,
        isSuccess    = false,
        error        = null;

  const ResetPasswordState.submitting()
      : isSubmitting = true,
        isSuccess    = false,
        error        = null;

  const ResetPasswordState.success()
      : isSubmitting = false,
        isSuccess    = true,
        error        = null;

  const ResetPasswordState.failure(this.error)
      : isSubmitting = false,
        isSuccess    = false;
}

class ResetPasswordNotifier extends StateNotifier<ResetPasswordState> {
  final AuthRemoteDatasource _datasource;

  ResetPasswordNotifier(this._datasource) : super(const ResetPasswordState.initial());

  Future<void> confirm(String uid, String token, String newPassword, String newPassword2) async {
    state = const ResetPasswordState.submitting();
    try {
      await _datasource.confirmPasswordReset(uid, token, newPassword, newPassword2);
      state = const ResetPasswordState.success();
    } on ApiException catch (e) {
      state = ResetPasswordState.failure(e.message);
    } catch (_) {
      state = const ResetPasswordState.failure('Error inesperado. Intenta de nuevo.');
    }
  }
}

final resetPasswordProvider =
    StateNotifierProvider<ResetPasswordNotifier, ResetPasswordState>((ref) {
  return ResetPasswordNotifier(ref.watch(authDatasourceProvider));
});
