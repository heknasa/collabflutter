import 'package:collabflutter/temporary_theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/todo_screen.dart';
import 'screens/home_screen/login_page.dart';
import 'services/todo_repo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'screens/home_screen/home_screen.dart';
import 'providers/global_providers.dart';
import 'providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initGlobalProviders();
  runApp(
    ProviderScope(
      child: Consumer(
        builder: (context, ref, child) {
          return MaterialApp(
            themeMode: ref.watch(themeMode),
            theme: ref.watch(theme),
            darkTheme: ref.watch(darkTheme),
            initialRoute: '/',
            routes: {
              '/' : (context) => HomeScreen(),
              '/todo' : (context) => TodoScreen()
            }
          );
        }
      ),
    )
  );
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   await initGlobalProviders();
//   runApp(
//     ProviderScope(
//       child: TemporaryTheme()
//     )
//   );
// }