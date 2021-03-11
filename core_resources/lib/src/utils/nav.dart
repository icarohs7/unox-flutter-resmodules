import 'package:core_resources/core_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Nav {
  Future<T?> goFullscreenDialog<T>(BuildContext context, {required Widget page}) {
    return Navigator.push<T>(
      context,
      MaterialPageRoute(builder: (context) => page, fullscreenDialog: true),
    );
  }

  ///Navigate using a named route
  Future<T?> goNamed<T>(BuildContext context, String route, {Object? arguments}) {
    return Navigator.pushNamed<T>(context, route, arguments: arguments);
  }

  Future<T?> go<T>(
    BuildContext context, {
    Widget? page,
    Route<T> Function(Widget page)? routeBuilder,
    Route<T>? route,
  }) {
    if (page != null) {
      return Navigator.push<T>(context, routeBuilder?.call(page) ?? FadePageRoute(page: page));
    } else if (route != null) {
      return Navigator.push<T>(context, route);
    }
    throw ArgumentError('namedRoute, page or route must be defined');
  }

  ///Shorthand to [goReplacement] with named route
  Future<T?> goReplacementNamed<T>(BuildContext context, String route) {
    return goReplacement(context, namedRoute: route);
  }

  Future<T?> goReplacement<T>(
    BuildContext context, {
    String? namedRoute,
    Widget? page,
    Route<T> Function(Widget page)? routeBuilder,
    Route<T>? route,
  }) {
    if (namedRoute != null) {
      return Navigator.pushReplacementNamed<T, dynamic>(context, namedRoute);
    } else if (page != null) {
      return Navigator.pushReplacement<T, dynamic>(
        context,
        routeBuilder?.call(page) ?? FadePageRoute(page: page),
      );
    } else if (route != null) {
      return Navigator.pushReplacement<T, dynamic>(context, route);
    }
    throw ArgumentError('namedRoute, page or route must be defined');
  }

  ///Shorthand to [goErasingHistory] with named route
  Future goErasingHistoryNamed(BuildContext context, String route) {
    return goErasingHistory(context, namedRoute: route);
  }

  Future goErasingHistory(
    BuildContext context, {
    String? namedRoute,
    Widget? page,
    Route Function(Widget page)? routeBuilder,
    Route? route,
  }) {
    if (namedRoute != null) {
      return Navigator.pushNamedAndRemoveUntil(context, namedRoute, (r) => false);
    } else if (page != null) {
      return Navigator.pushAndRemoveUntil(
        context,
        routeBuilder?.call(page) ?? FadePageRoute(page: page),
        (r) => false,
      );
    } else if (route != null) {
      return Navigator.pushAndRemoveUntil(context, route, (r) => false);
    }
    throw ArgumentError('namedRoute, page or route must be defined');
  }

  static Nav get to => _instance;
  static final Nav _instance = Nav();
}
