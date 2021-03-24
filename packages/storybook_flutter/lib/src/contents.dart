import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/story.dart';
import 'package:storybook_flutter/src/story_provider.dart';

class Contents extends StatefulWidget {
  const Contents({Key? key}) : super(key: key);

  @override
  _ContentsState createState() => _ContentsState();
}

class _ContentsState extends State<Contents> {
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
