import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class MockKnobsNotifier extends Mock implements KnobsNotifier {}

void main() {
  group('BoolKnobValue', () {
    group('build', () {
      test('returns a BooleanKnobWidget', () {
        final knobValue = BoolKnobValue(value: false);

        expect(
          knobValue.build(
            label: 'label',
            description: 'description',
            enabled: true,
            nullable: false,
          ),
          isA<BooleanKnobWidget>().having(
            (w) => w.value,
            'value',
            false,
          ),
        );
      });
    });
  });

  group('BooleanKnobWidget', () {
    const label = 'LABEL';
    late KnobsNotifier knobsNotifier;

    setUp(() {
      knobsNotifier = MockKnobsNotifier();
    });

    Widget buildSubject() => ChangeNotifierProvider.value(
          value: knobsNotifier,
          child: const MaterialApp(
            home: Scaffold(
              body: BooleanKnobWidget(
                label: label,
                description: 'description',
                enabled: true,
                nullable: false,
                value: true,
              ),
            ),
          ),
        );

    testWidgets('contains label', (tester) async {
      await tester.pumpWidget(buildSubject());

      expect(find.text(label), findsOneWidget);
    });

    testWidgets('tapping checkbox updates knob', (tester) async {
      await tester.pumpWidget(buildSubject());

      await tester.tap(find.byType(BooleanKnobWidget));

      verify(() => knobsNotifier.update(label, false)).called(1);
    });
  });
}
