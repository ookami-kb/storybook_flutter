import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/plugins/contents/search_story_notifier.dart';
import 'package:storybook_flutter/src/story.dart';

class SearchStoryNotifierProvider extends StatelessWidget {
  const SearchStoryNotifierProvider({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (_) =>
            SearchStoryNotifier(stories: context.read<StoryNotifier>().stories),
        child: child,
      );
}
