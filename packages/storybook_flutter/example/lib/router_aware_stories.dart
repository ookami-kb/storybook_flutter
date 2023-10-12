import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:storybook_flutter_example/router_aware_stories.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: FirstPage),
    AutoRoute(page: SecondPage),
  ],
)
class $AppRouter {}

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('First Page')),
        body: Center(
          child: ElevatedButton(
            onPressed: () => context.router.navigate(const SecondRoute()),
            child: const Text('Open second page'),
          ),
        ),
      );
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Second Page')),
        body: Center(
          child: ElevatedButton(
            onPressed: () => context.router.navigate(const FirstRoute()),
            child: const Text('Open first page'),
          ),
        ),
      );
}

class RouterAwareStory extends Story {
  RouterAwareStory({
    required String name,
    required List<PageRouteInfo> initialRoutes,
    required AppRouter router,
  }) : super(
          name: name,
          wrapperBuilder: (context, child) => child as Widget,
          builder: (context) => MaterialApp.router(
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            debugShowCheckedModeBanner: false,
            routerDelegate: router.delegate(initialRoutes: initialRoutes),
            routeInformationParser: router.defaultRouteParser(),
          ),
        );
}

final routerAwareStories = [
  RouterAwareStory(
    name: 'Routing/First page',
    initialRoutes: const [FirstRoute()],
    router: AppRouter(),
  ),
  RouterAwareStory(
    name: 'Routing/Second page',
    initialRoutes: const [SecondRoute()],
    router: AppRouter(),
  ),
];
