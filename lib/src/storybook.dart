import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:storybook_flutter/src/story.dart';

/// A collection of stories.
///
/// It generates Contents in navigation drawer based on stories names.
///
/// This example shows how to create a simple Storybook:
///
/// ```dart
/// Widget build(BuildContext context) => Storybook(
//      children: [
//        Story(
//          name: 'Flat button',
//          child: MaterialButton(child: Text('Flat button'), onPressed: () {}),
//        ),
//        Story(
//          name: 'Raised button',
//          child: RaisedButton(child: Text('Raised button'), onPressed: () {}),
//        ),
//        Story(
//          name: 'Input field',
//          child: TextField(
//            decoration: InputDecoration(
//              border: OutlineInputBorder(),
//              labelText: 'Input field',
//            ),
//          ),
//        ),
//      ],
//    );
/// ```
class Storybook extends StatelessWidget {
  Storybook({Key key, this.children = const []}) : super(key: key);

  /// Stories in the storybook.
  final List<Story> children;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) => MaterialPageRoute(
        settings: settings,
        maintainState: false,
        builder: (context) =>
            HomeScreen(children: children, settings: settings),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.children, this.settings}) : super(key: key);

  final List<Story> children;
  final RouteSettings settings;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  final BehaviorSubject<String> _title = BehaviorSubject.seeded('Storybook');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      navigatorKey.currentState.pushReplacementNamed(widget.settings.name);
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: Drawer(
          child: ListView(
            children: widget.children
                .map(
                  (e) => ListTile(
                    title: Text(e.name),
                    onTap: () {
                      navigatorKey.currentState
                          .pushReplacementNamed('/stories/${e.path}');
                      Navigator.of(context).pop();
                    },
                  ),
                )
                .toList(),
          ),
        ),
        appBar: AppBar(
          title: StreamBuilder<String>(
            stream: _title.stream,
            initialData: '',
            builder: (context, snapshot) => Text(snapshot.data),
          ),
        ),
        body: Navigator(
          key: navigatorKey,
          onGenerateRoute: (settings) => MaterialPageRoute(
            maintainState: false,
            settings: settings,
            builder: (context) {
              final element = _getElement(settings);
              if (element != null) {
                _title.add(element.name);
              }
              return Container(
                color: Colors.white,
                child: Center(child: element ?? Text('Select widget')),
              );
            },
          ),
        ),
      );

  Story _getElement(RouteSettings settings) => widget.children.firstWhere(
        (element) => '/stories/${element.path}' == settings.name,
        orElse: () => null,
      );

  @override
  void dispose() {
    _title.close();
    super.dispose();
  }
}
