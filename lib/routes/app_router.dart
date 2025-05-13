// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// import '../views/splash_screen.dart';
// import '../views/login_page.dart';
// import '../views/register_page.dart';
// import '../views/home_page.dart';
// // import '../views/add_note_page.dart';
//
// final GoRouter appRouter = GoRouter(
//   initialLocation: '/',
//   // redirect: (context, state) {
//   //   final isLoggedIn = FirebaseAuth.instance.currentUser != null;
//   //   if (state.fullPath == '/login' || state.fullPath == '/register') {
//   //     return null;
//   //   }
//   //   if (!isLoggedIn && state.fullPath != '/') return '/login';
//   //   return null;
//   // },
//   routes: [
//     GoRoute(
//       path: '/',
//       builder: (context, state) => const SplashScreen(),
//     ),
//     GoRoute(
//       path: '/login',
//       builder: (context, state) => LoginPage(),
//     ),
//     GoRoute(
//       path: '/register',
//       builder: (context, state) => RegisterPage(),
//     ),
//     GoRoute(
//       path: '/home',
//       builder: (context, state) => HomePage(),
//     )
//     // GoRoute(
//     //   path: '/add-note',
//     //   builder: (context, state) => AddNotePage(),
//     // ),
//   ],
// );
