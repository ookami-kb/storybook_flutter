import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/breakpoint.dart';
import 'package:storybook_flutter/src/story.dart';

class StoryPageWrapper extends StatelessWidget {
  const StoryPageWrapper({Key key, this.path}) : super(key: key);

  bool _shouldDisplayDrawer(BuildContext context) =>
      MediaQuery.of(context).breakpoint == Breakpoint.small;

  final String path;

  @override
  Widget build(BuildContext context) {
    final stories = Provider.of<List<Story>>(context);
    final story = stories.firstWhere(
      (element) => element.path == path,
      orElse: () => null,
    );

    final contents = _Contents(
      onTap: (story) => _onStoryTap(context, story),
      children: stories,
    );

    return Scaffold(
      drawer: _shouldDisplayDrawer(context) ? Drawer(child: contents) : null,
      appBar: AppBar(title: Text(story?.name ?? 'Storybook')),
      body: _shouldDisplayDrawer(context)
          ? _buildStory(context, story)
          : Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(width: 200, child: contents),
                Expanded(child: _buildStory(context, story)),
              ],
            ),
    );
  }

  Widget _buildStory(BuildContext context, Story story) => Container(
        color: Colors.white,
        child: Center(child: story ?? const Text('Select story')),
      );

  void _onStoryTap(BuildContext context, Story story) {
    if (_shouldDisplayDrawer(context)) Navigator.of(context).pop();
    Navigator.pushNamed(context, '/stories/${story.path}');
  }
}

class _Contents extends StatelessWidget {
  const _Contents({
    Key key,
    @required this.onTap,
    @required this.children,
  }) : super(key: key);

  final List<Story> children;
  final void Function(Story) onTap;

  @override
  Widget build(BuildContext context) =>
      ListView(children: children.map(_buildStoryTile).toList());

  Widget _buildStoryTile(Story story) => ListTile(
        title: Text(story.name),
        onTap: () => onTap(story),
      );
}
