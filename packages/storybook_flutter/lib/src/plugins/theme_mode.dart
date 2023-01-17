import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storybook_flutter/src/plugins/plugin.dart';

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
      _saveThemeModeToPreferences(ThemeMode.light);
      break;
    case ThemeMode.light:
      context.read<ThemeModeNotifier>().value = ThemeMode.dark;
      _saveThemeModeToPreferences(ThemeMode.dark);
      break;
    case ThemeMode.dark:
      context.read<ThemeModeNotifier>().value = ThemeMode.system;
      _saveThemeModeToPreferences(ThemeMode.system);
      break;
  }
}

Future<ThemeMode> _getThemeModeFromPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  final themeMode = prefs.getString('themeMode');
  switch (themeMode) {
    case 'system':
      return ThemeMode.system;
    case 'light':
      return ThemeMode.light;
    case 'dark':
      return ThemeMode.dark;
    default:
      return ThemeMode.system;
  }
}

Future<void> _saveThemeModeToPreferences(ThemeMode themeMode) async {
  final prefs = await SharedPreferences.getInstance();
  switch (themeMode) {
    case ThemeMode.system:
      await prefs.setString('themeMode', 'system');
      break;
    case ThemeMode.light:
      await prefs.setString('themeMode', 'light');
      break;
    case ThemeMode.dark:
      await prefs.setString('themeMode', 'dark');
      break;
  }
}

Widget _buildWrapper(BuildContext _, Widget? child) => FutureBuilder<ThemeMode>(
      future: _getThemeModeFromPreferences(),
      builder: (context, snapshot) {
        final themeMode = snapshot.data ?? ThemeMode.system;

        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          default:
            return ChangeNotifierProvider<ThemeModeNotifier>(
              create: (_) => ThemeModeNotifier(themeMode),
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
                    child: child ?? const SizedBox.shrink(),
                  );
                },
              ),
            );
        }
      },
    );

/// Use this notifier to get the current theme mode.
///
/// `ThemeModePlugin` should be added to plugins for this to work.
class ThemeModeNotifier extends ValueNotifier<ThemeMode> {
  ThemeModeNotifier(ThemeMode value) : super(value);
}
