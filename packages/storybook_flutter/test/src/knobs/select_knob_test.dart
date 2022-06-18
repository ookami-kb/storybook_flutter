import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/knobs/knob_list_tile.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class MockKnobsNotifier extends Mock implements KnobsNotifier {}

void main() {
  group('SelectKnobValue', () {
    group('build', () {
      test('returns a SelectKnobWidget', () {
        final knobValue = SelectKnobValue(
          value: 2,
          options: [
            const Option(label: '0', value: 0),
            const Option(label: '1', value: 1),
            const Option(label: '2', value: 2),
          ],
        );

        expect(
          knobValue.build(
            label: 'label',
            description: 'description',
            enabled: true,
            nullable: false,
          ),
          isA<SelectKnobWidget<dynamic>>().having(
            (w) => w.value,
            'value',
            2,
          ),
        );
      });
    });
  });

  group('SelectKnobWidget', () {
    const label = 'LABEL';
    late KnobsNotifier knobsNotifier;

    setUp(() {
      knobsNotifier = MockKnobsNotifier();
    });

    Widget buildSubject() => ChangeNotifierProvider.value(
          value: knobsNotifier,
          child: const MaterialApp(
            home: Scaffold(
              body: SelectKnobWidget(
                label: label,
                description: 'description',
                enabled: true,
                nullable: false,
                value: 2,
                values: [
                  Option(label: 'zero', description: '0', value: 0),
                  Option(label: 'one', description: '1', value: 1),
                  Option(label: 'two', description: '2', value: 2),
                ],
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

    testWidgets('selecting option updates knob', (tester) async {
      await tester.pumpWidget(buildSubject());

      await tester.tap(find.text('two'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('zero').last);

      verify(() => knobsNotifier.update(label, 0)).called(1);
    });
  });
}
