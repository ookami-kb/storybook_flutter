import 'package:flutter/widgets.dart';

class Story {
  Story({
    required this.name,
    this.section,
    required this.builder,
  });

  final String name;
  final String? section;
  final WidgetBuilder builder;
}

class StoryNotifier extends ValueNotifier<Story?> {
  StoryNotifier(Story? value) : super(value);
}
