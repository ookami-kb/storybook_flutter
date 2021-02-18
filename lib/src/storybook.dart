import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/route.dart';
import 'package:storybook_flutter/src/story.dart';
import 'package:storybook_flutter/src/story_page_wrapper.dart';
import 'package:storybook_flutter/src/theme_mode_provider.dart';

/// A collection of stories.
///
/// It generates Contents in navigation drawer based on stories names.
///
/// This example shows how to create a simple Storybook:
///
/// ```
/// Widget build(BuildContext context) => Storybook(
///     children: [
///       Story(
///         name: 'Flat button',
///         child: MaterialButton(child: Text('Flat button'), onPressed: () {}),
///       ),
///       Story(
///         name: 'Raised button',
///         child: RaisedButton(child: Text('Raised button'), onPressed: () {}),
///       ),
///       Story(
///         name: 'Input field',
///         child: TextField(
///           decoration: InputDecoration(
///             border: OutlineInputBorder(),
///             labelText: 'Input field',
///           ),
///         ),
///       ),
///     ],
///   );
/// ```
class Storybook extends StatelessWidget {
  const Storybook({
    Key? key,
    this.children = const [],
    this.theme,
    this.darkTheme,
    this.themeMode = ThemeMode.system,
    this.localizationDelegates,
  }) : super(key: key);

  /// Theme override for the light theme.
  final ThemeData? theme;

  /// Theme override for the dark theme.
  final ThemeData? darkTheme;

  /// Indicates theme mode to use: light, dark or system.
  final ThemeMode themeMode;

  /// Stories in the storybook.
  final List<Story> children;

  /// Localizations Delegates override
  final List<LocalizationsDelegate>? localizationDelegates;

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider.value(value: children),
          ChangeNotifierProvider(create: (_) => ThemeModeProvider(themeMode))
        ],
        child: Builder(
          builder: (context) => MaterialApp(
            themeMode: Provider.of<ThemeModeProvider>(context).current,
            theme: theme ?? ThemeData(brightness: Brightness.light),
            darkTheme: darkTheme ?? ThemeData(brightness: Brightness.dark),
            localizationsDelegates: localizationDelegates,
            onGenerateInitialRoutes: (name) => [
              StoryRoute(
                builder: (_) => StoryPageWrapper(path: name.toStoryPath()),
              ),
            ],
            onGenerateRoute: (settings) => StoryRoute(
              settings: settings,
              builder: (_) => StoryPageWrapper(
                path: settings.name!.toStoryPath(),
              ),
            ),
          ),
        ),
      );
}

extension on String {
  String toStoryPath() => replaceFirst('/stories/', '');
}
