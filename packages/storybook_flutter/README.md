[![Pub Version](https://img.shields.io/pub/v/storybook_flutter)](https://pub.dev/packages/storybook_flutter)

# Storybook Flutter


A cross-platform storybook for showcasing widgets. It should work in all platforms supported by Flutter.

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
`Storybook`. You can either use one of the default ones: `materialWrapper` or
`cupertinoWrapper`, or provide a fully custom wrapper. In the latest case,
make sure to use `child` widget that will contain the story.

## Plugins

Almost all the functionality is provided by plugins, even contents and
knobs are plugins (although, they are first-party plugins).

Plugins documentation is TBD, but you can take a look at the existing
first-party plugins: `ContentsPlugin`, `DeviceFramePlugin`, `KnobsPlugin`,
`ThemModePlugin`.

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/ookami-kb/storybook_flutter/issues
