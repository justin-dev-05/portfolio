import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdi_dost/core/utils/app_nav.dart';
import 'package:pdi_dost/core/constants/app_colors.dart';
import 'package:pdi_dost/core/constants/app_strings.dart';
import 'package:pdi_dost/core/widgets/app_button.dart';
import 'package:pdi_dost/core/widgets/common_scaffold.dart';
import 'package:pdi_dost/features/auth/ui/otp/reset_password_screen.dart';
import 'package:pinput/pinput.dart';
import '../../bloc/auth/auth_bloc.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String email;

  const OTPVerificationScreen({super.key, required this.email});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen>
    with TickerProviderStateMixin {
  // OTP
  final _otpController = TextEditingController();
  final _otpFocusNode = FocusNode();

  // Timer
  Timer? _timer;
  int _remainingSeconds = 60;
  bool _canResend = false;

  // Animations
  late AnimationController _pulseController;
  late AnimationController _slideController;

  @override
  void initState() {
    super.initState();
    _startTimer();

    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  // ⏱ Timer logic
  void _startTimer() {
    _timer?.cancel();
    _remainingSeconds = 60;
    _canResend = false;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      } else {
        timer.cancel();
        setState(() => _canResend = true);
      }
    });
  }

  // ✅ Verify OTP
  void _verifyOTP() {
    final otp = _otpController.text.trim();
    if (otp.length == 4) {
      context.read<AuthBloc>().add(VerifyOTPRequested(otp));
    }
  }

  // 🔁 Resend OTP
  void _resendOTP() {
    if (!_canResend) return;

    _otpController.clear();
    _otpFocusNode.requestFocus();
    _startTimer();

    _slideController.forward().then((_) => _slideController.reverse());

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(AppStrings.otpSentSuccess),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  String _formatTime(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is OTPVerified) {
            AppNav.replace(context, const ResetPasswordScreen());
          } else if (state is AuthFailure) {
            _otpController.clear();
            _otpFocusNode.requestFocus();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.error,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(30.r),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FadeInDown(
                    child: AnimatedBuilder(
                      animation: _pulseController,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: 1 + (_pulseController.value * 0.08),
                          child: Container(
                            padding: EdgeInsets.all(24.r),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.primaryLight,
                                  AppColors.primaryLight.withValues(alpha: 0.7),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(24.r),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primaryLight.withValues(
                                    alpha: 0.3,
                                  ),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.verified_user_rounded,
                              size: 48.sp,
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 30.h),

                  // Header
                  FadeInDown(
                    delay: const Duration(milliseconds: 200),
                    child: Column(
                      children: [
                        Text(
                          AppStrings.verifyEmail,
                          style: Theme.of(context).textTheme.displaySmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          '${AppStrings.otpVerificationSubtitle}\n${widget.email}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey.shade600,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 40.h),

                  // 🔐 OTP INPUT (Pinput)
                  FadeInUp(
                    delay: const Duration(milliseconds: 300),
                    child: Pinput(
                      length: 4,
                      controller: _otpController,
                      focusNode: _otpFocusNode,
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      hapticFeedbackType: HapticFeedbackType.lightImpact,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      defaultPinTheme: PinTheme(
                        width: 50.w,
                        height: 55.h,
                        textStyle: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 2,
                          ),
                        ),
                      ),

                      focusedPinTheme: PinTheme(
                        width: 50.w,
                        height: 55.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: AppColors.primaryLight,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryLight.withValues(
                                alpha: 0.2,
                              ),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),

                      submittedPinTheme: PinTheme(
                        width: 50.w,
                        height: 55.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: AppColors.primaryLight.withValues(
                              alpha: 0.6,
                            ),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 40.h),

                  // ⏳ Timer & Resend
                  FadeInUp(
                    delay: const Duration(milliseconds: 400),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.access_time_rounded,
                              size: 20.sp,
                              color: _canResend
                                  ? Colors.grey
                                  : AppColors.primaryLight,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              _canResend
                                  ? AppStrings.didntReceiveCode
                                  : '${AppStrings.resendCodeIn} ${_formatTime(_remainingSeconds)}',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: _canResend
                                    ? Colors.grey.shade600
                                    : AppColors.primaryLight,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        if (_canResend)
                          AppOutlinedButton(
                            text: AppStrings.resendOTPString,
                            icon: Icons.refresh_rounded,
                            onPressed: _resendOTP,
                          ),
                      ],
                    ),
                  ),

                  SizedBox(height: 40.h),

                  // Verify Button
                  FadeInUp(
                    delay: const Duration(milliseconds: 500),
                    child: BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        final isFilled = _otpController.text.length == 4;

                        return AppButton(
                          text: AppStrings.verifyOTP,
                          icon: Icons.check_circle_rounded,
                          isEnabled: isFilled && state is! AuthLoading,
                          isLoading: state is AuthLoading,
                          onPressed: isFilled ? _verifyOTP : null,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pulseController.dispose();
    _slideController.dispose();
    _otpController.dispose();
    _otpFocusNode.dispose();
    super.dispose();
  }
}
