import 'package:flutter/material.dart';
import 'package:flutter_lec08_stepcount_photo/screens/camera_screen.dart';
import 'package:flutter_lec08_stepcount_photo/screens/home_screen.dart';
import 'package:flutter_lec08_stepcount_photo/screens/profile_screen.dart';
import 'package:flutter_lec08_stepcount_photo/screens/splash_screen.dart';
import 'package:flutter_lec08_stepcount_photo/screens/step_counter_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        pageBuilder: (context, state) {
          return MaterialPage(child: const SplashScreen());
        },
      ),
      ShellRoute(
        builder: (context, state, child) {
          return HomeScreen(child: child);
        },
        routes: [
          GoRoute(
            path: '/home',
            name: 'home',
            pageBuilder: (context, state) {
              return const NoTransitionPage(child: HomeContent());
            },
          ),
          GoRoute(
            path: '/step-counter',
            name: 'stepCounter',
            pageBuilder: (context, state) {
              return const MaterialPage(child: StepCounterScreen());
            },
          ),
          GoRoute(
            path: '/camera',
            name: 'camera',
            pageBuilder: (context, state) {
              return const MaterialPage(child: CameraScreen());
            },
          ),
          GoRoute(
            path: '/profile',
            name: 'profile',
            pageBuilder: (context, state) {
              return const MaterialPage(child: ProfileScreen());
            },
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(child: Text('Page not found: ${state.uri}')),
      );
    },
  );
});
