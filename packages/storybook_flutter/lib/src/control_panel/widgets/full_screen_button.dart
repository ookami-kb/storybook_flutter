import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/story_provider.dart';

class FullScreenButton extends StatelessWidget {
  const FullScreenButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => IconButton(
        icon: const Icon(Icons.open_in_new),
        onPressed: () {
          final story = context.read<StoryProvider>().currentStory;
          if (story == null) return;

          Navigator.pushNamed(context, '/stories/${story.path}/full');
        },
      );
}
