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

  Unsubscribe subscribe(void Function(T value) callback) =>
      _onEvent.subscribe(callback);
}

class SubjectHook<T> {
  final List<Function(T value)> _callback = [];

  Future<T> toFuture() async {
    Completer<T> completer = Completer();
    _callback.add((T value) {
      completer.complete(value);
    });

    return completer.future;
  }

  next(T value) {
    for (var callback in _callback) {
      callback(value);
    }
    _callback.clear();
  }
}
