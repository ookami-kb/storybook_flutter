// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i2;
import 'package:flutter/material.dart' as _i3;

import 'router_aware_stories.dart' as _i1;

class AppRouter extends _i2.RootStackRouter {
  AppRouter([_i3.GlobalKey<_i3.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    FirstRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.FirstPage(),
      );
    },
    SecondRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SecondPage(),
      );
    },
  };

  @override
  List<_i2.RouteConfig> get routes => [
        _i2.RouteConfig(
          FirstRoute.name,
          path: '/first-page',
        ),
        _i2.RouteConfig(
          SecondRoute.name,
          path: '/second-page',
        ),
      ];
}

/// generated route for
/// [_i1.FirstPage]
class FirstRoute extends _i2.PageRouteInfo<void> {
  const FirstRoute()
      : super(
          FirstRoute.name,
          path: '/first-page',
        );

  static const String name = 'FirstRoute';
}

/// generated route for
/// [_i1.SecondPage]
class SecondRoute extends _i2.PageRouteInfo<void> {
  const SecondRoute()
      : super(
          SecondRoute.name,
          path: '/second-page',
        );

  static const String name = 'SecondRoute';
}
