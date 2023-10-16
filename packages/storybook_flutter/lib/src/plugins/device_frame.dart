import 'package:device_frame/device_frame.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/plugins/plugin.dart';

/// Plugin that allows wrapping each story into a device frame.
class DeviceFramePlugin extends Plugin {
  DeviceFramePlugin({
    bool enableCompactLayoutDeviceFrame = true,
    bool enableExpandedLayoutDeviceFrame = true,
    DeviceFrameData initialData = defaultDeviceFrameData,
    List<DeviceInfo>? deviceInfo,
  }) : super(
          icon: (BuildContext context) => _buildIcon(
            context,
            enableCompactLayoutDeviceFrame,
            enableExpandedLayoutDeviceFrame,
          ),
          storyBuilder: _buildStoryWrapper,
          wrapperBuilder: (BuildContext context, Widget? child) =>
              _buildWrapper(context, child, initial: initialData),
          panelBuilder: (BuildContext context) =>
              _buildPanel(context, deviceInfo),
        );
}

Widget? _buildIcon(
  BuildContext context,
  bool enableCompactDeviceFrame,
  bool enableExpandedDeviceFrame,
) {
  final EffectiveLayout effectiveLayout = context.watch<EffectiveLayout>();

  final bool showIconForCompactLayout =
      effectiveLayout == EffectiveLayout.compact && enableCompactDeviceFrame;

  final bool showIconForExpandedLayout =
      effectiveLayout == EffectiveLayout.expanded && enableExpandedDeviceFrame;

  return showIconForCompactLayout || showIconForExpandedLayout
      ? const Icon(Icons.phone_android)
      : null;
}

Widget _buildStoryWrapper(BuildContext context, Widget? child) {
  final d = context.watch<DeviceFrameDataNotifier>().value;
  final device = d.device;

  final result = device == null
      ? child ?? const SizedBox.shrink()
      : SizedBox(
          width: double.infinity,
          child: Material(
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: DeviceFrame(
                  device: device,
                  isFrameVisible: d.isFrameVisible,
                  orientation: d.orientation,
                  screen: child ?? const SizedBox.shrink(),
                ),
              ),
            ),
          ),
        );

  return Directionality(textDirection: TextDirection.ltr, child: result);
}

typedef DeviceFrameData = ({
  bool isFrameVisible,
  DeviceInfo? device,
  Orientation orientation,
});

const DeviceFrameData defaultDeviceFrameData = (
  isFrameVisible: true,
  device: null,
  orientation: Orientation.portrait,
);

class DeviceFrameDataNotifier extends ValueNotifier<DeviceFrameData> {
  DeviceFrameDataNotifier(super.value);
}

Widget _buildWrapper(
  BuildContext context,
  Widget? child, {
  required DeviceFrameData initial,
}) {
  final Layout layout = context.read<LayoutProvider>().value;
  final EffectiveLayout effectiveLayout = context.watch<EffectiveLayout>();

  return layout == Layout.auto
      ? ChangeNotifierProvider(
          create: (BuildContext _) => DeviceFrameDataNotifier(
            (
              isFrameVisible: initial.isFrameVisible,
              device: effectiveLayout == EffectiveLayout.compact
                  ? null
                  : initial.device,
              orientation: initial.orientation,
            ),
          ),
          child: child,
        )
      : ChangeNotifierProvider(
          create: (BuildContext _) => DeviceFrameDataNotifier(initial),
          child: child,
        );
}

Widget _buildPanel(BuildContext context, List<DeviceInfo>? deviceInfo) {
  final d = context.watch<DeviceFrameDataNotifier>().value;
  void update(DeviceFrameData data) =>
      context.read<DeviceFrameDataNotifier>().value = data;

  final devices = (deviceInfo ?? Devices.all)
      .map(
        (device) => ListTile(
          leading: CircleAvatar(
            child: Icon(
              device.identifier.type.icon(device.identifier.platform),
            ),
          ),
          title: Text(
            device.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            '${device.screenSize.width.toInt()}×'
            '${device.screenSize.height.toInt()} (${describeEnum(device.identifier.platform)})',
          ),
          trailing: d.device == device ? const Icon(Icons.check) : null,
          onTap: () => update(
            (
              device: device,
              isFrameVisible: d.isFrameVisible,
              orientation: d.orientation,
            ),
          ),
        ),
      )
      .toList();

  return ListView.separated(
    padding: EdgeInsets.zero,
    primary: false,
    separatorBuilder: (context, i) => i == 1
        ? Container(height: 1, color: Theme.of(context).dividerColor)
        : const SizedBox(),
    itemBuilder: (context, i) {
      if (i == 0) {
        return CheckboxListTile(
          title: const Text('Display frame'),
          value: d.isFrameVisible,
          onChanged: (v) => update(
            (
              device: d.device,
              isFrameVisible: v ?? false,
              orientation: d.orientation,
            ),
          ),
        );
      }

      if (i == 1) {
        return ListTile(
          title: const Text('Orientation'),
          subtitle: Text(describeEnum(d.orientation)),
          onTap: () {
            final orientation = d.orientation == Orientation.portrait
                ? Orientation.landscape
                : Orientation.portrait;
            update(
              (
                orientation: orientation,
                device: d.device,
                isFrameVisible: d.isFrameVisible,
              ),
            );
          },
        );
      }

      if (i == 2) {
        return ListTile(
          title: const Text('No device'),
          trailing: d.device == null ? const Icon(Icons.check) : null,
          onTap: () => update(
            (
              device: null,
              isFrameVisible: d.isFrameVisible,
              orientation: d.orientation,
            ),
          ),
        );
      }

      // ignore: prefer-returning-conditional-expressions, more readable
      return devices[i - 3];
    },
    itemCount: devices.length + 3,
  );
}

extension on DeviceType {
  IconData icon(TargetPlatform platform) {
    switch (this) {
      case DeviceType.phone:
        return platform == TargetPlatform.android
            ? Icons.phone_android
            : Icons.phone_iphone;
      case DeviceType.tablet:
        return platform == TargetPlatform.android
            ? Icons.tablet_android
            : Icons.tablet_mac;
      case DeviceType.desktop:
        return platform == TargetPlatform.macOS
            ? Icons.desktop_mac
            : Icons.desktop_windows;
      case DeviceType.tv:
        return Icons.tv;
      case DeviceType.laptop:
        return platform == TargetPlatform.macOS
            ? Icons.laptop_mac
            : Icons.laptop_windows;
      case DeviceType.unknown:
        return Icons.device_unknown;
    }
  }
}
