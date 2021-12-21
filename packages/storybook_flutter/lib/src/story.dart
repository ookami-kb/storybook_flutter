import 'package:flutter/widgets.dart';

class Story {
  Story({
    required this.name,
    this.description,
    required this.builder,
  });

  final String name;
  final String? description;
  final WidgetBuilder builder;

  String get section {
    final parts = name.split('/');
    if (parts.length > 1) return parts[0];

    return '';
  }

  String get title {
    final parts = name.split('/');
    if (parts.length > 1) {
      parts.removeAt(0);
      return parts.join('/');
    }

    return name;
  }
}

class StoryNotifier extends ValueNotifier<Story?> {
  StoryNotifier(Story? value) : super(value);
}
