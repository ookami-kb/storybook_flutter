import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:storybook_flutter/src/breakpoint.dart';
import 'package:storybook_flutter/src/route.dart';
import 'package:storybook_flutter/src/story.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key, this.children, this.settings}) : super(key: key);

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
    if (kIsWeb) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        navigatorKey.currentState.pushReplacementNamed(widget.settings.name);
      });
    }
  }

  bool get _shouldDisplayDrawer =>
      MediaQuery.of(context).breakpoint == Breakpoint.small;

  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: _shouldDisplayDrawer ? Drawer(child: _buildContents()) : null,
        appBar: AppBar(
          title: StreamBuilder<String>(
            stream: _title.stream,
            initialData: '',
            builder: (context, snapshot) => Text(snapshot.data),
          ),
        ),
        body: _shouldDisplayDrawer
            ? _buildBody()
            : Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(width: 200, child: _buildContents()),
                  Expanded(child: _buildBody()),
                ],
              ),
      );

  Navigator _buildBody() => Navigator(
        key: navigatorKey,
        onGenerateRoute: (settings) => StoryRoute(
          settings: settings,
          builder: (context) => _buildStory(context, _getElement(settings)),
        ),
      );

  _Contents _buildContents() => _Contents(
        onTap: _onStoryTap,
        children: widget.children,
      );

  Widget _buildStory(BuildContext context, Story story) {
    if (story != null) {
      _title.add(story.name);
    }
    return Container(
      color: Colors.white,
      child: Center(child: story ?? const Text('Select story')),
    );
  }

  void _onStoryTap(Story story) {
    navigatorKey.currentState.pushReplacementNamed('/stories/${story.path}');
    if (_shouldDisplayDrawer) Navigator.of(context).pop();
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
