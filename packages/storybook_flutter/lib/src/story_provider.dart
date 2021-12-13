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
    _knobs.clear();
    notifyListeners();
  }

  final Map<String, Knob> _knobs = <String, Knob>{};

  T _addKnob<T>(Knob<T> value) =>
      (_knobs.putIfAbsent(value.label, () => value) as Knob<T>).value;

  void update<T>(String label, T value) {
    _knobs[label]!.value = value;
    notifyListeners();
  }

  T get<T>(String label) => _knobs[label]!.value as T;

  List<Knob> all() => _knobs.values.toList();

  @override
  bool boolean({
    required String label,
    String? description,
    bool initial = false,
  }) =>
      _addKnob(
        BoolKnob(
          label: label,
          description: description,
          value: initial,
        ),
      );

  @override
  String text({
    required String label,
    String? description,
    String initial = '',
  }) =>
      _addKnob(
        StringKnob(
          label: label,
          description: description,
          value: initial,
        ),
      );

  @override
  T options<T>({
    required String label,
    String? description,
    required T initial,
    List<Option<T>> options = const [],
  }) =>
      _addKnob(
        SelectKnob(
          label: label,
          description: description,
          value: initial,
          options: options,
        ),
      );

  @override
  double slider({
    required String label,
    String? description,
    double initial = 0,
    double max = 1,
    double min = 0,
  }) =>
      _addKnob(
        SliderKnob(
          label: label,
          description: description,
          value: initial,
          max: max,
          min: min,
        ),
      );

  @override
  int sliderInt({
    required String label,
    String? description,
    int initial = 0,
    int max = 100,
    int min = 0,
    int divisions = 100,
  }) =>
      _addKnob(
        SliderKnob(
          label: label,
          description: description,
          value: initial.toDouble(),
          max: max.toDouble(),
          min: min.toDouble(),
          divisions: divisions,
          formatValue: (v) => v.toInt().toString(),
        ),
      ).toInt();
}
