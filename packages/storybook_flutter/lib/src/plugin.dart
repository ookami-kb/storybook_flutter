import 'package:flutter/widgets.dart';

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
