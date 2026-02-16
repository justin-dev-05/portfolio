import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pdi_dost/core/constants/app_strings.dart';
import 'package:pdi_dost/core/utils/app_snackbar.dart';
import 'package:pdi_dost/features/auth/bloc/auth/auth_bloc.dart';

class OTPController extends ChangeNotifier {
  final AuthBloc authBloc;
  final String email;

  OTPController({required this.authBloc, required this.email}) {
    startTimer();
    otpController.addListener(notifyListeners);
  }

  // OTP
  final otpController = TextEditingController();
  final otpFocusNode = FocusNode();

  // Timer
  Timer? _timer;
  int remainingSeconds = 60;
  bool canResend = false;

  void onPinChanged(String pin) {
    notifyListeners();
  }

  void startTimer() {
    _timer?.cancel();
    remainingSeconds = 60;
    canResend = false;
    notifyListeners();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        remainingSeconds--;
        notifyListeners();
      } else {
        timer.cancel();
        canResend = true;
        notifyListeners();
      }
    });
  }

  void verifyOTP(BuildContext context) {
    final otp = otpController.text.trim();
    if (otp.length == 4) {
      authBloc.add(VerifyOTPRequested(otp));
    }
  }

  void resendOTP(BuildContext context) {
    if (!canResend) return;

    otpController.clear();
    otpFocusNode.requestFocus();
    startTimer();
    AppSnackBar.success(context, AppStrings.otpSentSuccess);
  }

  String formatTime() {
    final m = remainingSeconds ~/ 60;
    final s = remainingSeconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    otpController.dispose();
    otpFocusNode.dispose();
    super.dispose();
  }
}
