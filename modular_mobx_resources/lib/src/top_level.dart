import 'dart:async';
import 'dart:math';

import 'package:modular_mobx_resources/modular_mobx_resources.dart';

Future<T> runInActionAsync<T>(Future<T> fn(), {String? name}) {
  final actionName = name ?? '${DateTime.now().microsecondsSinceEpoch + Random().nextInt(10000)}';
  return AsyncAction(actionName).run(fn);
}
