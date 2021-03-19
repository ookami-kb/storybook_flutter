import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/breakpoint.dart';
import 'package:storybook_flutter/src/story.dart';

enum StoryMode { normal, fullScreen }

class StoryPageWrapper extends StatelessWidget {
  const StoryPageWrapper({Key? key, this.path}) : super(key: key);

  final String? path;

  bool _shouldDisplayDrawer(BuildContext context) =>
      MediaQuery.of(context).breakpoint == Breakpoint.small;

  @override
  Widget build(BuildContext context) {
    final stories = Provider.of<List<Story>>(context);
    final storyPath = path?.split('/') ?? [];
    final story = stories.firstWhereOrNull(
      (element) => element.path == storyPath.firstOrNull,
    );
    final isFullPage = storyPath.length > 1 && storyPath[1] == 'full';

    if (isFullPage) {
      return Provider.value(
        value: StoryMode.fullScreen,
        child: Builder(
          builder: (context) => Scaffold(body: _buildStory(context, story)),
        ),
      );
    }

    return MultiProvider(
      providers: [
        Provider.value(value: story),
      ],
      builder: (context, _) {
        final contents = _Contents(
          onTap: (story) => _onStoryTap(context, story),
          current: story,
          children: stories,
        );

        return Hero(
          tag: 'StoryPageWrapper',
          child: Scaffold(
            drawer:
                _shouldDisplayDrawer(context) ? Drawer(child: contents) : null,
            appBar: AppBar(title: Text(story?.name ?? 'Storybook')),
            body: Provider.value(
              value: StoryMode.normal,
              child: _shouldDisplayDrawer(context)
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
                          child: ListTileTheme(
                            style: ListTileStyle.drawer,
                            child: contents,
                          ),
                        ),
                        Expanded(child: _buildStory(context, story)),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStory(BuildContext context, Story? story) =>
      story ?? const Center(child: Text('Select story'));

  void _onStoryTap(BuildContext context, Story story) {
    if (_shouldDisplayDrawer(context)) Navigator.of(context).pop();
    Navigator.pushReplacementNamed(context, '/stories/${story.path}');
  }
}

class _Contents extends StatelessWidget {
  const _Contents({
    Key? key,
    required this.onTap,
    required this.children,
    this.current,
  }) : super(key: key);

  final List<Story> children;
  final Story? current;
  final void Function(Story) onTap;

  @override
  Widget build(BuildContext context) {
    final grouped = children.groupListsBy((s) => s.section);
    final sections = grouped.keys
        .where((k) => k.isNotEmpty)
        .map((k) => _buildSection(k, grouped[k]!));
    final stories = (grouped[''] ?? []).map(_buildStoryTile);
    return ListView(children: [...sections, ...stories]);
  }

  Widget _buildStoryTile(Story story) => ListTile(
        title: Text(story.name),
        onTap: () => onTap(story),
        selected: story == current,
      );

  Widget _buildSection(String title, Iterable<Story> stories) => ExpansionTile(
        title: Text(title),
        initiallyExpanded: stories.contains(current),
        children: stories.map(_buildStoryTile).toList(),
      );
}
