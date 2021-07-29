import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/control_panel/provider.dart';
import 'package:storybook_flutter/src/knobs/knobs_plugin.dart';
import 'package:storybook_flutter/src/plugins/plugin.dart';
import 'package:storybook_flutter/src/plugins/plugin_settings_notifier.dart';
import 'package:storybook_flutter/src/route.dart';
import 'package:storybook_flutter/src/story.dart';
import 'package:storybook_flutter/src/story_page_wrapper.dart';
import 'package:storybook_flutter/src/story_provider.dart';
import 'package:storybook_flutter/src/theme_mode_provider.dart';

typedef StoryWrapperBuilder = Widget Function(
  BuildContext context,
  Story story,
  Widget child,
);

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
  Storybook({
    Key? key,
    this.children = const [],
    this.theme,
    this.darkTheme,
    this.themeMode = ThemeMode.system,
    this.localizationDelegates,
    this.storyWrapperBuilder,
    Iterable<Plugin>? plugins,
    this.initialRoute = '/',
    List<NavigatorObserver> this.navigatorObservers =
        const <NavigatorObserver>[],
    this.builder,
  })  : plugins = plugins ?? allPlugins,
        super(key: key);

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

  /// Optional list of plugins.
  final Iterable<Plugin> plugins;

  /// {@macro flutter.widgets.widgetsApp.navigatorObservers}
  final List<NavigatorObserver> navigatorObservers;

  /// {@macro flutter.widgets.widgetsApp.builder}
  ///
  /// Material specific features such as [showDialog] and [showMenu], and widgets
  /// such as [Tooltip], [PopupMenuButton], also require a [Navigator] to properly
  /// function.
  final TransitionBuilder? builder;

  /// Optional parameter to override story wrapper.
  ///
  /// {@template storybook_flutter.default_story_wrapper}
  /// By default each story is wrapped into:
  /// ```dart
  /// Container(
  ///   color: story.background,
  ///   padding: story.padding,
  ///   child: Center(child: child),
  /// )
  /// ```
  /// {@endtemplate}
  ///
  /// You can also override individual story wrapper by using
  /// [Story.wrapperBuilder].
  final StoryWrapperBuilder? storyWrapperBuilder;

  final String initialRoute;

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider.value(value: children),
          ChangeNotifierProvider(create: (_) => ThemeModeProvider(themeMode)),
          Provider<StoryWrapperBuilder?>.value(value: storyWrapperBuilder),
          ChangeNotifierProvider(
            create: (_) => ControlPanelProvider([KnobsPlugin(), ...plugins]),
          ),
          ChangeNotifierProvider(create: (_) => PluginSettingsNotifier()),
        ],
        child: Builder(
          builder: (context) => MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: Provider.of<ThemeModeProvider>(context).current,
            theme: theme ?? ThemeData(brightness: Brightness.light),
            darkTheme: darkTheme ?? ThemeData(brightness: Brightness.dark),
            localizationsDelegates: localizationDelegates,
            initialRoute: initialRoute,
            onGenerateInitialRoutes: (name) => [_generateRoute(context, name)],
            onGenerateRoute: (settings) =>
                _generateRoute(context, settings.name, settings: settings),
            builder: builder,
            navigatorObservers: navigatorObservers,
          ),
        ),
      );
}

ModalRoute<void> _generateRoute(
  BuildContext context,
  String? name, {
  RouteSettings? settings,
}) {
  final WidgetBuilder builder = (_) => ChangeNotifierProvider(
        create: (_) => StoryProvider.fromPath(name, context.read()),
        child: const StoryPageWrapper(),
      );
  return name?.endsWith('/full') == true
      ? MaterialPageRoute<void>(settings: settings, builder: builder)
      : StoryRoute(settings: settings, builder: builder);
}
