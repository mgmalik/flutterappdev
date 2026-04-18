import 'package:flutter/material.dart';
import 'package:flutter_lec08_navigation_router/pages/home_page.dart';
import 'package:flutter_lec08_navigation_router/pages/products_page.dart';
import 'package:flutter_lec08_navigation_router/pages/profile_page.dart';
import 'package:flutter_lec08_navigation_router/pages/settings_page.dart';
import 'package:flutter_lec08_navigation_router/routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Demo',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      // Initial route
      initialRoute: AppRoutes.home,
      // Define named routes
      routes: {
        AppRoutes.home: (context) => const HomePage(),
        AppRoutes.products: (context) => const ProductsPage(),
        AppRoutes.profile: (context) => const ProfilePage(),
        AppRoutes.settings: (context) => const SettingsPage(),
      },
      // Handle unknown routes
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case AppRoutes.home:
            return MaterialPageRoute(builder: (context) => const HomePage());
          case AppRoutes.products:
            return MaterialPageRoute(
              builder: (context) => const ProductsPage(),
            );
          case AppRoutes.profile:
            return MaterialPageRoute(builder: (context) => const ProfilePage());
          case AppRoutes.settings:
            return MaterialPageRoute(
              builder: (context) => const SettingsPage(),
            );
          default:
            return MaterialPageRoute(
              builder: (context) =>
                  const Scaffold(body: Center(child: Text('Page not found!'))),
            );
        }
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
