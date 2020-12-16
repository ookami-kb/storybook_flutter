import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/story.dart';
import 'package:storybook_flutter/src/story_route_path.dart';

part 'story_router_delegate.freezed.dart';

abstract class StoryRouter implements ChangeNotifier {
  void openStory(String name);

  void openHome();

  StoryPage get currentPage;
}

class StoryRouterDelegate extends RouterDelegate<StoryRoutePath>
    with PopNavigatorRouterDelegateMixin<StoryRoutePath>, ChangeNotifier
    implements StoryRouter {
  StoryRouterDelegate(this._stories);

  StoryPage _page;

  @override
  StoryPage get currentPage => _page;

  final Iterable<Story> Function() _stories;

  @override
  void openStory(String name) {
    setNewRoutePath(StoryRoutePath.story(name));
    notifyListeners();
  }

  @override
  void openHome() {
    setNewRoutePath(const StoryRoutePath.home());
    notifyListeners();
  }

  @override
  StoryRoutePath get currentConfiguration => _page.when(
        home: () => const StoryRoutePath.home(),
        story: (s) => StoryRoutePath.story(s.name),
        unknown: () => const StoryRoutePath.unknown(),
      );

  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Future<void> setNewRoutePath(StoryRoutePath configuration) async {
    _page = configuration.when(
      home: () => const StoryPage.home(),
      story: (name) {
        final story = _stories().firstWhere(
          (s) => s.name == name,
          orElse: () => null,
        );
        return story == null
            ? const StoryPage.unknown()
            : StoryPage.story(story);
      },
      unknown: () => const StoryPage.unknown(),
    );
  }

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<StoryRouter>.value(
        value: this,
        child: null,
      );
}

@freezed
abstract class StoryPage implements _$StoryPage {
  const StoryPage._();

  const factory StoryPage.home() = StoryPageHome;

  const factory StoryPage.story(Story story) = StoryPageStory;

  const factory StoryPage.unknown() = StoryPageUnknown;
}
