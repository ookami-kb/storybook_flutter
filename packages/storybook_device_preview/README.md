# storybook_device_preview

A plugin for [device_preview](https://pub.dev/packages/device_preview) package that allows to
embed [storybook_flutter](https://pub.dev/packages/storybook_flutter) with contents and knobs support.

## Getting Started

You can use `CustomStorybook` with `builder` parameter to embed the storybook into `DevicePreview`.
Pass `storybookPlugins` to enable contents and knobs panel:

```dart
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      CustomStorybook(
        builder: (context) =>
            DevicePreview(
              plugins: storybookPlugins,
              builder: (context) =>
                  MaterialApp(
                    builder: DevicePreview.appBuilder,
                    locale: DevicePreview.locale(context),
                    home: const Scaffold(body: CurrentStory()),
                  ),
            ),
        children: [
          // Your stories go here
        ],
      );
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/ookami-kb/storybook_flutter/issues
