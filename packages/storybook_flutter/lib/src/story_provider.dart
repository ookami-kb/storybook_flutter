import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/foundation.dart';
import 'package:storybook_flutter/src/knobs/bool_knob.dart';
import 'package:storybook_flutter/src/knobs/knobs.dart';
import 'package:storybook_flutter/src/knobs/select_knob.dart';
import 'package:storybook_flutter/src/knobs/slider_knob.dart';
import 'package:storybook_flutter/src/knobs/string_knob.dart';
import 'package:storybook_flutter/src/story.dart';

class StoryProvider extends ChangeNotifier implements KnobsBuilder {
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

  void updateStory(Story? story) {
    _currentStory = story;
    notifyListeners();
  }

  final Map<String, Knob> _knobs = <String, Knob>{};

  @override
  bool boolean({required String label, bool initial = false}) =>
      _addKnob(BoolKnob(label, initial));

  @override
  String text({required String label, String initial = ''}) =>
      _addKnob(StringKnob(label, initial));

  @override
  T options<T>({
    required String label,
    required T initial,
    List<Option<T>> options = const [],
  }) =>
      _addKnob(SelectKnob(label, initial, options));

  T _addKnob<T>(Knob<T> value) =>
      (_knobs.putIfAbsent(value.label, () => value) as Knob<T>).value;

  void update<T>(String label, T value) {
    _knobs[label]!.value = value;
    notifyListeners();
  }

  T get<T>(String label) => _knobs[label]!.value as T;

  List<Knob> all() => _knobs.values.toList();

  @override
  double slider({
    required String label,
    double initial = 0,
    double max = 1,
    double min = 0,
  }) =>
      _addKnob(SliderKnob(label, value: initial, max: max, min: min));
}
