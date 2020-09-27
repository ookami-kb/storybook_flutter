import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/breakpoint.dart';
import 'package:storybook_flutter/src/iterables.dart';
import 'package:storybook_flutter/src/story.dart';
import 'package:storybook_flutter/src/theme_mode_provider.dart';

class StoryPageWrapper extends StatelessWidget {
  const StoryPageWrapper({Key key, this.path}) : super(key: key);

  bool _shouldDisplayDrawer(BuildContext context) =>
      MediaQuery.of(context).breakpoint == Breakpoint.small;

  @override
  Widget build(BuildContext context) {
    final stories = Provider.of<List<Story>>(context);
    final story = stories.firstWhere(
      (element) => element.path == path,
      orElse: () => null,
    );

    final contents = _Contents(
      onTap: (story) => _onStoryTap(context, story),
      current: story,
      children: stories,
    );

    final themeModeProvider = Provider.of<ThemeModeProvider>(context);
    const themeIcon = {
      ThemeMode.system: Icon(Icons.brightness_auto),
      ThemeMode.light: Icon(Icons.brightness_high),
      ThemeMode.dark: Icon(Icons.brightness_3),
    };

    return Scaffold(
      drawer: _shouldDisplayDrawer(context) ? Drawer(child: contents) : null,
      appBar: AppBar(
        title: Text(story?.name ?? 'Storybook'),
        actions: [
          IconButton(
            icon: themeIcon[themeModeProvider.current],
            onPressed: themeModeProvider.toggleThemeMode,
          )
        ],
      ),
      body: _shouldDisplayDrawer(context)
          ? _buildStory(context, story)
          : Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  width: 200,
                  color: Theme.of(context).cardColor,
                  child: contents,
                ),
                Expanded(child: _buildStory(context, story)),
              ],
            ),
    );
  }

  final String path;

  Widget _buildStory(BuildContext context, Story story) =>
      Center(child: story ?? const Text('Select story'));

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
    this.current,
  }) : super(key: key);

  final List<Story> children;
  final Story current;
  final void Function(Story) onTap;

  @override
  Widget build(BuildContext context) {
    final grouped = children.groupBy((s) => s.section);
    final sections = grouped.keys
        .where((k) => k.isNotEmpty)
        .map((k) => _buildSection(k, grouped[k]));
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
