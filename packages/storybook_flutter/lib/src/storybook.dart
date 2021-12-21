import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import 'plugins/plugin.dart';
import 'plugins/plugin_panel.dart';
import 'story.dart';

Widget materialWrapper(BuildContext context, Widget? child) => MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      home: Scaffold(body: Center(child: child)),
    );

Widget cupertinoWrapper(BuildContext context, Widget? child) => CupertinoApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      home: CupertinoPageScaffold(child: Center(child: child)),
    );

final _defaultPlugins = initializePlugins();

class Storybook extends StatefulWidget {
  Storybook({
    Key? key,
    required this.stories,
    List<Plugin>? plugins,
    this.initialStory,
    this.wrapperBuilder = materialWrapper,
    this.showPanel = true,
  })  : plugins = plugins ?? _defaultPlugins,
        super(key: key);

  final List<Plugin> plugins;
  final List<Story> stories;
  final String? initialStory;
  final TransitionBuilder wrapperBuilder;
  final bool showPanel;

  @override
  State<Storybook> createState() => _StorybookState();
}

class _StorybookState extends State<Storybook> {
  final _overlayKey = GlobalKey<OverlayState>();
  final _layerLink = LayerLink();

  @override
  Widget build(BuildContext context) {
    final currentStory = CurrentStory(
      wrapperBuilder: widget.wrapperBuilder,
    );

    return MediaQuery.fromWindow(
      child: Nested(
        children: [
          Provider.value(value: widget.plugins),
          ChangeNotifierProvider(
            create: (_) => StoryNotifier(
              widget.initialStory == null
                  ? null
                  : widget.stories
                      .firstWhere((s) => s.name == widget.initialStory),
            ),
          ),
          ChangeNotifierProvider(
            create: (_) => StoriesNotifier(widget.stories),
          ),
          ...widget.plugins
              .where((p) => p.wrapperBuilder != null)
              .map((p) => SingleChildBuilder(builder: p.wrapperBuilder!))
        ],
        child: widget.showPanel
            ? Stack(
                alignment: Alignment.topCenter,
                children: [
                  Column(
                    children: [
                      Expanded(child: currentStory),
                      RepaintBoundary(
                        child: Material(
                          child: SafeArea(
                            top: false,
                            child: CompositedTransformTarget(
                              link: _layerLink,
                              child: Directionality(
                                textDirection: TextDirection.ltr,
                                child: Container(
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      top: BorderSide(color: Colors.black12),
                                    ),
                                  ),
                                  child: PluginPanel(
                                    plugins: widget.plugins,
                                    overlayKey: _overlayKey,
                                    layerLink: _layerLink,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Overlay(key: _overlayKey),
                  ),
                ],
              )
            : currentStory,
      ),
    );
  }
}

class CurrentStory extends StatelessWidget {
  const CurrentStory({Key? key, required this.wrapperBuilder})
      : super(key: key);

  final TransitionBuilder wrapperBuilder;

  @override
  Widget build(BuildContext context) {
    final story = context.watch<StoryNotifier>().value;
    if (story == null) {
      return const Directionality(
        textDirection: TextDirection.ltr,
        child: Material(child: Center(child: Text('Select story'))),
      );
    }

    final plugins = context.watch<List<Plugin>>();
    final pluginBuilders = plugins
        .where((p) => p.storyBuilder != null)
        .map((p) => SingleChildBuilder(builder: p.storyBuilder!))
        .toList();

    final child = wrapperBuilder(context, Builder(builder: story.builder));

    return pluginBuilders.isEmpty
        ? child
        : Nested(children: pluginBuilders, child: child);
  }
}

class StoriesNotifier extends ValueNotifier<List<Story>> {
  StoriesNotifier(List<Story> value) : super(value);
}
