import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:recase/recase.dart';
import 'package:storybook_flutter/src/knobs/knob_panel.dart';
import 'package:storybook_flutter/src/knobs/knobs.dart';

/// Single story (page) in storybook.
///
/// It's better to use it to demonstrate a single widget (e.g. Button).
class Story extends StatefulWidget {
  const Story({
    Key key,
    @required this.name,
    @required StoryBuilder builder,
  })  : _builder = builder,
        super(key: key);

  Story.simple({
    Key key,
    @required String name,
    @required Widget child,
  }) : this(key: key, name: name, builder: (_, __) => child);

  /// A unique name to identify this story.
  ///
  /// It's used to generate list item in Contents.
  final String name;

  /// Widget to be displayed in the story. It will be centered on the page.
  final StoryBuilder _builder;

  String get path => ReCase(name).paramCase;

  @override
  _StoryState createState() => _StoryState();
}

typedef StoryBuilder = Widget Function(BuildContext context, KnobsBuilder kb);

class _StoryState extends State<Story> {
  final Knobs _knobs = Knobs();

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider.value(
        value: _knobs,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Builder(
                    builder: (_) => Consumer<Knobs>(
                      builder: (context, _, __) =>
                          widget._builder(context, _knobs),
                    ),
                  ),
                ),
              ),
            ),
            const KnobPanel(),
          ],
        ),
      );
}
