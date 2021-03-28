import 'package:flutter/material.dart';
import 'package:storybook_flutter/src/plugins/device_frame_plugin.dart';
import 'package:storybook_flutter/src/story.dart';

/// Base class for custom plugins.
///
/// Create a custom plugin by extending this class. Plugins can wrap
/// story into custom widgets by providing [storyBuilder] and have
/// settings panel by providing [settingsBuilder].
///
/// See [DeviceFramePlugin] as an example for using both [settingsBuilder]
/// and [storyBuilder].
abstract class Plugin<T> {
  Plugin({
    this.icon = Icons.settings,
    PluginSettingsBuilder<T>? settingsBuilder,
    PluginStoryBuilder<T> storyBuilder = _default,
    this.initialData,
  })  : settingsBuilder = settingsBuilder == null
            ? null
            : ((context, story, dynamic data, update) => settingsBuilder(
                context, story, (data as T?) ?? initialData, update)),
        storyBuilder = ((context, story, child, dynamic data) =>
            storyBuilder(context, story, child, (data as T?) ?? initialData));

  /// Icon that will be rendered in settings panel.
  ///
  /// Icon appears only if the plugin provides [settingsBuilder].
  final IconData icon;

  /// Settings panel content for this plugin.
  ///
  /// Provide [settingsBuilder] to show plugin icon and render settings
  /// in the panel.
  final PluginSettingsBuilder? settingsBuilder;

  /// Story wrapper.
  ///
  /// By default it will just render the story without any changes.
  final PluginStoryBuilder storyBuilder;

  /// Initial data.
  final T? initialData;
}

Widget _default(
  BuildContext context,
  Story story,
  Widget child,
  dynamic data,
) =>
    child;

typedef PluginSettingsBuilder<T> = Widget Function(
  BuildContext context,
  Story? story,
  T? data,
  void Function(T?) update,
);

typedef PluginStoryBuilder<T> = Widget Function(
  BuildContext context,
  Story story,
  Widget child,
  T? data,
);

final Iterable<Plugin> allPlugins = [
  DeviceFramePlugin(),
];
