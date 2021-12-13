import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/knobs/knobs.dart';
import 'package:storybook_flutter/src/story_provider.dart';

/// A type definition for a function that formats a [double] value.
typedef DoubleFormatter = String Function(double value);

/// {@template slider_knob}
/// A knob that allows the user to select a value from a range.
///
/// See also:
/// * [SliderKnobWidget], which is the widget that displays the knob.
/// {@endtemplate}
class SliderKnob extends Knob<double> {
  /// {@macro slider_knob}
  SliderKnob({
    required String label,
    String? description,
    required double value,
    required this.max,
    required this.min,
    this.divisions,
    this.formatValue = _defaultFormat,
  }) : super(
          label: label,
          description: description,
          value: value,
        );

  /// The maximum value of the slider.
  final double max;

  /// The minimum value of the slider.
  final double min;

  /// The number of divisions in the slider.
  final int? divisions;

  /// An optional function that formats the value of the slider.
  ///
  /// By default, the value is formatted as a decimal number with two digits
  /// after the decimal point.
  final DoubleFormatter formatValue;

  @override
  Widget build() => SliderKnobWidget(
        label: label,
        description: description,
        value: value,
        min: min,
        max: max,
        divisions: divisions,
        formatValue: formatValue,
      );
}

/// {@template slider_knob_widget}
/// A knob widget that allows the user to select a value from a range.
///
/// The knob is displayed as a [Slider].
///
/// See also:
/// * [SliderKnob], which is the knob that this widget represents.
/// {@endtemplate}
class SliderKnobWidget extends StatelessWidget {
  /// {@macro slider_knob_widget}
  const SliderKnobWidget({
    Key? key,
    required this.label,
    required this.description,
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.formatValue,
  }) : super(key: key);

  final String label;
  final String? description;
  final double min;
  final double max;
  final double value;
  final int? divisions;
  final DoubleFormatter formatValue;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ListTile(
      title: Text('$label (${formatValue(value)})'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (description != null) ...[
            Text(
              description!,
              style: textTheme.bodyText2?.copyWith(
                color: textTheme.caption?.color,
              ),
            ),
            const SizedBox(height: 4),
          ],
          Slider(
            value: value,
            onChanged: (v) => context.read<StoryProvider>().update(label, v),
            max: max,
            min: min,
            divisions: divisions,
          ),
        ],
      ),
    );
  }
}

String _defaultFormat(double value) => value.toStringAsFixed(2);
