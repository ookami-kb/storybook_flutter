import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/iterables.dart';
import 'package:storybook_flutter/src/story.dart';
import 'package:storybook_flutter/src/story_router_delegate.dart';

class Contents extends StatelessWidget {
  const Contents({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentStory = context.watch<StoryRouter>().currentPage.maybeWhen(
          story: (s) => s,
          orElse: () => null,
        );

    final StoryTileBuilder buildTile = (s) => ListTile(
          title: Text(s.name),
          onTap: () => context.read<StoryRouter>().openStory(s.name),
          selected: s == currentStory,
        );

    final flatStories = context.watch<Iterable<Story>>();
    final grouped = flatStories.groupBy((s) => s.section);
    final sections =
        grouped.keys.where((k) => k.isNotEmpty).map((k) => ExpansionTile(
              title: Text(k),
              initiallyExpanded: grouped[k].contains(currentStory),
              children: grouped[k].map(buildTile).toList(),
            ));

    final stories = (grouped[''] ?? []).map(buildTile);
    return ListView(children: [...sections, ...stories]);
  }
}

typedef StoryTileBuilder = Widget Function(Story);
