import 'package:go_router/go_router.dart';
import '../screens/pantalla_inicio.dart';
import '../screens/pantalla_servidores.dart';
import '../screens/pantalla_detalle.dart';
import '../screens/pantalla_logs.dart';
import '../screens/pantalla_no_encontrada.dart';
import '../models/servidor_ssh.dart';

final appRouterPaso2 = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  errorBuilder: (context, state) =>
      PantallaNoEncontrada(ruta: state.matchedLocation),
  routes: [
    GoRoute(
      path:    '/',
      builder: (context, state) => const PantallaInicio(),
    ),
    GoRoute(
      path:    '/servidores',
      builder: (context, state) => const PantallaServidores(),
      routes: [
        GoRoute(
          path:    ':id',
          builder: (context, state) {
            final id       = state.pathParameters['id']!;
            final servidor = state.extra as ServidorSSH?;
            return PantallaDetalle(id: id, servidor: servidor);
          },
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
  ],
);
