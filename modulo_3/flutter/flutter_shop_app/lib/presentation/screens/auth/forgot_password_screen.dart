import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_colors.dart';
import '../../providers/forgot_password_provider.dart';
import '../../widgets/auth_button.dart';
import '../../widgets/auth_text_field.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey   = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    await ref.read(forgotPasswordProvider.notifier).submit(_emailCtrl.text);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(forgotPasswordProvider);
    final tt    = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              Text('Restablecer contraseña', style: tt.displayMedium?.copyWith(color: AppColors.accent)),
              const SizedBox(height: 8),
              Text('Te enviaremos un enlace a tu correo', style: tt.bodyMedium),
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
                          label:       'Email',
                          hint:        'tu@email.com',
                          controller:  _emailCtrl,
                          enabled:     !state.isSubmitting,
                          keyboardType: TextInputType.emailAddress,
                          validator:   (v) => (v == null || !v.contains('@')) ? 'Email inválido' : null,
                        ),
                        const SizedBox(height: 24),
                        AuthButton(
                          label:     'Enviar enlace',
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
                        'Correo enviado',
                        style: tt.titleLarge?.copyWith(color: AppColors.success),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Si existe una cuenta con ese email, recibirás un enlace para restablecer tu contraseña.',
                        style: tt.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      AuthButton(
                        label:     'Volver al inicio',
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
                  Text('¿Recordaste tu contraseña? ', style: tt.bodyMedium),
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
