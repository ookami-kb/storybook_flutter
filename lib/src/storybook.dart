import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/story.dart';
import 'package:storybook_flutter/src/story_route_information_parser.dart';
import 'package:storybook_flutter/src/story_router_delegate.dart';
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
class Storybook extends StatefulWidget {
  const Storybook({
    Key key,
    this.children = const [],
    this.theme,
    this.darkTheme,
    this.themeMode = ThemeMode.system,
    this.localizationDelegates,
  }) : super(key: key);

  /// Theme override for the light theme.
  final ThemeData theme;

  /// Theme override for the dark theme.
  final ThemeData darkTheme;

  /// Indicates theme mode to use: light, dark or system.
  final ThemeMode themeMode;

  /// Stories in the storybook.
  final List<Story> children;

  /// Localizations Delegates override
  final List<LocalizationsDelegate> localizationDelegates;

  @override
  _StorybookState createState() => _StorybookState();
}

class _StorybookState extends State<Storybook> {
  final _routeInformationParser = StoryRouteInformationParser();
  RouterDelegate _routerDelegate;

  @override
  void initState() {
    super.initState();
    _routerDelegate = StoryRouterDelegate(() => widget.children);
  }

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider.value(value: widget.children),
          ChangeNotifierProvider(
            create: (_) => ThemeModeProvider(widget.themeMode),
          )
        ],
        child: Builder(
          builder: (context) => MaterialApp.router(
            routeInformationParser: _routeInformationParser,
            routerDelegate: _routerDelegate,
            themeMode: Provider.of<ThemeModeProvider>(context).current,
            theme: widget.theme ?? ThemeData(brightness: Brightness.light),
            darkTheme:
                widget.darkTheme ?? ThemeData(brightness: Brightness.dark),
            localizationsDelegates: widget.localizationDelegates,
          ),
        ),
      );
}
