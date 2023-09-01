
import 'package:flutter/cupertino.dart';

void benchmark(Function() f) {
  final st = DateTime.now().microsecondsSinceEpoch;
  f();
  final et = DateTime.now().microsecondsSinceEpoch;
  debugPrint('[BENCHMARK] time = ${et - st} ms');
}
