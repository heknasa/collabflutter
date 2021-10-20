import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

late final Provider<SharedPreferences> sharedPreferences;

Future<void> initGlobalProviders() async {
  final sharedPreferencesInstance = await SharedPreferences.getInstance();
  sharedPreferences = Provider((_) => sharedPreferencesInstance);
}

final preferences = Provider((ref) => Preferences(
  sharedPreferences: ref.watch(sharedPreferences)
));

class Preferences {
  final SharedPreferences sharedPreferences;
  Preferences({required this.sharedPreferences});

  persistThemeMode(ThemeMode mode) => sharedPreferences.setString('themeMode', mode.toString());

  ThemeMode get themeMode => ThemeMode.values.firstWhere(
    (element) => element.toString() == sharedPreferences.getString('themeMode'),
    orElse: () => ThemeMode.system
  );
}