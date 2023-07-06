[![Pub Version](https://img.shields.io/pub/v/storybook_flutter)](https://pub.dev/packages/storybook_flutter)
[![melos](https://img.shields.io/badge/maintained%20with-melos-f700ff.svg?style=flat-square)](https://github.com/invertase/melos)

# Storybook Flutter

A cross-platform storybook for showcasing widgets. It should work at all
platforms supported by Flutter.

- [Demo version](https://ookami-kb.github.io/storybook_flutter/)

![](https://github.com/ookami-kb/storybook_flutter/raw/master/meta/preview.png)

## Getting Started

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Storybook(
        stories: [
          Story(
            name: 'Screens/Counter',
            description: 'Demo Counter app with about dialog.',
            builder: (context) => CounterPage(
              title: context.knobs.text(label: 'Title', initial: 'Counter'),
              enabled: context.knobs.boolean(label: 'Enabled', initial: true),
            ),
          ),
          Story(
            name: 'Widgets/Text',
            description: 'Simple text widget.',
            builder: (context) => const Center(child: Text('Simple text')),
          ),
        ],
      );
}
```

## Customization

By default, each story is wrapped into `MaterialApp`.

You can override this behavior by providing either `wrapperBuilder` to the
`Storybook`. You can either use one of the default ones
(`materialWrapper`/`cupertinoWrapper`) or provide a fully custom wrapper. In the
latest case, make sure to use the `child` widget that will contain the story.

## Plugins

Almost all the functionality is provided by plugins. Even contents and
knobs are plugins (although they are first-party plugins).

Plugins documentation is TBD, but you can take a look at the existing
first-party plugins: `ContentsPlugin`, `DeviceFramePlugin`, `KnobsPlugin`,
`ThemModePlugin`.

## Golden tests

You can automatically test your stories by using `storybook_flutter_test` package:

1. Add it to `dev_dependencies`:

   ```yml
   dev_dependencies:
     storybook_flutter_test: any
   ```

2. Create test file, e.g. `storybook_test.dart`.

3. Add the following content there:

   ```dart
   void main() => testStorybook(
       storybook,
       layouts: [
         (
           device: Devices.ios.iPhone13,
           orientation: Orientation.portrait,
           isFrameVisible: true,
         ),
         (
           device: Devices.ios.iPadPro11Inches,
           orientation: Orientation.landscape,
           isFrameVisible: true,
         ),
         (
           device: Devices.android.samsungGalaxyA50,
           orientation: Orientation.portrait,
           isFrameVisible: true,
         ),
       ],
     );
   ```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/ookami-kb/storybook_flutter/issues
