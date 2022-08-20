
Hooks is a state management library where data can be set and changes can be subscribed.
## Features

* Get data status
* data change subscriptions

## Getting started

## Usage

```dart
import 'package:wuchuheng_hooks/src/index.dart';
import 'package:wuchuheng_hooks/src/subscription_builder/subscription_builder_abstract.dart';

void main() {
  /// basic usage.
  Hook<String> strHook = Hook('Hi');
  final subscribe = strHook.subscribe((value) {
    print(value);
    // -> new Data
  });
  print(strHook.value);
  // ->  Hi
  strHook.set('new Data');
  // unsubscribe
  subscribe.unsubscribe();

  ///Batch unsubscribe hooks
  Hook<String> hook1 = Hook('');
  Hook<int> hook2 = Hook(0);
  final unsubscribeCollect = UnsubscribeCollect([
    hook1.subscribe((value) {
      print(value);
      // -> hi
    }),
    hook2.subscribe((value) {
      print(value);
      // -> 74110
    })
  ]);

  hook1.set('Hi');
  hook2.set(74110);
  unsubscribeCollect.unsubscribe();
}
```

## Additional information

contribute to the package, how to file issues, what response they can expect 
from the package authors, and more.
