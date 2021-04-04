[![Pub Version](https://img.shields.io/pub/v/storybook_flutter)](https://pub.dev/packages/storybook_flutter)

# Storybook Flutter

A cross-platform storybook for showcasing widgets. It should work in all platforms supported by Flutter.

- [Demo version](https://ookami-kb.github.io/storybook_flutter/)
- [Documentation](https://storybook-flutter.readthedocs.io/en/latest/)

![](https://github.com/ookami-kb/storybook_flutter/raw/master/meta/preview.png)

## Getting Started

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Storybook(
        children: [
          Story(
            name: 'Flat button',
            padding: EdgeInsets.all(5), // optional padding customization
            background: Colors.red, // optional background color customization
            builder: (_, k) =>
                MaterialButton(
                  onPressed: k.boolean(label: 'Enabled', initial: true) ? () {} : null,
                  child: Text(k.text(label: 'Text', initial: 'Flat button')),
                ),
          ),
          Story(
            name: 'Raised button',
            builder: (_, k) =>
                RaisedButton(
                  onPressed: k.boolean(label: 'Enabled', initial: true) ? () {} : null,
                  color: k.options(
                    label: 'Color',
                    initial: Colors.deepOrange,
                    options: const [
                      Option('Red', Colors.deepOrange),
                      Option('Green', Colors.teal),
                    ],
                  ),
                  textColor: Colors.white,
                  child: Text(k.text(label: 'Text', initial: 'Raised button')),
                ),
          ),
          Story.simple(
            name: 'Input field',
            child: const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Input field',
              ),
            ),
          ),
        ],
      );
}
```

## Customization

By default, each story is wrapped into:

```
Container(
  color: story.background,
  padding: story.padding,
  child: Center(child: child),
)
```

You can override this behavior by providing either `wrapperBuilder` to the `Story` or `storyWrapperBuilder` to
the `Storybook`. In the latest case this wrapper will be applied to each story (of course, you can still override this
behavior by providing another `wrapperBuilder` to individual stories).

## CustomStorybook

If you need even more customization, you can use `CustomStorybook`. You have to provide `builder` parameter to it where
you can define the custom layout. In this case you're responsible for rendering the story, contents and knobs panel.

You can use `CurrentStory`, `Contents` and `KnobPanel` widgets that will render the corresponding data automatically.

As an example of full customization, take a look
at [storybook_device_preview](https://pub.dev/packages/storybook_device_preview) package that allows to embed storybook
into [device_preview](https://pub.dev/packages/device_preview) package with knobs and contents rendered as plugins.

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/ookami-kb/storybook_flutter/issues
