import 'package:go_router/go_router.dart';
import '../screens/pantalla_inicio.dart';
import '../screens/pantalla_servidores.dart';
import '../screens/pantalla_no_encontrada.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  errorBuilder: (context, state) =>
      PantallaNoEncontrada(ruta: state.matchedLocation),
  routes: [
    GoRoute(
      path:    '/',
      name:    'inicio',
      builder: (context, state) => const PantallaInicio(),
    ),
    GoRoute(
      path:    '/servidores',
      name:    'servidores',
      builder: (context, state) => const PantallaServidores(),
    ),
  ],
);
