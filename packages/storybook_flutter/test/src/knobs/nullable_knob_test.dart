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
  group('NullableKnob', () {
    late KnobValue<bool> knobValue;
    late NullableKnob<bool> subject;

    setUp(() {
      knobValue = FakeKnobValue(value: false);
      subject = NullableKnob(
        label: 'label',
        knobValue: knobValue,
      );
    });

    test('build uses knobValue.build', () {
      expect(subject.build(), equals(knobWidget));
    });

    group('value getter', () {
      test('returns knobValue.value when enabled', () {
        subject.enabled = true;
        expect(subject.value, equals(knobValue.value));
      });

      test('returns null when disabled', () {
        subject.enabled = false;
        expect(subject.value, isNull);
      });
    });

    group('value setter', () {
      test('sets enabled to false when given a null value', () {
        subject
          ..enabled = true
          ..value = null;
        expect(subject.enabled, isFalse);
      });

      test('sets enabled to true when given a value', () {
        subject
          ..enabled = false
          ..value = true;
        expect(subject.enabled, isTrue);
      });

      test('sets knobValue value when given a value', () {
        subject.value = true;
        expect(knobValue.value, isTrue);
      });
    });
  });
}
