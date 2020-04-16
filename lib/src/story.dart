import 'package:flutter/widgets.dart';
import 'package:recase/recase.dart';

class Story extends StatelessWidget {
  const Story({
    Key key,
    @required this.name,
    @required this.child,
  }) : super(key: key);

  final String name;
  final Widget child;

  String get path => ReCase(name).paramCase;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: child,
        ),
      );
}
