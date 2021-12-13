import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class KnobsPlugin extends Plugin<Object> {
  KnobsPlugin()
      : super(
          icon: Icons.settings,
          settingsBuilder: _knobsPluginBuilder,
        );
}

Widget _knobsPluginBuilder(
  BuildContext context,
  Story? story,
  dynamic data,
  void Function(dynamic) update,
) =>
    const KnobPanel();
