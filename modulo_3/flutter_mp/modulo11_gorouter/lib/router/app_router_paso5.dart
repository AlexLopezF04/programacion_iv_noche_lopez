import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';
import '../screens/scaffold_con_nav.dart';
import '../screens/pantalla_servidores.dart';
import '../screens/pantalla_detalle.dart';
import '../screens/pantalla_logs.dart';
import '../screens/pantalla_metricas.dart';
import '../screens/pantalla_ajustes.dart';
import '../screens/pantalla_login.dart';
import '../screens/pantalla_no_encontrada.dart';
import '../models/servidor_ssh.dart';

GoRouter appRouterPaso5(WidgetRef ref) => GoRouter(
  initialLocation: '/servidores',
  debugLogDiagnostics: true,
  errorBuilder: (context, state) =>
      PantallaNoEncontrada(ruta: state.matchedLocation),
  redirect: (context, state) {
    final authState     = ref.read(authProvider);
    final autenticado   = authState is Autenticado;
    final enLogin       = state.matchedLocation == '/login';
    final destino       = state.uri.queryParameters['destino'];

    if (!autenticado && !enLogin) {
      return '/login?destino=${state.matchedLocation}';
    }
    if (autenticado && enLogin) {
      return destino ?? '/servidores';
    }
    return null;
  },
  routes: [
    ShellRoute(
      builder: (context, state, child) => ScaffoldConNav(child: child),
      routes: [
        GoRoute(
          path:    '/servidores',
          builder: (_, __) => const PantallaServidores(),
          routes: [
            GoRoute(
              path:    ':id',
              builder: (context, state) => PantallaDetalle(
                id:       state.pathParameters['id']!,
                servidor: state.extra as ServidorSSH?,
              ),
              routes: [
                GoRoute(
                  path:    'logs',
                  builder: (context, state) {
                    final id = state.pathParameters['id']!;
                    return PantallaLogs(servidorId: id);
                  },
                ),
              ],
            ),
          ],
        ),
        GoRoute(path: '/metricas', builder: (_, __) => const PantallaMetricas()),
        GoRoute(path: '/ajustes',  builder: (_, __) => const PantallaAjustes()),
      ],
    ),
    GoRoute(
      path:    '/login',
      builder: (_, __) => const PantallaLogin(),
    ),
  ],
);
