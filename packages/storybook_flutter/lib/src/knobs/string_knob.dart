import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/knobs/knobs.dart';
import 'package:storybook_flutter/src/story_provider.dart';

/// {@template string_knob}
/// A knob that allows the user to edit a string value.
///
/// See also:
/// * [StringKnobWidget], which is the widget that displays the knob.
/// {@endtemplate}
class StringKnob extends Knob<String> {
  /// {@macro string_knob}
  StringKnob({
    required String label,
    String? description,
    required String value,
  }) : super(
          label: label,
          description: description,
          value: value,
        );

  @override
  Widget build() => StringKnobWidget(
        label: label,
        description: description,
        value: value,
      );
}

/// {@template string_knob_widget}
/// A knob widget that allows the user to edit a string value.
///
/// The knob is displayed as a [TextFormField].
///
/// See also:
/// * [StringKnob], which is the knob that this widget represents.
/// {@endtemplate}
class StringKnobWidget extends StatelessWidget {
  /// {@macro string_knob_widget}
  const StringKnobWidget({
    Key? key,
    required this.label,
    required this.description,
    required this.value,
  }) : super(key: key);

  final String label;
  final String? description;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: InputDecoration(
              isDense: false,
              labelText: label,
              border: const OutlineInputBorder(),
            ),
            initialValue: value,
            onChanged: (v) => context.read<StoryProvider>().update(label, v),
          ),
          if (description != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                description!,
                style: textTheme.bodyText2?.copyWith(
                  color: textTheme.caption?.color,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
