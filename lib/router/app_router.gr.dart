// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/cupertino.dart' as _i5;
import 'package:flutter/material.dart' as _i2;

import '../screen/block_detail_screen.dart' as _i4;
import '../screen/home_screen.dart' as _i3;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i3.HomeScreen();
        }),
    BlockDetailRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<BlockDetailRouteArgs>(
              orElse: () =>
                  BlockDetailRouteArgs(index: pathParams.getString('index')));
          return _i4.BlockDetailScreen(key: args.key, index: args.index);
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(HomeRoute.name, path: '/'),
        _i1.RouteConfig(BlockDetailRoute.name, path: '/:index')
      ];
}

class HomeRoute extends _i1.PageRouteInfo {
  const HomeRoute() : super(name, path: '/');

  static const String name = 'HomeRoute';
}

class BlockDetailRoute extends _i1.PageRouteInfo<BlockDetailRouteArgs> {
  BlockDetailRoute({_i5.Key? key, required String index})
      : super(name,
            path: '/:index',
            args: BlockDetailRouteArgs(key: key, index: index),
            rawPathParams: {'index': index});

  static const String name = 'BlockDetailRoute';
}

class BlockDetailRouteArgs {
  const BlockDetailRouteArgs({this.key, required this.index});

  final _i5.Key? key;

  final String index;
}
