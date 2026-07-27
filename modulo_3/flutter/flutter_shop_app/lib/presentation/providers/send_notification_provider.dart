import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/error/api_exception.dart';
import '../../data/remote/api/user_remote_datasource.dart';

class SendNotificationState {
  final bool     isSubmitting;
  final bool     isSuccess;
  final String?  error;

  const SendNotificationState({
    required this.isSubmitting,
    required this.isSuccess,
    this.error,
  });

  const SendNotificationState.initial()
      : isSubmitting = false,
        isSuccess    = false,
        error        = null;

  const SendNotificationState.submitting()
      : isSubmitting = true,
        isSuccess    = false,
        error        = null;

  const SendNotificationState.success()
      : isSubmitting = false,
        isSuccess    = true,
        error        = null;

  const SendNotificationState.failure(this.error)
      : isSubmitting = false,
        isSuccess    = false;
}

class SendNotificationNotifier extends StateNotifier<SendNotificationState> {
  final UserRemoteDatasource _datasource;

  SendNotificationNotifier(this._datasource) : super(const SendNotificationState.initial());

  Future<void> send(String subject, String message, int? userId) async {
    state = const SendNotificationState.submitting();
    try {
      await _datasource.sendNotification(subject.trim(), message.trim(), userId);
      state = const SendNotificationState.success();
    } on ApiException catch (e) {
      state = SendNotificationState.failure(e.message);
    } catch (_) {
      state = const SendNotificationState.failure('Error inesperado. Intenta de nuevo.');
    }
  }
}

final sendNotificationProvider =
    StateNotifierProvider<SendNotificationNotifier, SendNotificationState>((ref) {
  return SendNotificationNotifier(ref.watch(userDatasourceProvider));
});
