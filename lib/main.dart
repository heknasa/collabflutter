import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/todo_screen.dart';
import 'screens/login_screen.dart';
import 'services/todo_repo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ProviderScope(
      child: MaterialApp(
        initialRoute: '/main',
        routes: {
          // '/' : (context) => const LoginScreen(),
          '/main': (context) => TodoScreen()
        }
      ),
    )
  );
}