import 'package:collection/collection.dart' show IterableExtension;
import 'package:storybook_flutter/src/story.dart';

class StoryProvider {
  StoryProvider({
    Story? currentStory,
    bool isFullPage = false,
  })  : _currentStory = currentStory,
        _isFullPage = isFullPage;

  factory StoryProvider.fromPath(String? path, List<Story> stories) {
    final storyPath =
        path?.replaceFirst('/stories/', '').replaceFirst('/full', '') ?? '';
    final story =
        stories.firstWhereOrNull((element) => element.path == storyPath);
    final isFullPage = path?.endsWith('/full') == true;
    return StoryProvider(currentStory: story, isFullPage: isFullPage);
  }

  Story? _currentStory;
  bool _isFullPage = false;

  Story? get currentStory => _currentStory;

  bool get isFullPage => _isFullPage;
}
