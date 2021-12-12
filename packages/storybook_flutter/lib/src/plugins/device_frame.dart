import 'package:device_frame/device_frame.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:provider/provider.dart';

import 'plugin.dart';

part 'device_frame.freezed.dart';

class DeviceFramePlugin implements Plugin {
  DeviceFramePlugin({this.initialData = const DeviceFrameData()});

  final DeviceFrameData initialData;

  @override
  final WidgetBuilder? icon = (_) => const Icon(Icons.phone_android);

  @override
  final OnPluginButtonPressed? onPressed = null;

  @override
  final WidgetBuilder? panelBuilder = (context) {
    final d = context.watch<DeviceFrameDataNotifier>().value;
    void update(DeviceFrameData data) =>
        context.read<DeviceFrameDataNotifier>().value = data;

    final devices = Devices.all
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
            onTap: () => update(d.copyWith(device: device)),
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
            onChanged: (v) => update(d.copyWith(isFrameVisible: v ?? false)),
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
              update(d.copyWith(orientation: orientation));
            },
          );
        }
        if (i == 2) {
          return ListTile(
            title: const Text('No device'),
            trailing: d.device == null ? const Icon(Icons.check) : null,
            onTap: () => update(d.copyWith(device: null)),
          );
        }
        return devices[i - 3];
      },
      itemCount: devices.length + 3,
    );
  };

  @override
  final TransitionBuilder? storyBuilder = (context, child) {
    final d = context.watch<DeviceFrameDataNotifier>().value;

    final result = d.device == null
        ? child!
        : SizedBox(
            width: double.infinity,
            child: Material(
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: DeviceFrame(
                    device: d.device!,
                    isFrameVisible: d.isFrameVisible,
                    orientation: d.orientation,
                    screen: child!,
                  ),
                ),
              ),
            ),
          );

    return Directionality(textDirection: TextDirection.ltr, child: result);
  };

  @override
  late final TransitionBuilder? wrapperBuilder =
      (context, child) => ChangeNotifierProvider(
            create: (context) => DeviceFrameDataNotifier(initialData),
            child: child,
          );
}

@freezed
class DeviceFrameData with _$DeviceFrameData {
  const factory DeviceFrameData({
    @Default(true) bool isFrameVisible,
    DeviceInfo? device,
    @Default(Orientation.portrait) Orientation orientation,
  }) = _DeviceFrameData;
}

class DeviceFrameDataNotifier extends ValueNotifier<DeviceFrameData> {
  DeviceFrameDataNotifier(DeviceFrameData value) : super(value);
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
