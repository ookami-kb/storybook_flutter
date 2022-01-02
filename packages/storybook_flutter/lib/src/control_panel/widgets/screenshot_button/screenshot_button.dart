import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/story_provider.dart';

class ScreenShotButton extends StatelessWidget {
  const ScreenShotButton({Key? key}) : super(key: key);

  Future<void> _print(BuildContext context) async {
    final story = context.read<StoryProvider>().currentStory;
    if (story == null) return;
    print('Should capture Story as Image and save it');
  }


  @override
  Widget build(BuildContext context) => IconButton(
    onPressed: () => _print(context),
    icon: const Icon(Icons.fit_screen_outlined),
  );
}
