import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/theme_mode_provider.dart';

class ThemeSwitcher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeModeProvider = Provider.of<ThemeModeProvider>(context);

    return IconButton(
      icon: themeModeProvider.current.icon,
      onPressed: themeModeProvider.toggle,
    );
  }
}

extension on ThemeMode {
  Icon get icon {
    switch (this) {
      case ThemeMode.system:
        return const Icon(Icons.brightness_auto);
      case ThemeMode.light:
        return const Icon(Icons.brightness_high);
      case ThemeMode.dark:
        return const Icon(Icons.brightness_3);
    }
  }
}
