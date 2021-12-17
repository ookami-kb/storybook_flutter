import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../knobs/bool_knob.dart';
import '../knobs/knobs.dart';
import '../knobs/select_knob.dart';
import '../knobs/slider_knob.dart';
import '../knobs/string_knob.dart';
import '../story.dart';
import 'plugin.dart';

class KnobsPlugin extends Plugin {
  KnobsPlugin({bool sidePanel = false})
      : super(
          icon: sidePanel ? null : _buildIcon,
          panelBuilder: sidePanel ? null : _buildPanel,
          wrapperBuilder: (context, child) => _buildWrapper(
            context,
            child,
            sidePanel: sidePanel,
          ),
        );
}

Widget _buildIcon(BuildContext context) => const Icon(Icons.settings);

Widget _buildPanel(BuildContext context) {
  final knobs = context.watch<KnobsNotifier>();
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
}

Widget _buildWrapper(
  BuildContext context,
  Widget? child, {
  required bool sidePanel,
}) =>
    ChangeNotifierProvider(
      create: (context) => KnobsNotifier(context.read<StoryNotifier>()),
      child: sidePanel
          ? Directionality(
              textDirection: TextDirection.ltr,
              child: Row(
                children: [
                  Expanded(child: child!),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        left: BorderSide(color: Colors.black12),
                      ),
                    ),
                    child: Material(
                      child: SizedBox(
                        width: 250,
                        child: Overlay(
                          initialEntries: [
                            OverlayEntry(
                              builder: (context) => Localizations(
                                delegates: const [
                                  DefaultMaterialLocalizations.delegate,
                                  DefaultWidgetsLocalizations.delegate,
                                ],
                                locale: const Locale('en', 'US'),
                                child: const Builder(builder: _buildPanel),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : child,
    );

extension Knobs on BuildContext {
  KnobsBuilder get knobs => watch<KnobsNotifier>();
}

class KnobsNotifier extends ChangeNotifier implements KnobsBuilder {
  KnobsNotifier(this._storyNotifier) {
    _storyNotifier.addListener(_onStoryChanged);
  }

  final StoryNotifier _storyNotifier;
  final Map<String, Map<String, Knob>> _knobs = <String, Map<String, Knob>>{};

  void _onStoryChanged() => notifyListeners();

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

  T _addKnob<T>(Knob<T> value) {
    final story = _storyNotifier.value!;
    final knobs = _knobs.putIfAbsent(story.name, () => <String, Knob>{});

    return (knobs.putIfAbsent(value.label, () {
      Future.microtask(notifyListeners);
      return value;
    }) as Knob<T>)
        .value;
  }

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

  @override
  void dispose() {
    _storyNotifier.removeListener(_onStoryChanged);
    super.dispose();
  }
}
