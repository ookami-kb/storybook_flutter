import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/breakpoint.dart';
import 'package:storybook_flutter/src/story.dart';
import 'package:storybook_flutter/src/story_provider.dart';

class StoryPageWrapper extends StatelessWidget {
  const StoryPageWrapper({Key? key}) : super(key: key);

  bool _shouldDisplayDrawer(BuildContext context) =>
      MediaQuery.of(context).breakpoint == Breakpoint.small;

  @override
  Widget build(BuildContext context) {
    final data = context.watch<StoryProvider>();
    final story = data.currentStory;
    final isFullPage = data.isFullPage;

    if (isFullPage) {
      return Scaffold(body: _buildStory(context, story));
    }

    return Scaffold(
      drawer: _shouldDisplayDrawer(context)
          ? const Drawer(child: _Contents())
          : null,
      appBar: AppBar(title: Text(story?.name ?? 'Storybook')),
      body: _shouldDisplayDrawer(context)
          ? _buildStory(context, story)
          : Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                    color: Theme.of(context).cardColor,
                  ),
                  width: 200,
                  child: const _Contents(),
                ),
                Expanded(child: _buildStory(context, story)),
              ],
            ),
    );
  }

  Widget _buildStory(BuildContext context, Story? story) =>
      story ?? const Center(child: Text('Select story'));

  void _onStoryTap(BuildContext context, Story story) {
    if (_shouldDisplayDrawer(context)) Navigator.of(context).pop();
    Navigator.pushReplacementNamed(context, '/stories/${story.path}');
  }
}

class _Contents extends StatefulWidget {
  const _Contents({Key? key}) : super(key: key);

  @override
  _ContentsState createState() => _ContentsState();
}

class _ContentsState extends State<_Contents> {
  @override
  Widget build(BuildContext context) {
    final grouped = context.watch<List<Story>>().groupListsBy((s) => s.section);
    final sections = grouped.keys
        .where((k) => k.isNotEmpty)
        .map((k) => _buildSection(k, grouped[k]!));
    final stories = (grouped[''] ?? []).map(_buildStoryTile);
    return ListTileTheme(
      style: ListTileStyle.drawer,
      child: ListView(children: [...sections, ...stories]),
    );
  }

  Widget _buildStoryTile(Story story) => ListTile(
        title: Text(story.name),
        onTap: () {
          Navigator.pushReplacementNamed(context, '/stories/${story.path}');
        },
        selected: story == context.watch<StoryProvider>().currentStory,
      );

  Widget _buildSection(String title, Iterable<Story> stories) => ExpansionTile(
        title: Text(title),
        initiallyExpanded:
            stories.contains(context.watch<StoryProvider>().currentStory),
        children: stories.map(_buildStoryTile).toList(),
      );
}
