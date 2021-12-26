import 'package:collabflutter/providers/gsheets_provider.dart';
import 'package:collabflutter/screens/internship_screen.dart';
import 'package:collabflutter/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/game_screen.dart';
import 'screens/todo_screen.dart';
import 'screens/login_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'screens/home_screen.dart';
import 'providers/global_providers.dart';
import 'providers/theme_provider.dart';
import 'package:get/get.dart';
import 'screens/planner_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initGlobalProviders();
  runApp(
    ProviderScope(
      child: Consumer(
        builder: (context, ref, child) {
          return GetMaterialApp(
            // delete debug
            debugShowCheckedModeBanner: false,
            themeMode: ref.watch(themeMode),
            theme: ref.watch(theme),
            darkTheme: ref.watch(darkTheme),
            initialRoute: '/internship',
            getPages: [
              GetPage(name: '/', page: () => const SplashScreen()),
              GetPage(name: '/login', page: () => const LoginScreen(), middlewares: [_Authorized()]),
              GetPage(name: '/home', page: () => const HomeScreen(), middlewares: [_Unauthorized()]),
              GetPage(name: '/internship', page: () => const InternshipScreen()),
              // GetPage(name: '/todo', page: () => const TodoScreen(), middlewares: [_Unauthorized()]),
              // GetPage(name: '/planner', page: () => const PlannerScreen(), middlewares: [_Unauthorized()]),
              // GetPage(name: '/game', page: () => const GameScreen(), middlewares: [_Unauthorized()]),
            ],
          );
        }
      ),
    )
  );
}

class _Unauthorized extends GetMiddleware {
  final FirebaseAuth? userExistence = FirebaseAuth.instance;

  @override
  RouteSettings? redirect(String? route) {
    String returnURL = Uri.encodeFull(route ?? '');
    return userExistence?.currentUser == null
        ? RouteSettings(name: '/?return=' + returnURL)
        : null;
  }
}

class _Authorized extends GetMiddleware {
  final FirebaseAuth? userExistence = FirebaseAuth.instance;

  @override
  RouteSettings? redirect(String? route) {
    return userExistence?.currentUser != null
        ? const RouteSettings(name: '/home')
        : null;
  }
}