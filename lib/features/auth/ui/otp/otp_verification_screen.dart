import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdi_dost/core/utils/app_nav.dart';
import 'package:pdi_dost/core/widgets/api_state_bloc_listener.dart';
import 'package:pdi_dost/core/constants/app_colors.dart';
import 'package:pdi_dost/core/constants/app_strings.dart';
import 'package:pdi_dost/core/widgets/app_button.dart';
import 'package:pdi_dost/core/widgets/common_scaffold.dart';
import 'package:pdi_dost/core/theme/otp_theme.dart';
import 'package:pdi_dost/features/auth/controller/otp_controller.dart';
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
  late OTPController _controller;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _controller = OTPController(
      authBloc: context.read<AuthBloc>(),
      email: widget.email,
    );

    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return CommonScaffold(
      showAppBar: true,
      body: ApiStateBlocListener<AuthBloc, AuthState>(
        loadingStateType: AuthLoading,
        successStateType: OTPVerified,
        failureStateType: AuthFailure,
        errorExtractor: (state) => (state as AuthFailure).message,
        onSuccess: () {
          AppNav.replace(context, const ResetPasswordScreen());
        },
        onFailure: () {
          _controller.otpController.clear();
          _controller.otpFocusNode.requestFocus();
        },
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: ListenableBuilder(
              listenable: _controller,
              builder: (context, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header Icon with Pulsing Effect
                    FadeInDown(
                      child: Center(
                        child: AnimatedBuilder(
                          animation: _pulseController,
                          builder: (context, child) {
                            return Container(
                              padding: EdgeInsets.all(24.r),
                              decoration: BoxDecoration(
                                color: theme.primaryColor.withValues(
                                  alpha: 0.1,
                                ),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: theme.primaryColor.withValues(
                                      alpha: 0.1 * _pulseController.value,
                                    ),
                                    blurRadius: 20 * _pulseController.value,
                                    spreadRadius: 10 * _pulseController.value,
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.mark_email_read_rounded,
                                size: 50.sp,
                                color: theme.primaryColor,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),

                    // Texts
                    FadeInDown(
                      delay: const Duration(milliseconds: 200),
                      child: Column(
                        children: [
                          Text(
                            AppStrings.verifyEmail,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: 25.sp,
                              color: isDark
                                  ? Colors.white
                                  : AppColors.textPrimaryLight,
                              letterSpacing: -0.5,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Text.rich(
                              textAlign: TextAlign.center,
                              TextSpan(
                                text: '${AppStrings.otpVerificationSubtitle}\n',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: isDark
                                      ? AppColors.textSecondaryDark
                                      : AppColors.textSecondaryLight,
                                  height: 1.5,
                                ),
                                children: [
                                  TextSpan(
                                    text: widget.email,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: theme.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // OTP Card
                    FadeInUp(
                      delay: const Duration(milliseconds: 400),
                      child: Container(
                        padding: EdgeInsets.all(24.r),
                        decoration: BoxDecoration(
                          color: isDark
                              ? AppColors.surfaceDark.withValues(alpha: 0.6)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(30.r),
                          border: Border.all(
                            color: isDark
                                ? Colors.white.withValues(alpha: 0.05)
                                : AppColors.primaryLight.withValues(alpha: 0.1),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Pinput(
                              length: 4,
                              controller: _controller.otpController,
                              focusNode: _controller.otpFocusNode,
                              autofocus: true,
                              keyboardType: TextInputType.number,
                              hapticFeedbackType:
                                  HapticFeedbackType.lightImpact,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              defaultPinTheme: OTPTheme.defaultPinTheme(
                                context,
                              ),
                              focusedPinTheme: OTPTheme.focusedPinTheme(
                                context,
                              ),
                              submittedPinTheme: OTPTheme.submittedPinTheme(
                                context,
                              ),
                              onChanged: _controller.onPinChanged,
                            ),
                            SizedBox(height: 20.h),

                            // Timer & Resend
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _controller.canResend
                                      ? AppStrings.didntReceiveCode
                                      : '${AppStrings.resendCodeIn} ${_controller.formatTime()}',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: isDark
                                        ? AppColors.textSecondaryDark
                                        : AppColors.textSecondaryLight,
                                  ),
                                ),
                                if (_controller.canResend) ...[
                                  // SizedBox(width: 1.w),
                                  AppTextButton(
                                    text: AppStrings.resendOTPString,
                                    fontWeight: FontWeight.w800,
                                    textColor: theme.primaryColor,
                                    onPressed: () =>
                                        _controller.resendOTP(context),
                                  ),
                                ],
                              ],
                            ),
                            SizedBox(height: 24.h),

                            // Verify Button
                            BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                final isFilled =
                                    _controller.otpController.text
                                        .trim()
                                        .length ==
                                    4;
                                return AppButton(
                                  text: AppStrings.verifyOTP,
                                  isEnabled: isFilled && state is! AuthLoading,
                                  // isLoading: state is AuthLoading,
                                  onPressed: isFilled
                                      ? () => _controller.verifyOTP(context)
                                      : null,
                                  borderRadius: 15.r,
                                  height: 56.h,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 32.h),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
