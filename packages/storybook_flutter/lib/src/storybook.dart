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
      home: Scaffold(
        body: Center(child: child),
      ),
    );

class Storybook extends StatelessWidget {
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
  Widget build(BuildContext context) => MediaQuery.fromWindow(
        child: Nested(
          children: [
            Provider.value(value: plugins),
            ChangeNotifierProvider(
              create: (_) => StoryNotifier(
                initialStory == null
                    ? null
                    : stories.firstWhere((s) => s.name == initialStory),
              ),
            ),
            ChangeNotifierProvider(
              create: (_) => StoriesNotifier(stories),
            ),
            ...plugins
                .where((p) => p.wrapperBuilder != null)
                .map((p) => SingleChildBuilder(builder: p.wrapperBuilder!))
          ],
          child: Builder(
            builder: (context) => Stack(
              alignment: Alignment.topCenter,
              children: [
                MaterialApp(
                  useInheritedMediaQuery: true,
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData.light(),
                  darkTheme: ThemeData.dark(),
                  home: Column(
                    children: [
                      const Spacer(),
                      Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Colors.black, width: 1),
                          ),
                        ),
                        height: 50,
                        width: double.infinity,
                        child: Material(
                          child: PluginPanel(plugins: plugins),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 50,
                  child: CurrentStory(wrapperBuilder: wrapperBuilder),
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Overlay(key: overlayKey),
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
