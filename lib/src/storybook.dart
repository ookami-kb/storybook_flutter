import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:storybook_flutter/src/homescreen.dart';
import 'package:storybook_flutter/src/story.dart';

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
  Storybook({Key key, this.children = const []}) : super(key: key);

  /// Stories in the storybook.
  final List<Story> children;

  @override
  Widget build(BuildContext context) => MaterialApp(
        onGenerateRoute: (settings) => MaterialPageRoute(
          settings: settings,
          maintainState: false,
          builder: (context) =>
              HomeScreen(children: children, settings: settings),
        ),
      );
}
