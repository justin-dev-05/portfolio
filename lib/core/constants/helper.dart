import 'package:flutter/material.dart';

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}

void hideKeyboard(BuildContext context) {
  FocusScope.of(context).unfocus();
}

bool isDarkMode(BuildContext context) {
  if (Theme.of(context).brightness == Brightness.dark) return true;
  return false;
}
