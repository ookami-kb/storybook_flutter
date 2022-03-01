import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

const knobWidget = SizedBox(key: Key('knob-widget'));

class FakeKnobValue extends KnobValue<bool> {
  FakeKnobValue({required bool value}) : super(value: value);

  @override
  Widget build({
    required String label,
    required String? description,
    required bool nullable,
    required bool enabled,
  }) =>
      knobWidget;
}

void main() {
  group('Knob', () {
    late KnobValue<bool> knobValue;
    late Knob<bool> subject;

    setUp(() {
      knobValue = FakeKnobValue(value: false);
      subject = Knob(
        label: 'label',
        knobValue: knobValue,
      );
    });

    test('build uses knobValue.build', () {
      expect(subject.build(), equals(knobWidget));
    });

    group('value getter', () {
      test('returns knobValue.value', () {
        expect(subject.value, equals(knobValue.value));
      });
    });

    group('value setter', () {
      test('sets knobValue.value', () {
        subject.value = true;
        expect(knobValue.value, isTrue);
      });
    });
  });
}
