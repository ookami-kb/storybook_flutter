import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/control_panel/provider.dart';
import 'package:storybook_flutter/src/control_panel/widgets/full_screen_button.dart';
import 'package:storybook_flutter/src/control_panel/widgets/screenshot_button/screenshot_button.dart';
import 'package:storybook_flutter/src/plugins/plugin.dart';
import 'package:storybook_flutter/src/plugins/plugin_settings_notifier.dart';
import 'package:storybook_flutter/src/story_provider.dart';
import 'package:storybook_flutter/src/theme_switcher.dart';

class ControlPanel extends StatelessWidget {
  const ControlPanel({
    Key? key,
    this.direction = Axis.horizontal,
  }) : super(key: key);

  final Axis direction;

  @override
  Widget build(BuildContext context) {
    final panel = context.watch<ControlPanelProvider>();
    final plugin = panel.plugin;
    final theme = Theme.of(context);
    final isHorizontal = direction == Axis.horizontal;

    Widget buildIcon(Plugin p) => IconButton(
          icon: Icon(
            p.icon,
            color: plugin == p ? theme.colorScheme.secondary : null,
          ),
          onPressed: () =>
              context.read<ControlPanelProvider>().toggle(p.runtimeType),
        );

    final border = Border(
      left: isHorizontal
          ? BorderSide(color: theme.dividerColor)
          : BorderSide.none,
      top: isHorizontal
          ? BorderSide.none
          : BorderSide(color: theme.dividerColor),
    );

    final pluginSettings = context.watch<PluginSettingsNotifier>();

    Widget? buildPluginSettings(Plugin plugin) {
      final buildSettings = plugin.settingsBuilder!;

      return Container(
        decoration: BoxDecoration(border: border, color: theme.cardColor),
        child: buildSettings(
          context,
          context.watch<StoryProvider>().currentStory,
          pluginSettings.get<dynamic>(plugin.runtimeType),
          (dynamic value) => context
              .read<PluginSettingsNotifier>()
              .set(plugin.runtimeType, value),
        ),
      );
    }

    final panelSize =
        plugin != null ? _contentSize + _iconPanelSize : _iconPanelSize;

    return AnimatedContainer(
      key: ValueKey(direction),
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 250),
      width: isHorizontal ? panelSize : null,
      height: isHorizontal ? null : panelSize,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: isHorizontal ? null : 0,
            top: 0,
            bottom: isHorizontal ? 0 : null,
            child: SizedBox(
              width: isHorizontal ? _contentSize : null,
              height: isHorizontal ? null : _contentSize,
              child: plugin == null ? Container() : buildPluginSettings(plugin),
            ),
          ),
          Align(
            alignment:
                isHorizontal ? Alignment.centerRight : Alignment.bottomCenter,
            child: Material(
              color: theme.cardColor,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(border: border),
                width: isHorizontal ? _iconPanelSize : double.maxFinite,
                height: isHorizontal ? null : _iconPanelSize,
                child: Flex(
                  direction: isHorizontal ? Axis.vertical : Axis.horizontal,
                  children: [
                    ...panel.plugins
                        .where((p) => p.settingsBuilder != null)
                        .map(buildIcon)
                        .toList(),
                    const Spacer(),
                    Consumer<StoryProvider>(
                        builder: (_, provider, __) => Visibility(
                              visible: provider.currentStory != null,
                              replacement: const SizedBox(),
                              child: const ScreenShotButton(),
                            )),
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

const double _iconPanelSize = 60;
const double _contentSize = 200;
