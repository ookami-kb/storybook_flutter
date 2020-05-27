import 'package:flutter/material.dart';
import 'package:storybook_flutter/src/breakpoint.dart';
import 'package:storybook_flutter/src/story.dart';

final _scaffoldKey = GlobalKey();

class StoryPage extends StatelessWidget {
  const StoryPage({Key key, this.story, this.stories}) : super(key: key);

  bool _shouldDisplayDrawer(BuildContext context) =>
      MediaQuery.of(context).breakpoint == Breakpoint.small;

  final Story story;
  final List<Story> stories;

  @override
  Widget build(BuildContext context) => Scaffold(
//        key: _scaffoldKey,
        drawer: _shouldDisplayDrawer(context)
            ? Drawer(child: _buildContents(context))
            : null,
        appBar: AppBar(
          title: Text(story?.name ?? 'Storybook'),
        ),
        body: _shouldDisplayDrawer(context)
            ? _buildStory(context, story)
            : Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(width: 200, child: _buildContents(context)),
                  Expanded(child: _buildStory(context, story)),
                ],
              ),
      );

  _Contents _buildContents(BuildContext context) => _Contents(
        onTap: (story) => _onStoryTap(context, story),
        children: stories,
      );

  Widget _buildStory(BuildContext context, Story story) => Container(
        color: Colors.white,
        child: Center(child: story ?? const Text('Select story')),
      );

  void _onStoryTap(BuildContext context, Story story) {
    if (_shouldDisplayDrawer(context)) Navigator.of(context).pop();
    Navigator.pushReplacementNamed(context, '/stories/${story.path}');
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
