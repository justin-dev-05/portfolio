import 'package:flutter/material.dart';

class AppNav {
  /// Pushes a new page with a fade transition
  static Future<T?> push<T>(BuildContext context, Widget page) {
    return Navigator.push<T>(
      context,
      FadePageRoute(page: page),
    );
  }

  /// Replaces the current page with a new page using a fade transition
  static Future<T?> replace<T>(BuildContext context, Widget page) {
    return Navigator.pushReplacement<T, dynamic>(
      context,
      FadePageRoute(page: page),
    );
  }

  /// Pushes a new page and removes all previous routes with a fade transition
  static Future<T?> pushAndRemoveUntil<T>(BuildContext context, Widget page) {
    return Navigator.pushAndRemoveUntil<T>(
      context,
      FadePageRoute(page: page),
      (route) => false,
    );
  }

  /// Standard pop
  static void pop<T>(BuildContext context, [T? result]) {
    Navigator.pop<T>(context, result);
  }
}

class FadePageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  FadePageRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 400),
          reverseTransitionDuration: const Duration(milliseconds: 300),
        );
}
