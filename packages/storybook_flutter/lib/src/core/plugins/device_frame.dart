import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/src/core/plugin.dart';

const deviceFramePlugin = Plugin(
  storyBuilder: _buildStoryWrapper,
);

Widget _buildStoryWrapper(BuildContext context, Widget? child) =>
    Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: DeviceFrame(
          device: Devices.ios.iPhone11ProMax,
          screen: child!,
        ),
      ),
    );
