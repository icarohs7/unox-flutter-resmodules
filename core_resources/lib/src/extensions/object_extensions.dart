import 'package:flutter/material.dart';

extension ObjectExtensions<T> on T {
  MaterialStateProperty<T> get materialProperty => MaterialStateProperty.all(this);
}
