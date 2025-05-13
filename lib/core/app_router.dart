import 'package:caretutors/core/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../presentation/controllers/auth_controller.dart';
import '../presentation/views/auth/login_screen.dart';
import '../presentation/views/auth/register.dart';
import '../presentation/views/notes/add_note_screen.dart';
import '../presentation/views/notes/home.dart';
// import '../presentation/views/notes/add_note_screen.dart';
import '../presentation/views/splash/splash.dart';

class AppRouter {
  late final GoRouter router;

  AppRouter() {
    final prefs = Get.find<SharedPreferences>();
    final authNotifier = Get.find<AuthNotifier>();
    router = GoRouter(
      initialLocation: '/splash',
      refreshListenable: authNotifier,
      routes: [
        GoRoute(
          path: '/splash',
          builder: (context, state) => SplashScreen(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) => RegisterPage(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => HomePage(),
        ),
        GoRoute(
          path: '/add-note',
          builder: (context, state) => AddNoteScreen(),
        ),
      ],
      redirect: (BuildContext context, GoRouterState state) {
        final isFirstLaunch = prefs.getBool('first_launch') ?? true;
        final isLoggedIn = Get.find<AuthController>().user != null;
        final isAuthRoute = state.uri.toString() == '/login' ||
            state.uri.toString() == '/register';

        if (isFirstLaunch) return '/splash';
        if (!isLoggedIn && !isAuthRoute) return '/login';
        if (isLoggedIn && isAuthRoute) return '/home';
        return null;
      },
    );
  }
}
