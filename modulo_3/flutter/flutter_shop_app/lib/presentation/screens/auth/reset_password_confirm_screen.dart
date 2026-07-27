import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_colors.dart';
import '../../providers/reset_password_provider.dart';
import '../../widgets/auth_button.dart';
import '../../widgets/auth_text_field.dart';

class ResetPasswordConfirmScreen extends ConsumerStatefulWidget {
  final String uid;
  final String token;

  const ResetPasswordConfirmScreen({
    super.key,
    required this.uid,
    required this.token,
  });

  @override
  ConsumerState<ResetPasswordConfirmScreen> createState() => _ResetPasswordConfirmScreenState();
}

class _ResetPasswordConfirmScreenState extends ConsumerState<ResetPasswordConfirmScreen> {
  final _formKey    = GlobalKey<FormState>();
  final _passCtrl   = TextEditingController();
  final _pass2Ctrl  = TextEditingController();
  bool  _submitted  = false;

  @override
  void dispose() {
    _passCtrl.dispose();
    _pass2Ctrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _submitted = true);
    if (!_formKey.currentState!.validate()) return;
    await ref.read(resetPasswordProvider.notifier).confirm(
      widget.uid,
      widget.token,
      _passCtrl.text,
      _pass2Ctrl.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(resetPasswordProvider);
    final tt    = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              Text('Nueva contraseña', style: tt.displayMedium?.copyWith(color: AppColors.accent)),
              const SizedBox(height: 8),
              Text('Ingresa tu nueva contraseña', style: tt.bodyMedium),
              const SizedBox(height: 48),

              if (!state.isSuccess)
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
                        if (state.error != null) ...[
                          Container(
                            width:   double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color:        AppColors.error.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(10),
                              border:       Border.all(color: AppColors.error.withValues(alpha: 0.3)),
                            ),
                            child: Text(
                              state.error!,
                              style: const TextStyle(color: AppColors.error, fontSize: 13),
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                        AuthTextField(
                          label:      'Nueva contraseña',
                          hint:       'mínimo 8 caracteres',
                          controller: _passCtrl,
                          isPassword: true,
                          enabled:    !state.isSubmitting,
                          validator:  _submitted
                              ? (v) => (v == null || v.length < 8) ? 'Mínimo 8 caracteres' : null
                              : null,
                        ),
                        const SizedBox(height: 14),
                        AuthTextField(
                          label:           'Confirmar contraseña',
                          hint:            'repite la contraseña',
                          controller:      _pass2Ctrl,
                          isPassword:      true,
                          enabled:         !state.isSubmitting,
                          textInputAction: TextInputAction.done,
                          validator:       _submitted
                              ? (v) {
                                  if (v != _passCtrl.text) return 'Las contraseñas no coinciden';
                                  return null;
                                }
                              : null,
                        ),
                        const SizedBox(height: 24),
                        AuthButton(
                          label:     'Restablecer contraseña',
                          onPressed: _submit,
                          isLoading: state.isSubmitting,
                        ),
                      ],
                    ),
                  ),
                )
              else
                Container(
                  width:   double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color:        AppColors.surface,
                    borderRadius: BorderRadius.circular(20),
                    border:       Border.all(color: AppColors.success.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.check_circle_outline, color: AppColors.success, size: 56),
                      const SizedBox(height: 16),
                      Text(
                        'Contraseña restablecida',
                        style: tt.titleLarge?.copyWith(color: AppColors.success),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tu contraseña se ha actualizado correctamente. Ahora puedes iniciar sesión.',
                        style: tt.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      AuthButton(
                        label:     'Iniciar sesión',
                        onPressed: () => context.go('/login'),
                        isLoading: false,
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('¿Ya la recordaste? ', style: tt.bodyMedium),
                  TextButton(
                    onPressed: () => context.go('/login'),
                    child: const Text('Inicia sesión'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
