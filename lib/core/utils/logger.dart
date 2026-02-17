import 'dart:developer' as dev;
import 'package:flutter/foundation.dart';

/// Centralized logging utility
void logcat(String tag, dynamic message) {
  if (kDebugMode) {
    // dev.log(message.toString(), name: tag);
  }
}
