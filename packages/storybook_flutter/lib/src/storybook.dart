import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import 'plugin.dart';
import 'plugin_panel.dart';
import 'plugins/contents.dart';
import 'plugins/device_frame.dart';
import 'plugins/knobs.dart';
import 'plugins/theme_mode.dart';
import 'story.dart';

Widget _materialWrapper(BuildContext context, Widget? child) => MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      home: Scaffold(
        body: Center(child: child),
      ),
    );

class Storybook extends StatefulWidget {
  const Storybook({
    Key? key,
    required this.stories,
    this.plugins = const [
      contentsPlugin,
      knobsPlugin,
      themeModePlugin,
      deviceFramePlugin,
    ],
    this.initialStory,
    this.wrapperBuilder = _materialWrapper,
  }) : super(key: key);

  final List<Plugin> plugins;
  final List<Story> stories;
  final String? initialStory;
  final TransitionBuilder wrapperBuilder;

  @override
  State<Storybook> createState() => _StorybookState();
}

class _StorybookState extends State<Storybook> {
  final _overlayKey = GlobalKey<OverlayState>();
  final _layerLink = LayerLink();

  @override
  Widget build(BuildContext context) => MediaQuery.fromWindow(
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
          child: Builder(
            builder: (context) => Stack(
              alignment: Alignment.topCenter,
              children: [
                Column(
                  children: [
                    Expanded(
                      child: CurrentStory(
                        wrapperBuilder: widget.wrapperBuilder,
                      ),
                    ),
                    Container(
                      color: Colors.red,
                      child: SafeArea(
                        top: false,
                        child: SizedBox(
                          height: 50,
                          child: CompositedTransformTarget(
                            link: _layerLink,
                            child: MaterialApp(
                              useInheritedMediaQuery: true,
                              debugShowCheckedModeBanner: false,
                              theme: ThemeData.light(),
                              darkTheme: ThemeData.dark(),
                              home: Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Material(
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
                    ),
                  ],
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Overlay(key: _overlayKey),
                ),
              ],
            ),
          ),
        ),
      );
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
