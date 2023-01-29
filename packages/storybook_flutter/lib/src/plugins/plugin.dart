import 'package:flutter/widgets.dart';
import 'package:storybook_flutter/src/plugins/contents/contents.dart';
import 'package:storybook_flutter/src/plugins/device_frame.dart';
import 'package:storybook_flutter/src/plugins/knobs.dart';
import 'package:storybook_flutter/src/plugins/theme_mode.dart';

export 'contents/contents.dart';
export 'device_frame.dart';
export 'knobs.dart';
export 'theme_mode.dart';

/// Use this method to initialize and customize built-in plugins.
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
      if (enableThemeMode) ThemeModePlugin(),
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

  /// Optional wrapper that will be inserted above the whole storybook content,
  /// including panel.
  ///
  /// E.g. `ContentsPlugin` uses this builder to add side panel.
  final TransitionBuilder? wrapperBuilder;

  /// Optional builder that will be used to display panel popup. It appears when
  /// user clicks on the [icon].
  ///
  /// For it to be used, [icon] must be provided.
  final WidgetBuilder? panelBuilder;

  /// Optional wrapper that will be inserted above each story.
  ///
  /// E.g. `DeviceFramePlugin` uses this builder to display device frame.
  final TransitionBuilder? storyBuilder;

  /// Optional icon that will be displayed on the bottom panel.
  final WidgetBuilder? icon;

  /// Optional callback that will be called when user clicks on the [icon].
  ///
  /// For it to be used, [icon] must be provided.
  final OnPluginButtonPressed? onPressed;
}
