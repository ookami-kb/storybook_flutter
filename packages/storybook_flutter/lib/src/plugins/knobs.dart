import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../knobs/bool_knob.dart';
import '../knobs/knobs.dart';
import '../knobs/select_knob.dart';
import '../knobs/slider_knob.dart';
import '../knobs/string_knob.dart';
import 'plugin.dart';
import '../story.dart';

const knobsPlugin = Plugin(
  icon: _buildIcon,
  panelBuilder: _buildPanel,
  wrapperBuilder: _buildWrapper,
);

Widget _buildIcon(BuildContext context) => const Icon(Icons.settings);

Widget _buildPanel(BuildContext context) => Consumer<KnobsNotifier>(
      builder: (context, knobs, _) {
        final items = knobs.all();

        return items.isEmpty
            ? const Center(child: Text('No knobs'))
            : ListView.separated(
                primary: false,
                padding: const EdgeInsets.symmetric(vertical: 8),
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemCount: items.length,
                itemBuilder: (context, index) => items[index].build(),
              );
      },
    );

Widget _buildWrapper(BuildContext context, Widget? child) =>
    ChangeNotifierProvider(
      create: (context) => KnobsNotifier(context.read<StoryNotifier>()),
      child: child,
    );

extension Knobs on BuildContext {
  KnobsBuilder get knobs => watch<KnobsNotifier>();
}

class KnobsNotifier extends ChangeNotifier implements KnobsBuilder {
  KnobsNotifier(this._storyNotifier);

  final StoryNotifier _storyNotifier;
  final Map<String, Map<String, Knob>> _knobs = <String, Map<String, Knob>>{};

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

  T _addKnob<T>(Knob<T> value) {
    final story = _storyNotifier.value!;
    final knobs = _knobs.putIfAbsent(story.name, () => <String, Knob>{});

    return (knobs.putIfAbsent(value.label, () => value) as Knob<T>).value;
  }

  void update<T>(String label, T value) {
    final story = _storyNotifier.value;
    if (story == null) return;

    _knobs[story.name]![label]!.value = value;
    notifyListeners();
  }

  T get<T>(String label) {
    final story = _storyNotifier.value!;

    return _knobs[story.name]![label]!.value as T;
  }

  List<Knob> all() {
    final story = _storyNotifier.value;
    if (story == null) return [];

    return _knobs[story.name]?.values.toList() ?? [];
  }

  @override
  double slider({
    required String label,
    double initial = 0,
    double max = 1,
    double min = 0,
  }) =>
      _addKnob(SliderKnob(label, value: initial, max: max, min: min));

  @override
  int sliderInt({
    required String label,
    int initial = 0,
    int max = 100,
    int min = 0,
    int divisions = 100,
  }) =>
      _addKnob(SliderKnob(
        label,
        value: initial.toDouble(),
        max: max.toDouble(),
        min: min.toDouble(),
        divisions: divisions,
        formatValue: (v) => v.toInt().toString(),
      )).toInt();
}
