import 'package:device_preview/plugins.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class ContentsPlugin extends DevicePreviewPlugin {
  const ContentsPlugin()
      : super(
          identifier: 'storybook_flutter.contents',
          name: 'Contents',
          icon: Icons.list,
          windowSize: const Size(220, 400),
        );

  @override
  Widget buildData(
    BuildContext context,
    Map<String, dynamic> data,
    DevicePreviewPluginDataUpdater updateData,
  ) =>
      const Contents();
}

class KnobsPlugin extends DevicePreviewPlugin {
  const KnobsPlugin()
      : super(
          identifier: 'storybook_flutter.knobs',
          name: 'Knobs',
          icon: Icons.settings,
          windowSize: const Size(220, 400),
        );

  @override
  Widget buildData(
    BuildContext context,
    Map<String, dynamic> data,
    DevicePreviewPluginDataUpdater updateData,
  ) =>
      const KnobPanel();
}
