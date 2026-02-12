import 'package:flutter/foundation.dart';

class Logcat {
  static void print(String tag, String message) {
    if (kDebugMode) {
      debugPrint("$tag :- $message");
    }
  }

  void info(String message) {
    print('[INFO]', message);
  }

  void error(String message) {
    print('[ERROR]', message);
  }

  void debug(String message) {
    print('[DEBUG]', message);
  }
}
