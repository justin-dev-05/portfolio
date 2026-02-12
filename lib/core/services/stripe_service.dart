import '../utils/logger.dart';

class StripeKeys {
  static const String publishableLiveKey = "pk_live_your_key";
}

class StripePaymentService {
  static final StripePaymentService instance = StripePaymentService._internal();
  StripePaymentService._internal();

  Future<void> initialize({required String publishableKey}) async {
    logcat("StripeInit", "Initialized with key: $publishableKey");
  }
}
