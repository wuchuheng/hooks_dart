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
        strHook.subscribe((value, cancel) => completer.complete(value));
        return completer.future;
      }

      final expectValue = 'new Value';
      Future.delayed(Duration(seconds: 1), () => strHook.set(expectValue));
      expect(await subscribeTest() == expectValue, isTrue);
    });
    test('SubjectHook Test', () async {
      SubjectHook subjectHook = SubjectHook<bool>();
      Future.delayed(Duration(seconds: 1), () => subjectHook.next(true));
      expect(await subjectHook.toFuture(), true);
      late bool isOk = false;
      subjectHook.subscribe((value, cancel) => isOk = value);
      subjectHook.next(true);
      expect(isOk, true);
    });

    test('Cancel Test', () async {
      SubjectHook subjectHook = SubjectHook<bool>();
      Future.delayed(Duration(seconds: 1), () => subjectHook.next(true));
      expect(await subjectHook.toFuture(), true);
      late bool isOk = false;
      subjectHook.subscribe((value, cancel) {
        isOk = value;
        cancel();
      });
      subjectHook.next(true);
      subjectHook.next(false);
      await Future.delayed(Duration(seconds: 1));
      expect(isOk, true);
    });
  });
}
