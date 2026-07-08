import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/notifier/auth_notifier.dart';

import '../../theme/app_colors.dart';
import '../../core/config/app_config.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authNotifierProvider);
    final tt = Theme.of(context).textTheme;
    final user = state.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConfig.appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
            onPressed: () => ref.read(authNotifierProvider.notifier).logout(),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: AppColors.accent,
            child: Text(
                  (user?.username.isNotEmpty == true)
                      ? user!.username[0].toUpperCase()
                      : '?',
                  style: tt.headlineLarge
                      ?.copyWith(color: AppColors.onAccent),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Bienvenido, ${user?.username ?? ''}',
                style: tt.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                user?.email ?? '',
                style: tt.bodyMedium?.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 4),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: user?.isStaff == true
                      ? AppColors.accent.withValues(alpha: 0.15)
                      : AppColors.surface2,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  user?.isStaff == true ? 'Staff' : 'Cliente',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: user?.isStaff == true
                        ? AppColors.accent
                        : AppColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton.icon(
                  onPressed: () => ref
                      .read(authNotifierProvider.notifier)
                      .logout(),
                  icon: const Icon(Icons.logout),
                  label: const Text('Cerrar sesión'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
