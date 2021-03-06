import 'package:core_resources/core_resources.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should convert hex code string to color', () {
    final c1 = ColorExtensions.fromHex('dadada');
    final c2 = ColorExtensions.fromHex('#DADADA');
    expect(c1, equals(c2));
    expect(c1.value, equals(c2.value));
    expect(c1, equals(Color(0xffdadada)));
    expect(c1.value, equals(0xffdadada));
  });
}
