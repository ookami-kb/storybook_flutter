import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/story.dart';
import 'package:storybook_flutter/src/story_provider.dart';
import 'package:storybook_flutter/src/storybook.dart';

class CustomStorybook extends StatelessWidget {
  const CustomStorybook({
    Key? key,
    required this.children,
    this.storyWrapperBuilder,
    required this.builder,
  }) : super(key: key);

  final List<Story> children;
  final StoryWrapperBuilder? storyWrapperBuilder;
  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider.value(value: children),
          Provider<StoryWrapperBuilder?>.value(value: storyWrapperBuilder),
          ChangeNotifierProvider(create: (_) => StoryProvider()),
        ],
        child: builder(context),
      );
}
