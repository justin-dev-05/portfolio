import 'package:get/get.dart';
import '../utils/logger.dart';

class NotificationPayload {
  final Map<String, dynamic> data;

  NotificationPayload(this.data);

  String get role => data['role']?.toString() ?? '';
  String get screen => data['screen']?.toString() ?? '';
  String get eventId => data['event_id']?.toString() ?? '';
  String get eventName => data['event_name']?.toString() ?? '';
  String get userId => data['sender_id']?.toString() ?? '';
  String get quizId => data['reference_id']?.toString() ?? '';
  String get androidLink => data['a_link']?.toString() ?? '';
  String get iosLink => data['i_link']?.toString() ?? '';
  bool get isAnalyticsShow => data['isAnaylticsShow']?.toString().toLowerCase() == "true";
}

Future<bool> isValidNotificationForCurrentUser(String role) async {
  // Add logic to check if current logged in user has this role
  return true; 
}

Future<void> waitForGetReady() async {
  while (Get.context == null) {
    await Future.delayed(const Duration(milliseconds: 100));
  }
}

class SafeNavigator {
  static void navigate(Function() navigationAction) {
    try {
      navigationAction();
    } catch (e) {
      logcat("NavigationError", e);
    }
  }
}
