import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/todo_screen.dart';
import 'screens/home_screen/login_page.dart';
import 'services/todo_repo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'screens/home_screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ProviderScope(
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/' : (context) => HomeScreen(),
          '/todo' : (context) => TodoScreen()
        }
      ),
    )
  );
}