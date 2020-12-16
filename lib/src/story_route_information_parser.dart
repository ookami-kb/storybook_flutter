import 'package:flutter/widgets.dart';
import 'package:storybook_flutter/src/story_route_path.dart';

class StoryRouteInformationParser
    extends RouteInformationParser<StoryRoutePath> {
  @override
  Future<StoryRoutePath> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    final uri = Uri.parse(routeInformation.location);
    if (uri.pathSegments.isEmpty) return const StoryRoutePath.home();
    if (uri.pathSegments.length != 2) return const StoryRoutePath.home();
    if (uri.pathSegments[0] != 'stories') return const StoryRoutePath.home();

    final name = uri.pathSegments[1];
    return StoryRoutePath.story(name);
  }
}
