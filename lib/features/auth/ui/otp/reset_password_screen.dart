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
import 'package:pdi_dost/features/auth/ui/login/login_screen.dart';
import '../../bloc/auth/auth_bloc.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _password = FieldController();
  final _confirmPassword = FieldController();
  final _formKey = GlobalKey<FormState>();
  bool _isFormValid = false;

  void _validateForm() {
    final isPasswordValid =
        FormValidators.password(_password.text.text.trim(), minLength: 6) ==
        null;
    final isConfirmPasswordValid =
        FormValidators.passwordMatch(
          _confirmPassword.text.text.trim(),
          _password.text.text.trim(),
        ) ==
        null;

    final isValid = isPasswordValid && isConfirmPasswordValid;

    if (isValid != _isFormValid) {
      setState(() => _isFormValid = isValid);
    }
  }

  void _onResetPassword() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        ResetPasswordRequested(_password.text.text.trim()),
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
        successStateType: PasswordReset,
        failureStateType: AuthFailure,
        errorExtractor: (state) => (state as AuthFailure).message,
        showSuccessDialog: true,
        successTitle: AppStrings.passwordResetSuccessful,
        successMessage: AppStrings.passwordResetMsg,
        onSuccess: () {
          AppNav.pushAndRemoveUntil(context, const LoginScreen());
        },
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header Icon
                  FadeInDown(
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.all(24.r),
                        decoration: BoxDecoration(
                          color: theme.primaryColor.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.lock_open_rounded,
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
                          AppStrings.createNewPassword,
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
                            AppStrings.createNewPasswordSubtitle,
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
                            label: AppStrings.newPassword,
                            controller: _password.text,
                            focusNode: _password.focus,
                            hint: AppStrings.newPasswordHint,
                            isRequired: true,
                            variant: FieldVariant.password,
                            prefix: const Icon(
                              Icons.lock_outline_rounded,
                              size: 20,
                            ),
                            validator: (v) =>
                                FormValidators.password(v, minLength: 6),
                            onChanged: (_) => _validateForm(),
                            helperText: AppStrings.min6Chars,
                          ),
                          SizedBox(height: 24.h),
                          AppField(
                            label: AppStrings.confirmNewPassword,
                            controller: _confirmPassword.text,
                            focusNode: _confirmPassword.focus,
                            hint: AppStrings.confirmNewPasswordHint,
                            isRequired: true,
                            variant: FieldVariant.password,
                            prefix: const Icon(
                              Icons.lock_outline_rounded,
                              size: 20,
                            ),
                            validator: (v) => FormValidators.passwordMatch(
                              v,
                              _password.text.text,
                            ),
                            onChanged: (_) => _validateForm(),
                            helperText: AppStrings.mustMatchPassword,
                          ),
                          SizedBox(height: 20.h),

                          // Reset Button
                          BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              return AppButton(
                                text: AppStrings.resetPassword,
                                isEnabled:
                                    _isFormValid && state is! AuthLoading,
                                // isLoading: state is AuthLoading,
                                onPressed: _onResetPassword,
                                borderRadius: 15.r,
                                height: 56.h,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Back to Login
                  FadeInUp(
                    delay: const Duration(milliseconds: 600),
                    child: Center(
                      child: AppTextButton(
                        text: AppStrings.backToLogin,
                        fontWeight: FontWeight.w800,
                        textColor: theme.primaryColor,
                        onPressed: () {
                          AppNav.pushAndRemoveUntil(
                            context,
                            const LoginScreen(),
                          );
                        },
                      ),
                    ),
                  ),
                  // SizedBox(height: 20.h),
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
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }
}
