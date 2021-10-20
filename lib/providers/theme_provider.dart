import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'global_providers.dart';

final theme = Provider((ref) => _theme);
final darkTheme = Provider((ref) => _darkTheme);
final themeMode = StateNotifierProvider<ThemeModeNotifier, ThemeMode>(
  (ref) => ThemeModeNotifier(preferences: ref.watch(preferences)));

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  final Preferences preferences;

  ThemeModeNotifier({required this.preferences}) : super (preferences.themeMode);

  void changeThemeMode() {
    if(state == ThemeMode.light) {
      preferences.persistThemeMode(ThemeMode.dark);
      state = ThemeMode.dark;
    } else {
      preferences.persistThemeMode(ThemeMode.light);
      state = ThemeMode.light;
    }
  }
}

final _theme = ThemeData(
  fontFamily: 'Work Sans',
  colorScheme: ColorScheme(
    primary: Colors.grey.shade500,
    primaryVariant: Colors.grey.shade700,
    secondary: Colors.blueGrey.shade200,
    secondaryVariant: Colors.blueGrey.shade900,
    surface: Colors.white,
    background: Colors.white,
    error: Colors.red,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: Color(0xFFF2F2F2),
    onBackground: Color(0xFFF2F2F2),
    onError: Colors.white,
    brightness: Brightness.light
  ),
);

final _darkTheme = ThemeData(
  fontFamily: 'Work Sans',
  colorScheme: ColorScheme(
    primary: Colors.grey.shade200,
    primaryVariant: Colors.grey.shade700,
    secondary: Colors.blueGrey.shade200,
    secondaryVariant: Colors.blueGrey.shade200,
    surface: Color(0xFF121212),
    background: Color(0xFF121212),
    error: Colors.redAccent,
    onPrimary: Colors.black,
    onSecondary: Colors.black,
    onSurface: Colors.white,
    onBackground: Colors.white,
    onError: Colors.black,
    brightness: Brightness.dark
  ),
);