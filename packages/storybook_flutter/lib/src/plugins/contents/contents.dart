import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/plugins/contents/search_story_notifier.dart';
import 'package:storybook_flutter/src/plugins/contents/search_story_notifier_provider.dart';
import 'package:storybook_flutter/src/plugins/contents/search_text_field.dart';
import 'package:storybook_flutter/src/plugins/plugin.dart';
import 'package:storybook_flutter/src/story.dart';

/// Plugin that adds content as expandable list of stories.
///
/// If `sidePanel` is true, the stories are shown in a left side panel,
/// otherwise as a popup.
class ContentsPlugin extends Plugin {
  const ContentsPlugin({bool sidePanel = false})
      : super(
          icon: sidePanel ? null : _buildIcon,
          panelBuilder: sidePanel ? null : _buildPanel,
          wrapperBuilder: sidePanel ? _buildWrapper : null,
        );
}

Widget _buildIcon(BuildContext _) => const Icon(Icons.list);

Widget _buildPanel(BuildContext _) =>
    const SearchStoryNotifierProvider(child: _Contents());

Widget _buildWrapper(BuildContext _, Widget? child) => MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Row(
        children: [
          const Material(
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border(right: BorderSide(color: Colors.black12)),
              ),
              child: SizedBox(
                width: 250,
                child: SearchStoryNotifierProvider(child: _Contents()),
              ),
            ),
          ),
          Expanded(child: ClipRect(clipBehavior: Clip.hardEdge, child: child)),
        ],
      ),
    );

class _Contents extends StatefulWidget {
  const _Contents({Key? key}) : super(key: key);

  @override
  _ContentsState createState() => _ContentsState();
}

class _ContentsState extends State<_Contents> {
  Widget _buildExpansionTile({
    required String title,
    required Iterable<Story> stories,
    required List<Widget> children,
    EdgeInsetsGeometry? childrenPadding,
  }) =>
      ExpansionTile(
        title: Text(title),
        initiallyExpanded: stories
            .map((s) => s.name)
            .contains(context.watch<StoryNotifier>().currentStoryName),
        childrenPadding: childrenPadding,
        children: children,
      );

  Widget _buildStoryTile(Story story) {
    final description = story.description;
    final current = context.watch<StoryNotifier>().currentStory;

    return ListTile(
      selected: story == current,
      title: Text(story.title),
      subtitle: description == null ? null : Text(description),
      onTap: () => context.read<StoryNotifier>().currentStoryName = story.name,
    );
  }

  List<Widget> _buildListChildren(
    List<Story> stories, {
    int depth = 1,
  }) {
    final grouped = stories.groupListsBy(
      (story) => story.path.length == depth ? '' : story.path[depth - 1],
    );

    final sectionStories = (grouped[''] ?? []).map(_buildStoryTile).toList();

    if (stories.length == sectionStories.length) {
      return sectionStories;
    }

    return [
      ...grouped.keys
          .where((k) => k.isNotEmpty)
          .map(
            (k) => _buildExpansionTile(
              title: k,
              childrenPadding:
                  EdgeInsets.only(left: (depth - 1) * _sectionPadding),
              stories: grouped[k]!,
              children: _buildListChildren(grouped[k]!, depth: depth + 1),
            ),
          )
          .toList(),
      ...sectionStories
    ];
  }

  @override
  Widget build(BuildContext context) {
    context.watch<StoryNotifier>();
    final children = _buildListChildren(
        context.watch<SearchStoryNotifier>().searchedStories);

    return SafeArea(
      top: false,
      right: false,
      child: Column(
        children: [
          const SearchTextField(),
          Expanded(
            child: ListTileTheme(
              style: ListTileStyle.drawer,
              child: ListView(
                padding: EdgeInsets.zero,
                primary: false,
                children: children,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const double _sectionPadding = 8;
