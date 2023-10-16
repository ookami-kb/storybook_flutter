import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/plugins/plugin.dart';

class DirectionalityPlugin extends Plugin {
  DirectionalityPlugin({
    ValueSetter<TextDirection>? onTextDirectionChanged,
  }) : super(
          icon: _buildIcon,
          wrapperBuilder: _buildWrapper,
          onPressed: (context) => _onPressed(context, onTextDirectionChanged),
        );
}

Widget _buildIcon(BuildContext context) => Icon(
      context.watch<TextDirectionNotifier>().value == TextDirection.rtl
          ? Icons.format_textdirection_r_to_l_outlined
          : Icons.format_textdirection_l_to_r_outlined,
    );

void _onPressed(
  BuildContext context,
  ValueSetter<TextDirection>? onTextDirectionChanged,
) {
  switch (context.read<TextDirectionNotifier>().value) {
    case TextDirection.ltr:
      context.read<TextDirectionNotifier>().value = TextDirection.rtl;
      onTextDirectionChanged?.call(TextDirection.rtl);
      break;
    case TextDirection.rtl:
      context.read<TextDirectionNotifier>().value = TextDirection.ltr;
      onTextDirectionChanged?.call(TextDirection.ltr);
      break;
  }
}

Widget _buildWrapper(BuildContext _, Widget? child) =>
    ChangeNotifierProvider<TextDirectionNotifier>(
      create: (_) => TextDirectionNotifier(TextDirection.ltr),
      child: Builder(
        builder: (context) => Directionality(
          textDirection: context.watch<TextDirectionNotifier>().value,
          child: child ?? const SizedBox.shrink(),
        ),
      ),
    );

/// Use this notifier to get the current directionality.
///
/// `DirectionalityPlugin` should be added to plugins for this to work.
class TextDirectionNotifier extends ValueNotifier<TextDirection> {
  TextDirectionNotifier(super.value);
}
