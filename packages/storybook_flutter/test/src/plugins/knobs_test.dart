import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

void main() {
  Future<T> prepareStorybook<T extends Widget>(
    Widget Function(BuildContext context, Key key) builder,
    WidgetTester tester,
  ) async {
    final key = GlobalKey();
    final story = Story(
      name: 'test',
      builder: (context) => builder(context, key),
    );

    final storybook = Storybook(stories: [story], initialStory: 'test');
    await tester.pumpWidget(storybook);

    return find.byKey(key).evaluate().single.widget as T;
  }

  group('slider:', () {
    testWidgets('initial value is set correctly', (tester) async {
      Widget builder(BuildContext context, Key key) => Padding(
            key: key,
            padding: EdgeInsets.all(
              context.knobs
                  .slider(label: 'padding', initial: 20, min: 12, max: 24),
            ),
          );

      final paddingWidget = await prepareStorybook<Padding>(builder, tester);

      expect(paddingWidget.padding, const EdgeInsets.all(20.0));
    });

    testWidgets('no initial value fallbacks to min', (tester) async {
      Widget builder(BuildContext context, Key key) => Padding(
            key: key,
            padding: EdgeInsets.all(
              context.knobs.slider(label: 'padding', min: 12, max: 24),
            ),
          );

      final paddingWidget = await prepareStorybook<Padding>(builder, tester);

      expect(paddingWidget.padding, const EdgeInsets.all(12.0));
    });
  });

  group('sliderInt:', () {
    testWidgets('initial value is set correctly', (tester) async {
      Widget builder(BuildContext context, Key key) => Column(
            key: key,
            children: List.filled(
              context.knobs
                  .sliderInt(label: 'count', min: 3, max: 10, initial: 5),
              const Text('item'),
            ),
          );

      final columnWidget = await prepareStorybook<Column>(builder, tester);

      expect(columnWidget.children.length, 5);
    });

    testWidgets('no initial value fallbacks to min', (tester) async {
      Widget builder(BuildContext context, Key key) => Column(
            key: key,
            children: List.filled(
              context.knobs.sliderInt(label: 'count', min: 3, max: 10),
              const Text('item'),
            ),
          );

      final columnWidget = await prepareStorybook<Column>(builder, tester);

      expect(columnWidget.children.length, 3);
    });
  });
}
