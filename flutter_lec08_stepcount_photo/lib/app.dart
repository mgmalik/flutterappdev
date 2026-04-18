import 'package:flutter/material.dart';
import 'package:flutter_lec08_stepcount_photo/routes/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StepCounterApp extends ConsumerWidget {
  const StepCounterApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Step Counter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
