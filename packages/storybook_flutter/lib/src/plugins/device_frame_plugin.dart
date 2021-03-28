import 'package:device_frame/device_frame.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:storybook_flutter/src/plugins/plugin.dart';
import 'package:storybook_flutter/src/story.dart';

part 'device_frame_plugin.freezed.dart';

/// Wraps each story into device frame.
///
/// User can customize orientation, device model and whether to
/// show device bezels.
class DeviceFramePlugin extends Plugin<DeviceFrameData> {
  DeviceFramePlugin({
    DeviceFrameData initialData = const DeviceFrameData(),
  }) : super(
          storyBuilder: _storyBuilder,
          icon: Icons.phone_android,
          settingsBuilder: _settingsBuilder,
          initialData: initialData,
        );
}

Widget _storyBuilder(
  BuildContext context,
  Story story,
  Widget child,
  DeviceFrameData? data,
) {
  final d = data ?? const DeviceFrameData();
  return d.device == null
      ? child
      : Padding(
          padding: const EdgeInsets.all(16),
          child: DeviceFrame(
            device: d.device!,
            isFrameVisible: d.isFrameVisible,
            orientation: d.orientation,
            screen: child,
          ),
        );
}

Widget _settingsBuilder(
  BuildContext context,
  Story? story,
  DeviceFrameData? data,
  void Function(DeviceFrameData?) update,
) {
  final d = data ?? const DeviceFrameData();
  final devices = Devices.all
      .sortedBy((d) => d.name)
      .map((device) => ListTile(
            title: Text(
              device.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              '${device.screenSize.width.toInt()}×'
              '${device.screenSize.height.toInt()}',
            ),
            trailing: d.device == device ? const Icon(Icons.check) : null,
            onTap: () => update(d.copyWith(device: device)),
          ))
      .toList();

  return ListView.separated(
    separatorBuilder: (context, i) => i == 1
        ? Container(
            height: 1,
            color: Theme.of(context).dividerColor,
          )
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
}

@freezed
class DeviceFrameData with _$DeviceFrameData {
  const factory DeviceFrameData({
    @Default(true) bool isFrameVisible,
    DeviceInfo? device,
    @Default(Orientation.portrait) Orientation orientation,
  }) = _DeviceFrameData;
}
