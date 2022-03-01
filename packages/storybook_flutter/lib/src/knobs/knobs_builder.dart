import 'select_knob.dart';

/// {@template knobs_builder}
/// Provides helper methods for creating knobs: control elements
/// that can be used in stories to dynamically update its properties.
///
/// It's injected into a story builder, so you can use it there:
///
/// ```dart
///  Story(
///    name: 'Flat button',
///    builder: (_, k) => MaterialButton(
///      onPressed: k.boolean('Enabled', initial: true) ? () {} : null,
///      child: Text(k.text('Text', initial: 'Flat button')),
///    ),
///  )
///  ```
/// {@endtemplate}
abstract class KnobsBuilder {
  /// {@macro knobs_builder}
  const KnobsBuilder();

  /// Create knobs with nullable values
  NullableKnobsBuilder get nullable;

  /// Creates checkbox with [label], [description] and [initial] value.
  bool boolean({
    required String label,
    String? description,
    bool initial = false,
  });

  /// Creates text input field with [label], [description] and [initial] value.
  String text({
    required String label,
    String? description,
    String initial = '',
  });

  /// Creates slider knob with `double` value.
  double slider({
    required String label,
    String? description,
    double initial = 0,
    double max = 1,
    double min = 0,
  });

  /// Creates slider knob with `int` value.
  int sliderInt({
    required String label,
    String? description,
    int initial = 0,
    int max = 100,
    int min = 0,
    int divisions = 100,
  });

  /// Creates select field with [label], [description], [initial] value and
  /// list of [options].
  T options<T>({
    required String label,
    String? description,
    required T initial,
    List<Option<T>> options = const [],
  });
}

/// {@template nullable_knobs_builder}
/// A version of [KnobsBuilder] that creates nullable versions of all knobs.
/// {@endtemplate}
abstract class NullableKnobsBuilder {
  /// {@macro nullable_knobs_builder}
  const NullableKnobsBuilder();

  /// Creates checkbox with [label], [description] and [initial] value.
  bool? boolean({
    required String label,
    String? description,
    bool initial = false,
    bool enabled = false,
  });

  /// Creates text input field with [label], [description] and [initial] value.
  String? text({
    required String label,
    String? description,
    String initial = '',
    bool enabled = false,
  });

  /// Creates slider knob with `double` value.
  double? slider({
    required String label,
    String? description,
    double initial = 0,
    double max = 1,
    double min = 0,
    bool enabled = false,
  });

  /// Creates slider knob with `int` value.
  int? sliderInt({
    required String label,
    String? description,
    int initial = 0,
    int max = 100,
    int min = 0,
    int divisions = 100,
    bool enabled = false,
  });

  /// Creates select field with [label], [description], [initial] value and
  /// list of [options].
  T? options<T>({
    required String label,
    String? description,
    required T initial,
    List<Option<T>> options = const [],
    bool enabled = false,
  });
}
