# storybook_flutter

A cross-platform storybook for showcasing widgets.

It works in Web as well, though as Flutter support for Web is still in beta, rendering can have some issues. 

![](https://github.com/ookami-kb/storybook_flutter/raw/master/meta/preview.png)

## Getting Started

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Storybook(
        children: [
          Story(
            name: 'Flat button',
            builder: (_, k) => MaterialButton(
              onPressed: k.boolean('Enabled', initial: true) ? () {} : null,
              child: Text(k.text('Text', initial: 'Flat button')),
            ),
          ),
          Story(
            name: 'Raised button',
            builder: (_, k) => RaisedButton(
              onPressed: k.boolean('Enabled', initial: true) ? () {} : null,
              color: k.options(
                'Color',
                initial: Colors.deepOrange,
                options: const [
                  Option('Red', Colors.deepOrange),
                  Option('Green', Colors.teal),
                ],
              ),
              textColor: Colors.white,
              child: Text(k.text('Text', initial: 'Raised button')),
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

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/ookami-kb/storybook_flutter/issues
