import 'package:flutter/widgets.dart';

class StoryRoute extends PopupRoute<void> {
  StoryRoute({
    @required this.builder,
    RouteSettings settings,
  }) : super(settings: settings);

  final WidgetBuilder builder;

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => false;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) =>
      builder(context);

  @override
  Duration get transitionDuration => const Duration();
}
