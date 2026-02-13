import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pdi_dost/core/constants/app_constants.dart';
import 'package:pdi_dost/features/dashboard/ui/dashboard_screen.dart';
import 'package:pdi_dost/features/auth/ui/login/login_screen.dart';
import 'package:pdi_dost/core/utils/app_nav.dart';

/// Extension on [String] for common transformations and checks
extension StringExtension on String {
  /// Capitalizes the first letter of the string
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }

  /// Capitalizes each word in the string
  String capitalizeWords() {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize()).join(' ');
  }

  /// Checks if the string is a valid email
  bool isValidEmail() {
    return RegExp(
      r'^[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)+$',
    ).hasMatch(this);
  }

  /// Checks if the string is numeric
  bool isNumeric() {
    return double.tryParse(this) != null;
  }
}

/// Helper class for common application tasks
class AppHelper {
  /// Hides the soft keyboard
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  /// Checks if the current theme is dark mode
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  /// Checks if the device is a tablet based on screen width
  static bool isTablet() {
    return ScreenUtil().screenWidth > 600;
  }

  /// Formats a [DateTime] into a readable string
  /// Default format: DD MMM YYYY (e.g., 12 Feb 2026)
  static String formatDate(DateTime date, {String format = 'dd MMM yyyy'}) {
    return DateFormat(format).format(date);
  }

  /// Formats a time into a readable string (e.g., 10:30 AM)
  static String formatTime(DateTime date) {
    return DateFormat('hh:mm a').format(date);
  }

  /// Launches a URL in the default browser or application
  static Future<void> launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $url');
    }
  }

  /// Makes a phone call
  static Future<void> makePhoneCall(String phoneNumber) async {
    final Uri uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  /// Checks and requests a permission
  static Future<bool> requestPermission(Permission permission) async {
    final status = await permission.request();
    return status.isGranted;
  }

  /// Logs information only in debug mode
  static void log(String message) {
    if (kDebugMode) {
      print('[PDI-DOST LOG]: $message');
    }
  }

  /// Gets the initials from a name (e.g., "John Doe" -> "JD")
  static String getInitials(String name) {
    if (name.isEmpty) return "";
    List<String> parts = name.trim().split(" ");
    if (parts.length > 1) {
      return (parts[0][0] + parts[1][0]).toUpperCase();
    }
    return parts[0][0].toUpperCase();
  }

  /// Navigates user based on their specific role (Referenced from requirements)
  static void navigateUserByRole(BuildContext context, String? role) {
    if (role == null) {
      AppNav.pushAndRemoveUntil(context, const LoginScreen());
      return;
    }

    // Role-based navigation logic
    // For now, all roles go to DashboardScreen as per project structure
    switch (role) {
      case RoleConst.admin:
      case RoleConst.superAdmin:
      case RoleConst.attendee:
        AppNav.pushAndRemoveUntil(context, const DashboardScreen());
        break;
      default:
        AppNav.pushAndRemoveUntil(context, const LoginScreen());
    }
  }
}

/// Global shortcut for isDarkMode
bool isDarkMode(BuildContext context) => AppHelper.isDarkMode(context);

/// Global shortcut for hideKeyboard
void hideKeyboard(BuildContext context) => AppHelper.hideKeyboard(context);
