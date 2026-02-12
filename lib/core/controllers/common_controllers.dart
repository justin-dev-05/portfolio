import 'package:get/get.dart';
import '../utils/logger.dart';

class InternetController extends GetxController {}

class NotificationCountController extends GetxController {
  Future<void> initializeCount() async {
    logcat("NotificationCount", "Initializing...");
  }

  Future<dynamic> fetchPaymentkeys() async {
    return null; // Stub
  }
}

class PaymentMethodController extends GetxController {}
