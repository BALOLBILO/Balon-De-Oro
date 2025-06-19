import 'package:flutter_application_tp/entities/BalonOro.dart';
import 'package:flutter_application_tp/entities/usuarios.dart';
import 'package:flutter_application_tp/presentation/screens/Agregar_screen.dart';
import 'package:flutter_application_tp/presentation/screens/Editar_screen.dart';
import 'package:flutter_application_tp/presentation/screens/Inicio_screen.dart';
import 'package:flutter_application_tp/presentation/screens/home_screen.dart';
import 'package:flutter_application_tp/presentation/screens/login_screen.dart';
import 'package:flutter_application_tp/presentation/screens/registrarse_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/inicio',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) {
        final usuarios = state.extra as List<Usuario>;
        return LoginScreen(listaUsuarios: usuarios);
      },
    ),
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    GoRoute(path: '/inicio', builder: (context, state) => const InicioScreen()),
    GoRoute(
      path: '/registrarse',
      builder: (context, state) {
        final usuarios = state.extra as List<Usuario>;
        return RegistrarseScreen(listaUsuarios: usuarios);
      },
    ),
    GoRoute(
      path: '/agregar',
      builder: (context, state) => const AgregarScreen(),
    ),
    GoRoute(
      path: '/editar',
      builder: (context, state) {
        final jugador = state.extra as BalonOro;
        return EditarScreen(jugadorEditar: jugador);
      },
    ),
  ],
);
