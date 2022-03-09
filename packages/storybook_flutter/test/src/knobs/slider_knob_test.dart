import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/knobs/knob_list_tile.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class MockKnobsNotifier extends Mock implements KnobsNotifier {}

void main() {
  group('SliderKnobValue', () {
    group('build', () {
      test('returns a SliderKnobWidget', () {
        final knobValue = SliderKnobValue(
          value: 5,
          max: 10,
          min: 0,
        );

        expect(
          knobValue.build(
            label: 'label',
            description: 'description',
            enabled: true,
            nullable: false,
          ),
          isA<SliderKnobWidget>().having(
            (w) => w.value,
            'value',
            5,
          ),
        );
      });
    });

    group('formatValue', () {
      test('default is a fixed-precision string', () {
        final knobValue = SliderKnobValue(
          value: 5.555,
          max: 10,
          min: 0,
        );

        expect(knobValue.formatValue(5.555), equals('5.55'));
      });
    });
  });

  group('SliderKnobWidget', () {
    const label = 'LABEL';
    late KnobsNotifier knobsNotifier;

    setUp(() {
      knobsNotifier = MockKnobsNotifier();
    });

    Widget buildSubject() => ChangeNotifierProvider.value(
          value: knobsNotifier,
          child: MaterialApp(
            home: Scaffold(
              body: SliderKnobWidget(
                label: label,
                description: 'description',
                enabled: true,
                nullable: false,
                min: 0,
                max: 10,
                divisions: 10,
                formatValue: (value) => value.toString(),
                value: 10,
              ),
            ),
          ),
        );

    testWidgets('contains KnobListTile', (tester) async {
      await tester.pumpWidget(buildSubject());

      expect(find.byType(KnobListTile), findsOneWidget);
    });

    testWidgets('toggling KnobListTile switch updates knob', (tester) async {
      await tester.pumpWidget(buildSubject());

      final listTile = tester.widget<KnobListTile>(find.byType(KnobListTile));
      listTile.onToggled(false);

      verify(() => knobsNotifier.update(label, null)).called(1);
    });

    testWidgets('dragging slider updates knob', (tester) async {
      await tester.pumpWidget(buildSubject());

      await tester.tap(find.byType(Slider));

      verify(() => knobsNotifier.update(label, 5)).called(1);
    });
  });
}
