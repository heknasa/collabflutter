import 'package:collabflutter/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ThemeSwitch extends ConsumerWidget {
  const ThemeSwitch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool? isToggled;
    if (Theme.of(context).brightness == Brightness.dark) {
      isToggled = true;
    } else if (Theme.of(context).brightness == Brightness.light) {
      isToggled = false;
    }
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: FlutterSwitch(
        inactiveIcon: Icon(
          Icons.light_mode_rounded,
          color: Theme.of(context).colorScheme.surface
        ),
        activeIcon: Icon(
          Icons.dark_mode_rounded,
          color: Theme.of(context).colorScheme.surface
        ),
        activeToggleColor: Theme.of(context).colorScheme.onSurface,
        inactiveToggleColor: Theme.of(context).colorScheme.onSurface,
        activeColor: Colors.transparent,
        inactiveColor: Colors.transparent,
        switchBorder: Border.all(
          color: Theme.of(context).colorScheme.onSurface,
          width: 4.0
        ),
        value: isToggled!,
        onToggle: (val) {
          ref.watch(themeMode.notifier).changeThemeMode();
          isToggled = val;
        },                
      ),
    );
  }
}