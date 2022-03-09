import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:storybook_flutter/src/knobs/knob_list_tile.dart';

void main() {
  group('KnobListTile', () {
    late bool enabled;

    final findTitle = find.byKey(const Key('title'));
    final findSubtitle = find.byKey(const Key('subtitle'));

    setUp(() {
      enabled = true;
    });

    Widget buildSubject({required bool nullable}) => MaterialApp(
          home: Scaffold(
            body: KnobListTile(
              title: const SizedBox(key: Key('title')),
              subtitle: const SizedBox(key: Key('subtitle')),
              enabled: enabled,
              nullable: nullable,
              onToggled: (value) => enabled = value,
            ),
          ),
        );

    group('when knob is nullable', () {
      testWidgets('contains SwitchListTile', (tester) async {
        await tester.pumpWidget(buildSubject(nullable: true));

        expect(find.byType(SwitchListTile), findsOneWidget);
      });

      testWidgets('contains title', (tester) async {
        await tester.pumpWidget(buildSubject(nullable: true));

        expect(findTitle, findsOneWidget);
      });

      testWidgets('contains subtitle', (tester) async {
        await tester.pumpWidget(buildSubject(nullable: true));

        expect(findSubtitle, findsOneWidget);
      });
    });

    group('when knob is not nullable', () {
      testWidgets('contains ListTile', (tester) async {
        await tester.pumpWidget(buildSubject(nullable: false));

        expect(find.byType(ListTile), findsOneWidget);
      });

      testWidgets('contains title', (tester) async {
        await tester.pumpWidget(buildSubject(nullable: false));

        expect(findTitle, findsOneWidget);
      });

      testWidgets('contains subtitle', (tester) async {
        await tester.pumpWidget(buildSubject(nullable: false));

        expect(findSubtitle, findsOneWidget);
      });
    });

    testWidgets('title is grayed out when disabled', (tester) async {
      enabled = false;
      await tester.pumpWidget(buildSubject(nullable: true));

      final opacity = tester.widget<Opacity>(
        find.ancestor(
          of: findTitle,
          matching: find.byType(Opacity),
        ),
      );

      expect(opacity.opacity, lessThan(1));
    });

    testWidgets('subtitle is grayed out when disabled', (tester) async {
      enabled = false;
      await tester.pumpWidget(buildSubject(nullable: true));

      final opacity = tester.widget<Opacity>(
        find.ancestor(
          of: findSubtitle,
          matching: find.byType(Opacity),
        ),
      );

      expect(opacity.opacity, lessThan(1));
    });

    testWidgets('title is non-interactable when disabled', (tester) async {
      enabled = false;
      await tester.pumpWidget(buildSubject(nullable: true));

      final ignorePointer = tester.widget<IgnorePointer>(
        find.byKey(const Key('knobListTile_ignorePointer_disableTitle')),
      );

      expect(ignorePointer.ignoring, isTrue);
    });

    testWidgets('subtitle is non-interactable when disabled', (tester) async {
      enabled = false;
      await tester.pumpWidget(buildSubject(nullable: true));

      final ignorePointer = tester.widget<IgnorePointer>(
        find.byKey(const Key('knobListTile_ignorePointer_disableSubtitle')),
      );

      expect(ignorePointer.ignoring, isTrue);
    });

    testWidgets(
      'calls onToggled when switch is toggled and tile is nullable',
      (tester) async {
        expect(enabled, isTrue);

        await tester.pumpWidget(buildSubject(nullable: true));

        await tester.tap(find.byType(Switch));

        expect(enabled, isFalse);
      },
    );

    testWidgets(
      'does not call onToggled when switch is toggled and tile is non-nullable',
      (tester) async {
        expect(enabled, isTrue);

        await tester.pumpWidget(buildSubject(nullable: true));

        await tester.tap(find.byType(Switch));

        expect(enabled, isFalse);
      },
    );
  });
}
