import 'dart:async';

class ChannelHook<T> {
  final List<void Function(T newValue)> _accessValueListCallback = [];

  // Push the value to channel
  push(T value) {
    for (var callback in _accessValueListCallback) {
      callback(value);
    }
    _accessValueListCallback.clear();
  }

  // To get the next value from channel
  Future<T> get value {
    Completer<T> completer = Completer();
    _accessValueListCallback.add((newValue) => completer.complete(newValue));

    return completer.future;
  }
}
