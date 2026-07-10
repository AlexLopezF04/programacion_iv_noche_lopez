import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_colors.dart';
import '../../providers/send_notification_provider.dart';
import '../../widgets/auth_button.dart';
import '../../widgets/auth_text_field.dart';

class SendNotificationScreen extends ConsumerStatefulWidget {
  const SendNotificationScreen({super.key});

  @override
  ConsumerState<SendNotificationScreen> createState() => _SendNotificationScreenState();
}

class _SendNotificationScreenState extends ConsumerState<SendNotificationScreen> {
  final _formKey      = GlobalKey<FormState>();
  final _subjectCtrl  = TextEditingController();
  final _messageCtrl  = TextEditingController();
  final _userIdCtrl   = TextEditingController();

  @override
  void dispose() {
    _subjectCtrl.dispose();
    _messageCtrl.dispose();
    _userIdCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final userId = int.tryParse(_userIdCtrl.text);
    await ref.read(sendNotificationProvider.notifier).send(
      _subjectCtrl.text,
      _messageCtrl.text,
      userId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(sendNotificationProvider);

    ref.listen<SendNotificationState>(sendNotificationProvider, (_, next) {
      if (next.isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Notificación enviada correctamente.')),
        );
        context.pop();
      } else if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:         Text(next.error!),
            backgroundColor: AppColors.error,
          ),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enviar notificación'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              Container(
                padding:    const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color:        AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                  border:       Border.all(color: AppColors.border),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      AuthTextField(
                        label:      'Asunto',
                        hint:       'título de la notificación',
                        controller: _subjectCtrl,
                        enabled:    !state.isSubmitting,
                        validator:  (v) => (v == null || v.trim().isEmpty) ? 'Campo obligatorio' : null,
                      ),
                      const SizedBox(height: 14),
                      TextFormField(
                        controller:      _messageCtrl,
                        enabled:         !state.isSubmitting,
                        maxLines:        5,
                        textInputAction: TextInputAction.newline,
                        validator:       (v) => (v == null || v.trim().isEmpty) ? 'Campo obligatorio' : null,
                        style:           const TextStyle(color: AppColors.textPrimary),
                        decoration:      const InputDecoration(
                          labelText:     'Mensaje',
                          hintText:      'contenido de la notificación',
                          alignLabelWithHint: true,
                        ),
                      ),
                      const SizedBox(height: 14),
                      AuthTextField(
                        label:       'ID de usuario (opcional)',
                        hint:        'dejar vacío para todos',
                        controller:  _userIdCtrl,
                        enabled:     !state.isSubmitting,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 24),
                      AuthButton(
                        label:     'Enviar notificación',
                        onPressed: _submit,
                        isLoading: state.isSubmitting,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
