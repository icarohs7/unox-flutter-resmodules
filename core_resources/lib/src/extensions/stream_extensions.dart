import 'package:collection/collection.dart' show IterableExtension;

extension ListStreamExtensions<T> on Stream<List<T>> {
  ///Apply the given filter to each list emitted by the stream
  Stream<List<T>> innerFilter(bool Function(T element) predicate) {
    return map((list) => list.where(predicate).toList());
  }

  ///Map each emitted list to the first item matching the given
  ///[predicate]
  Stream<T?> innerFirst(bool Function(T element) predicate) {
    return map((list) => list.firstWhereOrNull(predicate));
  }
}
