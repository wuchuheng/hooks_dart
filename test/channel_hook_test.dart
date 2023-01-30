import 'dart:async';

import 'package:test/test.dart';
import 'package:wuchuheng_hooks/wuchuheng_hooks.dart';

void main() {
  test('Channel hook Test', () async {
    final ChannelHook<String> stringHook = ChannelHook<String>();
    String result = '';
    final String expectValue = 'hello world';
    stringHook.value.then((value) => result = value);
    stringHook.push(expectValue);
    await Future.delayed(Duration(seconds: 1));
    expect(result, expectValue);
  });
}
