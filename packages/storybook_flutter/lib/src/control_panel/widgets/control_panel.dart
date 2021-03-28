import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/control_panel/provider.dart';
import 'package:storybook_flutter/src/control_panel/widgets/full_screen_button.dart';
import 'package:storybook_flutter/src/plugins/plugin.dart';
import 'package:storybook_flutter/src/plugins/plugin_settings_notifier.dart';
import 'package:storybook_flutter/src/story_provider.dart';
import 'package:storybook_flutter/src/theme_switcher.dart';

class ControlPanel extends StatelessWidget {
  const ControlPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final panel = context.watch<ControlPanelProvider>();
    final plugin = panel.plugin;
    final plugins = panel.plugins;
    final theme = Theme.of(context);

    Widget buildIcon(Plugin p) => IconButton(
          icon: Icon(
            p.icon,
            color: plugin == p ? theme.accentColor : null,
          ),
          onPressed: () =>
              context.read<ControlPanelProvider>().toggle(p.runtimeType),
        );

    final pluginSettings = context.watch<PluginSettingsNotifier>();

    Widget? buildPluginSettings(Plugin plugin) {
      final settingsBuilder = plugin.settingsBuilder;

      return Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(color: Theme.of(context).dividerColor),
          ),
          color: Theme.of(context).cardColor,
        ),
        child: settingsBuilder!(
          context,
          context.watch<StoryProvider>().currentStory,
          pluginSettings.get<dynamic>(plugin.runtimeType),
          (dynamic value) => context
              .read<PluginSettingsNotifier>()
              .set(plugin.runtimeType, value),
        ),
      );
    }

    return AnimatedContainer(
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 250),
      width: plugin != null ? _contentWidth + _iconPanelWidth : _iconPanelWidth,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: SizedBox(
              width: _contentWidth,
              child: plugin?.let(buildPluginSettings) ?? Container(),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Material(
              color: theme.cardColor,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  border: Border(left: BorderSide(color: theme.dividerColor)),
                ),
                width: _iconPanelWidth,
                child: Column(
                  children: [
                    ...plugins
                        .where((p) => p.settingsBuilder != null)
                        .map(buildIcon)
                        .toList(),
                    const Spacer(),
                    const FullScreenButton(),
                    const ThemeSwitcher(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const double _iconPanelWidth = 60;
const double _contentWidth = 200;
