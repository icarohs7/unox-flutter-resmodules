import 'package:mobx/mobx.dart';

extension ObservableExtensions<T> on Observable<T> {
  ///Updates the value of the observable and notify
  ///its observers using an action
  void update(T value) => runInAction(() => this.value = value);
}

/// Turn the Stream into an ObservableStream.
extension ObservableStreamExtension<T> on Stream<T> {
  ObservableStream<T?> asObservable({
    T? initialValue,
    bool cancelOnError = false,
    ReactiveContext? context,
    String? name,
  }) =>
      ObservableStream<T?>(
        this,
        initialValue: initialValue,
        cancelOnError: cancelOnError,
        context: context,
        name: name,
      );
}
