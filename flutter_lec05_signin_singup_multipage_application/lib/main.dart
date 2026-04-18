import 'package:flutter/material.dart';
import 'package:lec05_signin_singup_multipage_application/models/home_model.dart';
import 'package:lec05_signin_singup_multipage_application/pages/singin_page.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => HomeModel())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const SinginPage(),
    );
  }
}
