import 'package:wuchuheng_hooks/src/index.dart';
import 'package:wuchuheng_hooks/src/subscription_builder/subscription_builder_abstract.dart';

void main() async {
  /// basic usage.
  Hook<String> strHook = Hook('Hi');
  final subscribe = strHook.subscribe((value, cancel) {
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
    hook1.subscribe((value, cancel) {
      print(value);
      // -> hi
    }),
    hook2.subscribe((value, cancel) {
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
}
