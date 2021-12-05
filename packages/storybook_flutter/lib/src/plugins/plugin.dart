import 'package:flutter/widgets.dart';

import 'contents.dart';
import 'device_frame.dart';
import 'knobs.dart';
import 'theme_mode.dart';

export 'contents.dart';
export 'device_frame.dart';
export 'knobs.dart';
export 'theme_mode.dart';

const allPlugins = [
  contentsPlugin,
  knobsPlugin,
  themeModePlugin,
  deviceFramePlugin,
];

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
  final void Function(BuildContext)? onPressed;
}
