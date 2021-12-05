import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'plugin.dart';

const themeModePlugin = Plugin(
  icon: _buildIcon,
  wrapperBuilder: _buildWrapper,
  onPressed: _onPressed,
);

Widget _buildIcon(BuildContext context) {
  final IconData icon;
  switch (context.watch<ThemeModeNotifier>().value) {
    case ThemeMode.system:
      icon = Icons.brightness_auto_outlined;
      break;
    case ThemeMode.light:
      icon = Icons.brightness_5_outlined;
      break;
    case ThemeMode.dark:
      icon = Icons.brightness_3_outlined;
      break;
  }

  return Icon(icon);
}

void _onPressed(BuildContext context) {
  switch (context.read<ThemeModeNotifier>().value) {
    case ThemeMode.system:
      context.read<ThemeModeNotifier>().value = ThemeMode.light;
      break;
    case ThemeMode.light:
      context.read<ThemeModeNotifier>().value = ThemeMode.dark;
      break;
    case ThemeMode.dark:
      context.read<ThemeModeNotifier>().value = ThemeMode.system;
      break;
  }
}

Widget _buildWrapper(BuildContext context, Widget? child) =>
    ChangeNotifierProvider<ThemeModeNotifier>(
      create: (_) => ThemeModeNotifier(ThemeMode.system),
      child: Builder(
        builder: (context) {
          final themeMode = context.watch<ThemeModeNotifier>().value;
          final brightness = themeMode == ThemeMode.system
              ? MediaQuery.platformBrightnessOf(context)
              : themeMode == ThemeMode.light
                  ? Brightness.light
                  : Brightness.dark;

          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              platformBrightness: brightness,
            ),
            child: child!,
          );
        },
      ),
    );

class ThemeModeNotifier extends ValueNotifier<ThemeMode> {
  ThemeModeNotifier(ThemeMode value) : super(value);
}
