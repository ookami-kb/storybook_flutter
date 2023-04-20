import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/plugins/plugin.dart';

class TimeDilationPlugin extends Plugin {
  TimeDilationPlugin({
    ValueSetter<bool>? onTimeDilationChanged,
  }) : super(
          icon: _buildIcon,
          wrapperBuilder: _buildWrapper,
          onPressed: (context) => _onPressed(context, onTimeDilationChanged),
        );
}

Widget _buildIcon(BuildContext context) => Icon(
      context.watch<TimeDilationNotifier>().value
          ? Icons.slow_motion_video_outlined
          : Icons.play_circle_outline_outlined,
    );

void _onPressed(BuildContext context, ValueSetter<bool>? onTimeDilationChanged) {
  switch (context.read<TimeDilationNotifier>().value) {
    case true:
      context.read<TimeDilationNotifier>().value = false;
      onTimeDilationChanged?.call(false);
      break;
    case false:
      context.read<TimeDilationNotifier>().value = true;
      onTimeDilationChanged?.call(true);
      break;
  }
}

Widget _buildWrapper(BuildContext _, Widget? child) => ChangeNotifierProvider<TimeDilationNotifier>(
      create: (_) => TimeDilationNotifier(false),
      child: Builder(
        builder: (context) {
          timeDilation = context.watch<TimeDilationNotifier>().value ? 10 : 1;

          return child ?? const SizedBox.shrink();
        },
      ),
    );

/// Use this notifier to get the whether time dilation is applied.
///
/// `TimeDilationPlugin` should be added to plugins for this to work.
class TimeDilationNotifier extends ValueNotifier<bool> {
  TimeDilationNotifier(bool value) : super(value);
}
