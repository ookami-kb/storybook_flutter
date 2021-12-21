import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../story.dart';
import '../storybook.dart';
import 'plugin.dart';

class ContentsPlugin extends Plugin {
  const ContentsPlugin({bool sidePanel = false})
      : super(
          icon: sidePanel ? null : _buildIcon,
          panelBuilder: sidePanel ? null : _buildPanel,
          wrapperBuilder: sidePanel ? _buildWrapper : null,
        );
}

Widget _buildIcon(BuildContext _) => const Icon(Icons.list);

Widget _buildPanel(BuildContext context) => const Contents();

Widget _buildWrapper(BuildContext context, Widget? child) => Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        children: [
          Material(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(color: Colors.black12),
                ),
              ),
              child: const SizedBox(width: 250, child: Contents()),
            ),
          ),
          Expanded(
            child: ClipRect(clipBehavior: Clip.hardEdge, child: child!),
          ),
        ],
      ),
    );

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

    return SafeArea(
      right: false,
      child: ListTileTheme(
        style: ListTileStyle.drawer,
        child: ListView(
          padding: EdgeInsets.zero,
          primary: false,
          children: [...sections, ...stories],
        ),
      ),
    );
  }

  Widget _buildStoryTile(Story story) => ListTile(
        selected: story == context.watch<StoryNotifier>().value,
        title: Text(story.title),
        subtitle: story.description == null ? null : Text(story.description!),
        onTap: () {
          final onStorySelected = widget.onStorySelected;
          onStorySelected(story);
        },
      );

  Widget _buildSection(String title, Iterable<Story> stories) => ExpansionTile(
        title: Text(title),
        initiallyExpanded:
            stories.contains(context.watch<StoryNotifier>().value),
        children: stories.map(_buildStoryTile).toList(),
      );
}
