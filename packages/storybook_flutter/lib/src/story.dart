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
  /// will create a section `Buttons` with a story `FlatButton` in it.
  final String name;

  /// Optional description of the story.
  ///
  /// It will be used in the contents as a secondary text.
  final String? description;

  /// Story builder.
  final WidgetBuilder builder;

  List<String> get path => name.split(_sectionSeparator);

  String get title => name.split(_sectionSeparator).last;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    return other is Story &&
        other.name == name &&
        other.description == description &&
        const ListEquality<String>().equals(other.path, path) &&
        other.title == title;
  }

  @override
  int get hashCode => Object.hash(
        name,
        description,
        path,
        title,
      );

  @override
  String toString() {
    return 'Story(name: $name, description: $description, path: $path, title: $title)';
  }
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

  Story? get currentStory => _stories.firstWhereOrNull(
        (story) => story.name == _currentStoryName,
      );

  String? get currentStoryName => _currentStoryName;

  set currentStoryName(String? value) {
    _currentStoryName = value;
    notifyListeners();
  }
}

const _sectionSeparator = '/';
