import 'package:collabflutter/screens/splash_screen.dart';
import 'package:collabflutter/temporary_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/todo_screen.dart';
import 'screens/login_screen.dart';
import 'services/todo_repo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'screens/home_screen.dart';
import 'providers/global_providers.dart';
import 'providers/theme_provider.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initGlobalProviders();
  runApp(
    ProviderScope(
      child: Consumer(
        builder: (context, ref, child) {
          return GetMaterialApp(
            themeMode: ref.watch(themeMode),
            theme: ref.watch(theme),
            darkTheme: ref.watch(darkTheme),
            initialRoute: '/',
            getPages: [
              GetPage(name: '/', page: () => SplashScreen()),
              GetPage(name: '/home', page: () => HomeScreen(), middlewares: [_Unauthorized()]),
              GetPage(name: '/todo', page: () => TodoScreen(), middlewares: [_Unauthorized()]),
              GetPage(name: '/login', page: () => LoginScreen(), middlewares: [_Authorized()]),
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
        ? RouteSettings(name: '/home')
        : null;
  }
}