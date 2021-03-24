import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/story_provider.dart';

class CurrentStory extends StatelessWidget {
  const CurrentStory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final story = context.watch<StoryProvider>().currentStory;

    return story ?? const Center(child: Text('Select story'));
  }
}
