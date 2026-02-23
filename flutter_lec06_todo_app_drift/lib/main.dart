import 'package:flutter/material.dart';
import 'package:flutter_lec06_todo_app_drift/pages/home_page.dart';
import 'package:flutter_lec06_todo_app_drift/services/database_service.dart';

late DatabaseService databaseService;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  databaseService = DatabaseService();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo App Drift',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const HomePage(),
    );
  }
}
