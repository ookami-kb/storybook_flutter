import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/src/knobs/knobs_plugin.dart';
import 'package:storybook_flutter/src/plugins/plugin.dart';

class ControlPanelProvider extends ChangeNotifier {
  ControlPanelProvider(this.plugins);

  final List<Plugin> plugins;

  Plugin? _plugin = KnobsPlugin();

  Plugin? get plugin => _plugin;

  void toggle(Type? pluginType) {
    _plugin = _plugin?.runtimeType == pluginType
        ? null
        : plugins.firstWhereOrNull((p) => p.runtimeType == pluginType);
    notifyListeners();
  }
}
