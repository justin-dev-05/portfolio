import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdi_dost/core/constants/app_colors.dart';
import 'package:pdi_dost/core/utils/app_nav.dart';
import 'package:pdi_dost/core/constants/app_strings.dart';
import 'package:pdi_dost/core/widgets/api_state_bloc_listener.dart';
import 'package:pdi_dost/core/widgets/app_button.dart';
import 'package:pdi_dost/core/widgets/app_text_field.dart';
import 'package:pdi_dost/core/widgets/common_scaffold.dart';
import 'package:pdi_dost/core/widgets/form_validation_helper.dart';
import 'package:pdi_dost/features/auth/ui/otp/otp_verification_screen.dart';
import '../../bloc/auth/auth_bloc.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _email = FieldController();
  final _formKey = GlobalKey<FormState>();
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthResetStateRequested());
  }

  void _validateForm() {
    final isEmailValid = FormValidators.email(_email.text.text.trim()) == null;

    if (isEmailValid != _isFormValid) {
      setState(() => _isFormValid = isEmailValid);
    }
  }

  void _onSendOTP() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        ForgotPasswordRequested(_email.text.text.trim()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return CommonScaffold(
      showAppBar: true,
      body: ApiStateBlocListener<AuthBloc, AuthState>(
        loadingStateType: AuthLoading,
        successStateType: OTPSent,
        failureStateType: AuthFailure,
        errorExtractor: (state) => (state as AuthFailure).message,
        onSuccess: () {
          final state = context.read<AuthBloc>().state;
          if (state is OTPSent) {
            AppNav.push(context, OTPVerificationScreen(email: state.email));
          }
        },
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Icon Header
                  FadeInDown(
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.all(20.r),
                        decoration: BoxDecoration(
                          color: theme.primaryColor.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.lock_reset_rounded,
                          size: 50.sp,
                          color: theme.primaryColor,
                        ),
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
                          AppStrings.forgotPassword,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            fontSize: 25.sp,
                            color: isDark
                                ? AppColors.white
                                : AppColors.textPrimaryLight,
                            letterSpacing: -0.5,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Text(
                            AppStrings.forgotPasswordSubtitle,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: isDark
                                  ? AppColors.textSecondaryDark
                                  : AppColors.textSecondaryLight,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Input Card
                  FadeInUp(
                    delay: const Duration(milliseconds: 400),
                    child: Container(
                      padding: EdgeInsets.all(24.r),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.surfaceDark.withValues(alpha: 0.6)
                            : AppColors.white,
                        borderRadius: BorderRadius.circular(30.r),
                        border: Border.all(
                          color: isDark
                              ? AppColors.white.withValues(alpha: 0.05)
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
                          AppField(
                            label: AppStrings.emailAddress,
                            controller: _email.text,
                            focusNode: _email.focus,
                            hint: AppStrings.emailHintRegistered,
                            isRequired: true,
                            prefix: const Icon(Icons.email_rounded, size: 20),
                            keyboardType: TextInputType.emailAddress,
                            validator: FormValidators.email,
                            onChanged: (_) => _validateForm(),
                            helperText: AppStrings.sendOTPHelper,
                          ),
                          SizedBox(height: 32.h),

                          // Send OTP Button
                          BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              return AppButton(
                                text: AppStrings.sendOTP,
                                isEnabled:
                                    _isFormValid && state is! AuthLoading,
                                // isLoading: state is AuthLoading,
                                onPressed: _onSendOTP,
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

                  // Back to Login
                  FadeInUp(
                    delay: const Duration(milliseconds: 600),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.rememberPassword,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white70
                                : AppColors.textSecondaryLight,
                            fontSize: 14.sp,
                          ),
                        ),
                        AppTextButton(
                          text: AppStrings.login,
                          fontWeight: FontWeight.w800,
                          textColor: theme.primaryColor,
                          onPressed: () => AppNav.pop(context),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
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
    _email.dispose();
    super.dispose();
  }
}
