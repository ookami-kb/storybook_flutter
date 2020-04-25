import 'package:flutter/widgets.dart';
import 'package:recase/recase.dart';

/// Single story (page) in storybook.
///
/// It's better to use it to demonstrate a single widget (e.g. Button).
class Story extends StatelessWidget {
  const Story({
    Key key,
    @required this.name,
    @required Widget child,
  })  : this._child = child,
        super(key: key);

  /// A unique name to identify this story.
  ///
  /// It's used to generate list item in Contents.
  final String name;

  /// Widget to be displayed in the story. It will be centered on the page.
  final Widget _child;

  String get path => ReCase(name).paramCase;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: _child,
        ),
      );
}
