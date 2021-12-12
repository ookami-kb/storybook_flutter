import 'package:flutter/widgets.dart';

import 'contents.dart';
import 'device_frame.dart';
import 'knobs.dart';
import 'theme_mode.dart';

export 'contents.dart';
export 'device_frame.dart';
export 'knobs.dart';
export 'theme_mode.dart';

List<Plugin> initializePlugins({
  bool enableContents = true,
  bool enableKnobs = true,
  bool enableThemeMode = true,
  bool enableDeviceFrame = true,
  DeviceFrameData initialDeviceFrameData = const DeviceFrameData(),
  bool contentsSidePanel = false,
  bool knobsSidePanel = false,
}) =>
    [
      if (enableContents) ContentsPlugin(sidePanel: contentsSidePanel),
      if (enableKnobs) KnobsPlugin(sidePanel: knobsSidePanel),
      if (enableThemeMode) themeModePlugin,
      if (enableDeviceFrame)
        DeviceFramePlugin(initialData: initialDeviceFrameData),
    ];

typedef OnPluginButtonPressed = void Function(BuildContext);

class Plugin {
  const Plugin({
    this.wrapperBuilder,
    this.panelBuilder,
    this.storyBuilder,
    this.icon,
    this.onPressed,
  });

  final TransitionBuilder? wrapperBuilder;
  final WidgetBuilder? panelBuilder;
  final TransitionBuilder? storyBuilder;
  final WidgetBuilder? icon;
  final OnPluginButtonPressed? onPressed;
}
