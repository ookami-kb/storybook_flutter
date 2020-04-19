import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:storybook_flutter/src/story.dart';

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
          child: _Contents(onTap: _onStoryTap, children: widget.children),
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
            builder: (context) => _buildStory(context, _getElement(settings)),
          ),
        ),
      );

  Widget _buildStory(BuildContext context, Story story) {
    if (story != null) {
      _title.add(story.name);
    }
    return Container(
      color: Colors.white,
      child: Center(child: story ?? Text('Select widget')),
    );
  }

  void _onStoryTap(Story story) {
    navigatorKey.currentState.pushReplacementNamed('/stories/${story.path}');
    Navigator.of(context).pop();
  }

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

class _Contents extends StatelessWidget {
  const _Contents({
    Key key,
    @required this.onTap,
    @required this.children,
  }) : super(key: key);

  final List<Story> children;
  final void Function(Story) onTap;

  @override
  Widget build(BuildContext context) =>
      ListView(children: children.map(_buildStoryTile).toList());

  Widget _buildStoryTile(Story story) => ListTile(
        title: Text(story.name),
        onTap: () => onTap(story),
      );
}
