import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';

@immutable
class Story {
  const Story({
    required this.name,
    this.description,
    required this.builder,
  });

  /// Unique name of the story.
  ///
  /// Use `/` to group stories in sections, e.g. `Buttons/FlatButton`
  /// will create a section `Buttons` with a story `FlatButton` in it. You can
  /// use 2 level of nesting, e.g. 'General/Buttons/FlatButton'. The last part
  /// after '/' will be used as a name for the section.
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

  String get subsection {
    final parts = name.split(_sectionSeparator);
    if (parts.length > 2) return parts[1];

    return '';
  }

  String get title => name.split(_sectionSeparator).last;
}

/// Use this notifier to get the current story.
class StoryNotifier extends ChangeNotifier {
  StoryNotifier(List<Story> stories, {String? initial})
      : _stories = stories.toList(),
        _currentStoryName = initial;

  List<Story> _stories;

  set stories(List<Story> value) {
    _stories = value.toList(growable: false);
    notifyListeners();
  }

  List<Story> get stories => UnmodifiableListView(_stories);

  String? _currentStoryName;

  Story? get currentStory {
    final index = _stories.indexWhere((s) => s.name == _currentStoryName);
    return index != -1 ? _stories[index] : null;
  }

  String? get currentStoryName => _currentStoryName;

  set currentStoryName(String? value) {
    _currentStoryName = value;
    notifyListeners();
  }
}

const _sectionSeparator = '/';
