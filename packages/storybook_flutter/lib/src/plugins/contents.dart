import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../plugin.dart';
import '../story.dart';
import '../storybook.dart';

const contentsPlugin = Plugin(
  panelBuilder: _buildPanel,
  icon: _buildIcon,
);

Widget _buildIcon(BuildContext _) => const Icon(Icons.list);

Widget _buildPanel(BuildContext context) => const Contents();

class Contents extends StatelessWidget {
  const Contents({
    Key? key,
    this.onStorySelected,
  }) : super(key: key);

  final ValueSetter<Story>? onStorySelected;

  @override
  Widget build(BuildContext context) => _Contents(
        onStorySelected: (story) {
          context.read<StoryNotifier>().value = story;
          onStorySelected?.call(story);
        },
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
    final grouped =
        context.watch<StoriesNotifier>().value.groupListsBy((s) => s.section);
    final sections = grouped.keys
        .where((k) => k.isNotEmpty)
        .map((k) => _buildSection(k, grouped[k]!));
    final stories = (grouped[''] ?? []).map(_buildStoryTile);
    return ListTileTheme(
      style: ListTileStyle.drawer,
      child: ListView(
        padding: EdgeInsets.zero,
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
        selected: story == context.watch<StoryNotifier>().value,
      );

  Widget _buildSection(String title, Iterable<Story> stories) => ExpansionTile(
        title: Text(title),
        initiallyExpanded:
            stories.contains(context.watch<StoryNotifier>().value),
        children: stories.map(_buildStoryTile).toList(),
      );
}
