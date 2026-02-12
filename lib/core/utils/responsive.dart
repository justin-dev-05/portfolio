import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;
  final Widget? largeDesktop;

  const Responsive({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
    this.largeDesktop,
  });

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 600 &&
      MediaQuery.sizeOf(context).width < 1024;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 1024;

  static bool isLargeDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 1440;

  static double getWidth(BuildContext context) =>
      MediaQuery.sizeOf(context).width;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1440 && largeDesktop != null) {
          return largeDesktop!;
        } else if (constraints.maxWidth >= 1024) {
          return desktop;
        } else if (constraints.maxWidth >= 600 && tablet != null) {
          return tablet!;
        } else {
          return mobile;
        }
      },
    );
  }

  static T getResponsiveValue<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    required T desktop,
    T? largeDesktop,
  }) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= 1440 && largeDesktop != null) {
      return largeDesktop;
    } else if (width >= 1024) {
      return desktop;
    } else if (width >= 600 && tablet != null) {
      return tablet;
    } else {
      return mobile;
    }
  }

  static int getGridColumns(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= 1200) return 4;
    if (width >= 900) return 3;
    if (width >= 600) return 2;
    return 1;
  }
}

class DesignSize {
  static Size resolve(double width) {
    if (width < 600) {
      // Mobile
      return const Size(375, 812);
    } else if (width < 1024) {
      // Tablet
      return const Size(768, 1024);
    } else {
      // Desktop / Web
      return const Size(1440, 900);
    }
  }
}
