import 'package:core_resources/core_resources.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should run async code catching errors', () async {
    final f1 = await runCatchingAsync<String>(() => throw Exception('Test'));
    expect(f1.isError, true);
    expect(f1.asError?.error.runtimeType, Exception('Test').runtimeType);
    expect(f1.asError?.error.toString(), 'Exception: Test');

    final f2 = await runCatchingAsync(() => 'kono giorno giovanna niwa yume ga aru');
    expect(f2.isValue, true);
    expect(f2.asValue?.value, 'kono giorno giovanna niwa yume ga aru');
  });

  test('should run async code and return value or fallback on error', () async {
    final f1 = await runAsyncOrDefault(1532, () => throw Exception('Test'));
    expect(f1, equals(1532));

    final f2 = await runAsyncOrDefault('nani!?', () => 'kono giorno giovanna niwa yume ga aru');
    expect(f2, equals('kono giorno giovanna niwa yume ga aru'));
  });

  test('should turn future value into null if it\'s a failure', () async {
    final f1 = Future<int>(() => throw Exception());
    final r1 = await f1.orNull();
    expect(r1, isNull);

    final f2 = Future(() => 1532);
    final r2 = await f2.orNull();
    expect(r2, equals(1532));
  });

  test('should turn future value into empty list if it\'s a failure', () async {
    final f1 = Future<List<int>>(() => throw Exception());
    final r1 = await f1.orEmpty();
    expect(r1, isEmpty);

    final f2 = Future(() => [24, 42, 1532]);
    final r2 = await f2.orEmpty();
    expect(r2, equals([24, 42, 1532]));
  });
}
