import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/breakpoint.dart';
import 'package:storybook_flutter/src/contents.dart';
import 'package:storybook_flutter/src/control_panel/widgets/control_panel.dart';
import 'package:storybook_flutter/src/current_story.dart';
import 'package:storybook_flutter/src/story_provider.dart';

class StoryPageWrapper extends StatelessWidget {
  const StoryPageWrapper({Key? key}) : super(key: key);

  bool _shouldDisplayDrawer(BuildContext context) =>
      MediaQuery.of(context).breakpoint == Breakpoint.small;

  @override
  Widget build(BuildContext context) {
    final data = context.watch<StoryProvider>();
    final story = data.currentStory;
    final isFullPage = data.isFullPage;

    if (isFullPage) {
      return const Scaffold(body: CurrentStory());
    }

    return Scaffold(
      drawer: _shouldDisplayDrawer(context)
          ? const Drawer(child: NavigatorContents())
          : null,
      appBar: AppBar(title: Text(story?.name ?? 'Storybook')),
      body: _shouldDisplayDrawer(context)
          ? const CurrentStory()
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
                  child: const NavigatorContents(),
                ),
                const Expanded(child: CurrentStory()),
                if (!isFullPage) const ControlPanel(),
              ],
            ),
    );
  }
}
