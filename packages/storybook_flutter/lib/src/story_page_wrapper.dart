import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/contents.dart';
import 'package:storybook_flutter/src/control_panel/widgets/control_panel.dart';
import 'package:storybook_flutter/src/current_story.dart';
import 'package:storybook_flutter/src/story_provider.dart';

class StoryPageWrapper extends StatelessWidget {
  const StoryPageWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          final data = context.watch<StoryProvider>();
          final story = data.currentStory;
          final isFullPage = data.isFullPage;

          if (isFullPage) return const Scaffold(body: CurrentStory());

          final shouldDisplayDrawer = constraints.maxWidth < 800;
          final direction =
              shouldDisplayDrawer ? Axis.vertical : Axis.horizontal;

          final children = [
            const Expanded(child: CurrentStory()),
            if (!isFullPage) ControlPanel(direction: direction),
          ];
          final theme = Theme.of(context);

          return Scaffold(
            drawer: shouldDisplayDrawer
                ? const Drawer(child: NavigatorContents())
                : null,
            appBar: AppBar(title: Text(story?.name ?? 'Storybook')),
            body: Flex(
              direction: direction,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                if (!shouldDisplayDrawer)
                  Container(
                    decoration: BoxDecoration(
                      border:
                          Border(right: BorderSide(color: theme.dividerColor)),
                      color: theme.cardColor,
                    ),
                    width: 256,
                    child: const NavigatorContents(),
                  ),
                ...children,
              ],
            ),
          );
        },
      );
}
