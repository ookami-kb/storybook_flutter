import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/control_panel/provider.dart';
import 'package:storybook_flutter/src/control_panel/widgets/full_screen_button.dart';
import 'package:storybook_flutter/src/knobs/knob_panel.dart';
import 'package:storybook_flutter/src/theme_switcher.dart';

class ControlPanel extends StatelessWidget {
  const ControlPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final option = context.watch<ControlPanelProvider>().option;

    final theme = Theme.of(context);
    return AnimatedContainer(
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 250),
      width: option != null ? _contentWidth + _iconPanelWidth : _iconPanelWidth,
      child: Stack(
        children: [
          const Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: SizedBox(width: _contentWidth, child: KnobPanel()),
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
                    IconButton(
                      icon: Icon(
                        Icons.settings,
                        color: option == ControlPanelOption.knobs
                            ? theme.accentColor
                            : null,
                      ),
                      onPressed: () => context
                          .read<ControlPanelProvider>()
                          .toggle(ControlPanelOption.knobs),
                    ),
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
