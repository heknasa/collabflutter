import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
    surface: const Color(0xFFF2F2F2),
    background: const Color(0xFFF2F2F2),
    error: Colors.red,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: Colors.black,
    onBackground: Colors.black,
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
    surface: const Color(0xFF121212),
    background: const Color(0xFF121212),
    error: Colors.redAccent,
    onPrimary: Colors.black,
    onSecondary: Colors.black,
    onSurface: Colors.white,
    onBackground: Colors.white,
    onError: Colors.black,
    brightness: Brightness.dark,
  ),
);

const double breakpoint = 767;
const double mobile = 2/3;

const FontWeight thin = FontWeight.w100;
const FontWeight extralight = FontWeight.w200;
const FontWeight light = FontWeight.w300;
const FontWeight regular = FontWeight.w400;
const FontWeight medium = FontWeight.w500;
const FontWeight semibold = FontWeight.w600;
const FontWeight bold = FontWeight.w700;
const FontWeight extrabold = FontWeight.w800;
const FontWeight black = FontWeight.w900;

const FontStyle italic = FontStyle.italic;

const double headline1 = 103;
const double headline2 = 64;
const double headline3 = 51;
const double headline4 = 36;
const double headline5 = 26;
const double headline6 = 21;
const double subtitle1 = 17;
const double subtitle2 = 15;
const double button = 15;
const double caption = 13;
const double overline = 11;