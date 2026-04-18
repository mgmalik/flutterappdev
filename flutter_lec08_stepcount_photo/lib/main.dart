import 'package:flutter/material.dart';
import 'package:flutter_lec08_stepcount_photo/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ProviderScope(child: const StepCounterApp()));
}
