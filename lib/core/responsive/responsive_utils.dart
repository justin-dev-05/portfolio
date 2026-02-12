// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';

/// Breakpoints for responsive design
/// Mobile-First approach: base styles are for mobile, then scale up
class Breakpoints {
  Breakpoints._();

  /// Mobile: 0 - 599px
  static const double mobile = 600;

  /// Tablet: 600px - 1023px
  static const double tablet = 1024;

  /// Desktop: 1024px - 1439px
  static const double desktop = 1440;

  /// Large Desktop: 1440px+
  static const double largeDesktop = 1920;
}

/// Device type enum
enum DeviceType {
  mobile,
  tablet,
  desktop,
  largeDesktop,
}

/// Extension to get device type from width
extension DeviceTypeExtension on double {
  DeviceType get deviceType {
    if (this < Breakpoints.mobile) return DeviceType.mobile;
    if (this < Breakpoints.tablet) return DeviceType.tablet;
    if (this < Breakpoints.desktop) return DeviceType.desktop;
    return DeviceType.largeDesktop;
  }

  bool get isMobile => this < Breakpoints.mobile;
  bool get isTablet => this >= Breakpoints.mobile && this < Breakpoints.tablet;
  bool get isDesktop => this >= Breakpoints.tablet;
  bool get isLargeDesktop => this >= Breakpoints.desktop;
}

/// Responsive helper class
class Responsive {
  Responsive._();

  /// Get value based on screen width
  static T value<T>({
    required BuildContext context,
    required T mobile,
    T? tablet,
    T? desktop,
    T? largeDesktop,
  }) {
    final width = MediaQuery.of(context).size.width;

    if (width >= Breakpoints.desktop && largeDesktop != null) {
      return largeDesktop;
    }
    if (width >= Breakpoints.tablet && desktop != null) {
      return desktop;
    }
    if (width >= Breakpoints.mobile && tablet != null) {
      return tablet;
    }
    return mobile;
  }

  /// Get responsive padding
  static EdgeInsets padding(BuildContext context) {
    return value<EdgeInsets>(
      context: context,
      mobile: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      tablet: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
      desktop: const EdgeInsets.symmetric(horizontal: 64, vertical: 60),
      largeDesktop: const EdgeInsets.symmetric(horizontal: 120, vertical: 80),
    );
  }

  /// Get responsive font size
  static double fontSize(BuildContext context, double baseSize) {
    final width = MediaQuery.of(context).size.width;

    if (width >= Breakpoints.desktop) return baseSize * 1.3;
    if (width >= Breakpoints.tablet) return baseSize * 1.15;
    return baseSize;
  }

  /// Get grid column count
  static int gridColumns(BuildContext context) {
    return value<int>(
      context: context,
      mobile: 1,
      tablet: 2,
      desktop: 3,
      largeDesktop: 4,
    );
  }

  /// Get responsive spacing
  static double spacing(BuildContext context) {
    return value<double>(
      context: context,
      mobile: 16,
      tablet: 24,
      desktop: 32,
      largeDesktop: 48,
    );
  }

  /// Get section height
  static double sectionHeight(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return height < 600 ? height : height * 0.9;
  }
}

/// Responsive widget builder
class ResponsiveBuilder extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;
  final Widget? largeDesktop;

  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
    this.largeDesktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        if (width >= Breakpoints.desktop && largeDesktop != null) {
          return largeDesktop!;
        }
        if (width >= Breakpoints.tablet && desktop != null) {
          return desktop!;
        }
        if (width >= Breakpoints.mobile && tablet != null) {
          return tablet!;
        }
        return mobile;
      },
    );
  }
}

/// Visibility widget based on screen size
class ResponsiveVisibility extends StatelessWidget {
  final Widget child;
  final bool visibleOnMobile;
  final bool visibleOnTablet;
  final bool visibleOnDesktop;
  final Widget? replacement;

  const ResponsiveVisibility({
    super.key,
    required this.child,
    this.visibleOnMobile = true,
    this.visibleOnTablet = true,
    this.visibleOnDesktop = true,
    this.replacement,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isMobile = width < Breakpoints.mobile;
        final isTablet =
            width >= Breakpoints.mobile && width < Breakpoints.tablet;
        final isDesktop = width >= Breakpoints.tablet;

        bool isVisible = true;
        if (isMobile) {
          isVisible = visibleOnMobile;
        } else if (isTablet)
          isVisible = visibleOnTablet;
        else if (isDesktop) isVisible = visibleOnDesktop;

        if (isVisible) return child;
        return replacement ?? const SizedBox.shrink();
      },
    );
  }
}

/// Responsive container with max width
class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final Alignment? alignment;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.padding,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1440),
        child: Padding(
          padding: padding ?? Responsive.padding(context),
          child: Align(
            alignment: alignment ?? Alignment.center,
            child: child,
          ),
        ),
      ),
    );
  }
}
