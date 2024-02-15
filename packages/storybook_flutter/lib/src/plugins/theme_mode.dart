import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/plugins/plugin.dart';

class ThemeModePlugin extends Plugin {
  ThemeModePlugin({
    ThemeMode? initialTheme,
    ValueSetter<ThemeMode>? onThemeChanged,
  }) : super(
          icon: _buildIcon,
          wrapperBuilder: (context, widget) => _buildWrapper(
            context,
            widget,
            initialTheme,
          ),
          onPressed: (context) => _onPressed(context, onThemeChanged),
        );
}

Widget _buildIcon(BuildContext context) {
  final IconData icon;
  switch (context.watch<ThemeModeNotifier>().value) {
    case ThemeMode.system:
      icon = Icons.brightness_auto_outlined;
    case ThemeMode.light:
      icon = Icons.brightness_5_outlined;
    case ThemeMode.dark:
      icon = Icons.brightness_3_outlined;
  }

  return Icon(icon);
}

void _onPressed(BuildContext context, ValueSetter<ThemeMode>? onThemeChanged) {
  switch (context.read<ThemeModeNotifier>().value) {
    case ThemeMode.system:
      context.read<ThemeModeNotifier>().value = ThemeMode.light;
      onThemeChanged?.call(ThemeMode.light);
    case ThemeMode.light:
      context.read<ThemeModeNotifier>().value = ThemeMode.dark;
      onThemeChanged?.call(ThemeMode.dark);
    case ThemeMode.dark:
      context.read<ThemeModeNotifier>().value = ThemeMode.system;
      onThemeChanged?.call(ThemeMode.system);
  }
}

Widget _buildWrapper(BuildContext _, Widget? child, ThemeMode? initialTheme) =>
    ChangeNotifierProvider<ThemeModeNotifier>(
      create: (_) => ThemeModeNotifier(initialTheme ?? ThemeMode.system),
      child: Builder(
        builder: (context) {
          final themeMode = context.watch<ThemeModeNotifier>().value;
          final brightness = switch (themeMode) {
            ThemeMode.system => MediaQuery.platformBrightnessOf(context),
            ThemeMode.light => Brightness.light,
            ThemeMode.dark => Brightness.dark,
          };

          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              platformBrightness: brightness,
            ),
            child: child ?? const SizedBox.shrink(),
          );
        },
      ),
    );

/// Use this notifier to get the current theme mode.
///
/// `ThemeModePlugin` should be added to plugins for this to work.
class ThemeModeNotifier extends ValueNotifier<ThemeMode> {
  ThemeModeNotifier(super._value);
}
