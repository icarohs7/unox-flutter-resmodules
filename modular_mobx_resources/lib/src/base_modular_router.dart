import 'package:flutter/widgets.dart';
import 'package:modular_mobx_resources/modular_mobx_resources.dart';

mixin BaseModularRouter {
  Future<T?> go<T>(String route, {Object? arguments}) {
    return Modular.to.pushNamed(route, arguments: arguments);
  }

  Future<T?> goReplacement<T>(String route, {Object? arguments}) {
    return Modular.to.pushReplacementNamed(route, arguments: arguments);
  }

  Future<T?> goClearingBackstack<T>(String route, {Object? arguments}) {
    return Modular.to
        .pushNamedAndRemoveUntil(route, (r) => false, arguments: arguments);
  }

  Future<T?> goAndRemoveUntil<T>(
    String route,
    bool Function(Route<dynamic> route) predicate, {
    Object? arguments,
  }) {
    return Modular.to
        .pushNamedAndRemoveUntil(route, predicate, arguments: arguments);
  }

  List<String> get bottomNavRoutes => [];

  /// The index of the curent route in the
  /// [bottomNavRoutes] list, or null if
  /// it isn't a registered route
  int? currentBottomNavIndex(BuildContext context) {
    final routeName = ModalRoute.of(context)?.settings.name;
    if (routeName == null) return null;
    final index = bottomNavRoutes.indexOf(routeName);
    return index != -1 ? index : null;
  }
}
