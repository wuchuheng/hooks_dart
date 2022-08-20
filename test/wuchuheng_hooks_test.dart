import 'dart:async';

import 'package:test/test.dart';
import 'package:wuchuheng_hooks/wuchuheng_hooks.dart';

void main() {
  group('A group of tests', () {
    test('Value Test', () {
      Hook<String> strHook = Hook('Hi');
      expect(strHook.value == 'Hi', isTrue);
    });
    test('Subscribe Test', () async {
      Hook<String> strHook = Hook('Hi');
      Future<String> subscribeTest() {
        final completer = Completer<String>();
        strHook.subscribe((value) => completer.complete(value));
        return completer.future;
      }

      final expectValue = 'new Value';
      Future.delayed(Duration(seconds: 1), () => strHook.set(expectValue));
      expect(await subscribeTest() == expectValue, isTrue);
    });
  });
}
