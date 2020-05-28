import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/route.dart';
import 'package:storybook_flutter/src/story.dart';
import 'package:storybook_flutter/src/story_page_wrapper.dart';

/// A collection of stories.
///
/// It generates Contents in navigation drawer based on stories names.
///
/// This example shows how to create a simple Storybook:
///
/// ```
/// Widget build(BuildContext context) => Storybook(
///     children: [
///       Story(
///         name: 'Flat button',
///         child: MaterialButton(child: Text('Flat button'), onPressed: () {}),
///       ),
///       Story(
///         name: 'Raised button',
///         child: RaisedButton(child: Text('Raised button'), onPressed: () {}),
///       ),
///       Story(
///         name: 'Input field',
///         child: TextField(
///           decoration: InputDecoration(
///             border: OutlineInputBorder(),
///             labelText: 'Input field',
///           ),
///         ),
///       ),
///     ],
///   );
/// ```
class Storybook extends StatelessWidget {
  const Storybook({
    Key key,
    this.children = const [],
    this.theme,
  }) : super(key: key);

  /// Theme override
  final ThemeData theme;

  /// Stories in the storybook.
  final List<Story> children;

  @override
  Widget build(BuildContext context) => Provider.value(
        value: children,
        child: MaterialApp(
          theme: theme ?? Theme.of(context),
          onGenerateRoute: (settings) => StoryRoute(
            settings: settings,
            builder: (_) => StoryPageWrapper(
              path: settings.name.replaceFirst('/stories/', ''),
            ),
          ),
        ),
      );
}
