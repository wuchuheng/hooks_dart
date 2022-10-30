import 'dart:async';

import 'package:wuchuheng_hooks/src/subscription_builder/subscription_builder_abstract.dart';

class Hook<T> {
  T value;
  Hook(this.value);
  final Subscription<T> _onEvent = SubscriptionBuilder.builder();

  void set(T newData) {
    value = newData;
    _onEvent.next(value);
  }

  void setCallback(T Function(T data) callback) {
    value = callback(value);
    _onEvent.next(value);
  }

  Unsubscribe subscribe(void Function(T value, Function() cancel) callback) => _onEvent.subscribe(callback);
}

class SubjectHook<T> {
  final List<Function(T value)> _callback = [];
  final Subscription<T> _onEvent = SubscriptionBuilder.builder();

  Future<T> toFuture() async {
    Completer<T> completer = Completer();
    _callback.add((T value) {
      completer.complete(value);
    });

    return completer.future;
  }

  Unsubscribe subscribe(void Function(T value, void Function() cancel) callback) => _onEvent.subscribe(callback);

  next(T value) {
    for (var callback in _callback) {
      callback(value);
    }
    _callback.clear();
    _onEvent.next(value);
  }
}
