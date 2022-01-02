import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:recase/recase.dart';
import 'package:storybook_flutter/src/control_panel/provider.dart';
import 'package:storybook_flutter/src/knobs/knobs.dart';
import 'package:storybook_flutter/src/plugins/plugin_settings_notifier.dart';
import 'package:storybook_flutter/src/story_provider.dart';
import 'package:storybook_flutter/src/storybook.dart';

/// Single story (page) in storybook.
///
/// It's better to use it to demonstrate a single widget (e.g. Button).
class Story extends StatefulWidget {
  Story({
    Key? key,
    required this.name,
    required StoryBuilder builder,
    this.section = '',
    this.background,
    this.padding = const EdgeInsets.all(16),
    this.wrapperBuilder,
  })  : _builder = builder,
        super(key: key);

  Story.simple({
    Key? key,
    required String name,
    required Widget child,
    String section = '',
    Color? background,
    EdgeInsets padding = const EdgeInsets.all(16),
    StoryWrapperBuilder? wrapperBuilder,
  }) : this(
          key: key,
          name: name,
          background: background,
          padding: padding,
          builder: (_, __) => child,
          section: section,
          wrapperBuilder: wrapperBuilder,
        );

  /// A unique name to identify this story.
  ///
  /// It's used to generate list item in Contents.
  final String name;

  /// Section title.
  ///
  /// Stories will be grouped by sections.
  final String section;

  /// Widget to be displayed in the story. It will be centered on the page.
  final StoryBuilder _builder;

  /// Optional parameter to override story wrapper.
  ///
  /// {@macro storybook_flutter.default_story_wrapper}
  ///
  /// You can also override wrapper for all stories  by using
  /// [Storybook.storyWrapperBuilder].
  final StoryWrapperBuilder? wrapperBuilder;

  /// Background color of the story.
  final Color? background;

  /// Padding of the story.
  final EdgeInsets padding;

  /// key to provide a context to find a render object to export as image
  final GlobalKey screenShotKey = GlobalKey();

  String get path => ReCase(name).paramCase;

  @override
  _StoryState createState() => _StoryState();
}

typedef StoryBuilder = Widget Function(BuildContext context, KnobsBuilder kb);

class _StoryState extends State<Story> {
  @override
  Widget build(BuildContext context) {
    final StoryWrapperBuilder effectiveWrapper = widget.wrapperBuilder ??
        context.watch<StoryWrapperBuilder?>() ??
        _defaultWrapperBuilder;

    Widget child = effectiveWrapper(
      context,
      widget,
      widget._builder(context, context.watch<StoryProvider>()),
    );
    for (final plugin in context.watch<ControlPanelProvider>().plugins) {
      child = plugin.storyBuilder(
        context,
        widget,
        child,
        context
            .watch<PluginSettingsNotifier>()
            .get<dynamic>(plugin.runtimeType),
      );
    }

    return RepaintBoundary(key: widget.screenShotKey, child: child);
  }
}

final StoryWrapperBuilder _defaultWrapperBuilder =
    (_, story, child) => Container(
          color: story.background,
          padding: story.padding,
          child: Center(child: child),
        );
