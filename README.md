<a href="https://pub.dev/packages/wuchuheng_hooks">

<h1 align="center">
wuchuheng_hooks
</h1>
</a>

<p align="center">
Hooks is a state management library where data can be set and changes can be subscribed.
</p>

<p align="center">
    <a href="https://github.com/wuchuheng/hooks_dart/actions/workflows/test.yml" >
        <img src="https://github.com/wuchuheng/hooks_dart/actions/workflows/test.yml/badge.svg" />
    </a>
</p>



## Features

* Get data status
* data change subscriptions

## Getting started

## Usage

```dart
import 'package:wuchuheng_hooks/src/index.dart';
import 'package:wuchuheng_hooks/src/subscription_builder/subscription_builder_abstract.dart';

void main() async {
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

  /// SubjectHook
  SubjectHook subjectHook = SubjectHook<bool>();
  Future.delayed(Duration(seconds: 10), () => subjectHook.next(true));
  // 10s waiting for results
  final result = await subjectHook.toFuture();
  print(result); // true

  // ChannelHook
  final ChannelHook<String> stringHook = ChannelHook<String>();
  final String expectValue = 'foo';
  stringHook.value.then((value) { // <-- get value from channel
    print(value); //  foo
  });
  stringHook.push(expectValue); // <-- push value to channel
  await Future.delayed(Duration(seconds: 1));
}
```

## Additional information

contribute to the package, how to file issues, what response they can expect 
from the package authors, and more.
