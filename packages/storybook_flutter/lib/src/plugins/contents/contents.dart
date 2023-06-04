import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/plugins/contents/search_text_field.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

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

Widget _buildPanel(BuildContext _) => const _Contents();

Widget _buildWrapper(BuildContext _, Widget? child) => Localizations(
      delegates: const [
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      locale: const Locale('en', 'US'),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          children: [
            Material(
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  border: Border(right: BorderSide(color: Colors.black12)),
                ),
                child: SizedBox(
                  width: 250,
                  child: Navigator(
                    onGenerateRoute: (_) => PageRouteBuilder<void>(
                      pageBuilder: (_, __, ___) => const _Contents(),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ClipRect(clipBehavior: Clip.hardEdge, child: child),
            ),
          ],
        ),
      ),
    );

class _Contents extends StatefulWidget {
  const _Contents();

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
        initiallyExpanded:
            context.watch<StoryNotifier>().searchTerm.isNotEmpty ||
                stories
                    .map((s) => s.name)
                    .contains(context.watch<StoryNotifier>().currentStoryName),
        childrenPadding: childrenPadding,
        children: children,
      );

  Widget _buildStoryTile(Story story) {
    final description = story.description;

    return ListTile(
      selected: story == context.watch<StoryNotifier>().currentStory,
      title: Text(story.title),
      subtitle: description == null ? null : Text(description),
      onTap: () {
        context.read<StoryNotifier>().currentStoryName = story.name;
        context.read<OverlayController?>()?.remove();
      },
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

    return stories.length == sectionStories.length
        ? sectionStories
        : [
            ...grouped.keys.where((k) => k.isNotEmpty).map(
                  (k) => _buildExpansionTile(
                    title: k,
                    childrenPadding:
                        EdgeInsets.only(left: (depth - 1) * _sectionPadding),
                    stories: grouped[k]!,
                    children: _buildListChildren(grouped[k]!, depth: depth + 1),
                  ),
                ),
            ...sectionStories
          ];
  }

  @override
  Widget build(BuildContext context) {
    final children = _buildListChildren(context.watch<StoryNotifier>().stories);
    final searchTerm = context.watch<StoryNotifier>().searchTerm;

    return SafeArea(
      // If there is no overlay, we're in the side panel, so we don't need to
      // add the top padding.
      top: context.watch<OverlayController?>() == null,
      right: false,
      child: Column(
        children: [
          const SearchTextField(),
          Expanded(
            key: ValueKey(searchTerm),
            child: children.isEmpty && searchTerm.isNotEmpty
                ? const Center(child: Text('Nothing found'))
                : ListTileTheme(
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
