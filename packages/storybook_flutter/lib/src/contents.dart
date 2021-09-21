import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/story.dart';
import 'package:storybook_flutter/src/story_provider.dart';

class Contents extends StatelessWidget {
  const Contents({
    Key? key,
    this.onStorySelected,
  }) : super(key: key);

  final ValueSetter<Story>? onStorySelected;

  @override
  Widget build(BuildContext context) => _Contents(
        onStorySelected: (story) {
          context.read<StoryProvider>().updateStory(story);
          onStorySelected?.call(story);
        },
      );
}

class NavigatorContents extends StatelessWidget {
  const NavigatorContents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => _Contents(
        onStorySelected: (story) => Navigator.of(context, rootNavigator: true)
            .pushReplacementNamed('/stories/${story.path}'),
      );
}

class _Contents extends StatefulWidget {
  const _Contents({Key? key, required this.onStorySelected}) : super(key: key);

  final ValueSetter<Story> onStorySelected;

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
      child: ListView(
        primary: false,
        children: [...sections, ...stories],
      ),
    );
  }

  Widget _buildStoryTile(Story story) => ListTile(
        title: Text(story.name),
        onTap: () {
          final onStorySelected = widget.onStorySelected;
          onStorySelected(story);
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
