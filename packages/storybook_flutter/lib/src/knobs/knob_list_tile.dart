import 'package:flutter/material.dart';

class KnobListTile extends StatelessWidget {
  const KnobListTile({
    Key? key,
    required this.enabled,
    required this.nullable,
    required this.onToggled,
    this.title,
    this.subtitle,
    this.isThreeLine = false,
  }) : super(key: key);

  final Widget? title;
  final Widget? subtitle;
  final bool enabled;
  final bool nullable;
  final ValueChanged<bool> onToggled;
  final bool isThreeLine;

  @override
  Widget build(BuildContext context) => SwitchListTile(
        isThreeLine: isThreeLine,
        onChanged: nullable ? onToggled : null,
        value: enabled,
        controlAffinity: ListTileControlAffinity.leading,
        title: IgnorePointer(
          ignoring: !enabled,
          child: Opacity(
            opacity: enabled ? 1 : 0.5,
            child: title!,
          ),
        ),
        subtitle: Opacity(
          opacity: enabled ? 1 : 0.5,
          child: IgnorePointer(
            ignoring: !enabled,
            child: subtitle,
          ),
        ),
      );
}