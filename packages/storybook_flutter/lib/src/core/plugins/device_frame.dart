import 'package:collection/collection.dart';
import 'package:device_frame/device_frame.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/core/plugin.dart';
import 'package:storybook_flutter/src/plugins/device_frame_plugin.dart';

const deviceFramePlugin = Plugin(
  storyBuilder: _buildStoryWrapper,
  wrapperBuilder: _buildWrapper,
  panelBuilder: _buildPanel,
  icon: _buildIcon,
);

Widget _buildIcon(BuildContext _) => const Icon(Icons.phone_android);

Widget _buildStoryWrapper(BuildContext context, Widget? child) {
  final d = context.watch<DeviceFrameDataNotifier>().value;

  final result = d.device == null
      ? child!
      : Padding(
          padding: const EdgeInsets.all(16),
          child: DeviceFrame(
            device: d.device!,
            isFrameVisible: d.isFrameVisible,
            orientation: d.orientation,
            screen: child!,
          ),
        );

  return Directionality(textDirection: TextDirection.ltr, child: result);
}

class DeviceFrameDataNotifier extends ValueNotifier<DeviceFrameData> {
  DeviceFrameDataNotifier(DeviceFrameData value) : super(value);
}

Widget _buildWrapper(BuildContext context, Widget? child) =>
    ChangeNotifierProvider(
      create: (context) => DeviceFrameDataNotifier(const DeviceFrameData()),
      child: child,
    );

Widget _buildPanel(BuildContext context) {
  final d = context.watch<DeviceFrameDataNotifier>().value;
  void update(DeviceFrameData data) =>
      context.read<DeviceFrameDataNotifier>().value = data;

  final devices = Devices.all
      .sortedBy((d) => d.name)
      .map(
        (device) => ListTile(
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
        ),
      )
      .toList();

  return ListView.separated(
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
}
