import 'package:flutter/widgets.dart';

class Story {
  Story({
    required this.name,
    this.description,
    required this.builder,
  });

  /// Unique name of the story.
  ///
  /// Use `/` to group stories in sections, e.g. `Buttons/FlatButton`
  /// will create a section `Buttons` with a story `FlatButton` in it.
  final String name;

  /// Optional description of the story.
  ///
  /// It will be used in the contents as a secondary text.
  final String? description;

  /// Story builder.
  final WidgetBuilder builder;

  String get section {
    final parts = name.split(_sectionSeparator);
    if (parts.length > 1) return parts[0];

    return '';
  }

  String get title {
    final parts = name.split(_sectionSeparator);
    if (parts.length > 1) {
      parts.removeAt(0);
      return parts.join(_sectionSeparator);
    }

    return name;
  }
}

/// Use this notifier to get the current story.
class StoryNotifier extends ValueNotifier<Story?> {
  StoryNotifier(Story? value) : super(value);
}

const _sectionSeparator = '/';
