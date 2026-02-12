import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdi_dost/core/utils/app_snackbar.dart';
import 'package:pdi_dost/core/widgets/app_button.dart';
import 'package:pdi_dost/core/widgets/app_dialog.dart';
import 'package:pdi_dost/core/widgets/app_text_field.dart';
import 'package:pdi_dost/core/widgets/common_scaffold.dart';
import 'package:pdi_dost/core/widgets/form_validation_helper.dart';
import 'package:pdi_dost/features/auth/ui/login_screen.dart';
import '../bloc/auth_bloc.dart';

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
    return CommonScaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is PasswordReset) {
            AppDialogs.showMessage(
              context: context,
              title: 'Password Reset Successful!',
              message:
                  'Your password has been successfully reset. You can now login with your new password.',
              positiveButton: 'Go to Login',
              icon: Icons.check_circle_outline_rounded,
              iconColor: Colors.green,
              callback: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              },
            );
          } else if (state is AuthFailure) {
            AppSnackBar.error(context, state.message);
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(30.r),
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(height: 50.h),
                  // // Back Button
                  // FadeInLeft(
                  //   child: IconButton(
                  //     onPressed: () => Navigator.pop(context),
                  //     icon: const Icon(Icons.arrow_back_ios_rounded),
                  //   ),
                  // ),
                  // SizedBox(height: 20.h),

                  // Header
                  FadeInDown(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Container(
                        //   padding: EdgeInsets.all(16.r),
                        //   decoration: BoxDecoration(
                        //     gradient: LinearGradient(
                        //       colors: [
                        //         AppColors.success,
                        //         AppColors.success.withValues(alpha: 0.7),
                        //       ],
                        //       begin: Alignment.topLeft,
                        //       end: Alignment.bottomRight,
                        //     ),
                        //     borderRadius: BorderRadius.circular(16.r),
                        //     boxShadow: [
                        //       BoxShadow(
                        //         color: AppColors.success.withValues(alpha: 0.3),
                        //         blurRadius: 20,
                        //         offset: const Offset(0, 8),
                        //       ),
                        //     ],
                        //   ),
                        //   child: Icon(
                        //     Icons.lock_open_rounded,
                        //     size: 40.sp,
                        //     color: Colors.white,
                        //   ),
                        // ),
                        // SizedBox(height: 20.h),
                        Text(
                          'Create New Password',
                          style: Theme.of(context).textTheme.displaySmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          'Your new password must be different from previous used passwords.',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey.shade600,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: 10.h),
                  // Password Requirements
                  // FadeInLeft(
                  //   delay: const Duration(milliseconds: 100),
                  //   child: Container(
                  //     padding: EdgeInsets.all(16.r),
                  //     decoration: BoxDecoration(
                  //       color: Colors.blue.shade50,
                  //       borderRadius: BorderRadius.circular(12.r),
                  //       border: Border.all(color: Colors.blue.shade200),
                  //     ),
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Row(
                  //           children: [
                  //             Icon(
                  //               Icons.info_outline_rounded,
                  //               color: Colors.blue.shade600,
                  //               size: 20.sp,
                  //             ),
                  //             SizedBox(width: 8.w),
                  //             Text(
                  //               'Password Requirements:',
                  //               style: TextStyle(
                  //                 fontSize: 14.sp,
                  //                 fontWeight: FontWeight.w600,
                  //                 color: Colors.blue.shade600,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //         SizedBox(height: 8.h),
                  //         ...[
                  //           'At least 6 characters',
                  //           'Include letters and numbers',
                  //           'Cannot be same as email',
                  //         ].map(
                  //           (requirement) => Padding(
                  //             padding: EdgeInsets.only(left: 28.w, top: 4.h),
                  //             child: Row(
                  //               children: [
                  //                 Icon(
                  //                   Icons.check_circle_outline_rounded,
                  //                   color: Colors.blue.shade400,
                  //                   size: 16.sp,
                  //                 ),
                  //                 SizedBox(width: 8.w),
                  //                 Text(
                  //                   requirement,
                  //                   style: TextStyle(
                  //                     fontSize: 12.sp,
                  //                     color: Colors.blue.shade700,
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 30.h),
                  // New Password Field
                  FadeInLeft(
                    delay: const Duration(milliseconds: 200),
                    child: AppField(
                      label: 'New Password',
                      controller: _password.text,
                      focusNode: _password.focus,
                      hint: 'Enter your new password',
                      isRequired: true,
                      variant: FieldVariant.password,
                      prefix: const Icon(Icons.lock_outline_rounded),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (v) =>
                          FormValidators.password(v, minLength: 6),
                      onChanged: (_) => _validateForm(),
                      helperText: 'Minimum 6 characters',
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Confirm Password Field
                  FadeInLeft(
                    delay: const Duration(milliseconds: 300),
                    child: AppField(
                      label: 'Confirm New Password',
                      controller: _confirmPassword.text,
                      focusNode: _confirmPassword.focus,
                      hint: 'Confirm your new password',
                      isRequired: true,
                      variant: FieldVariant.password,
                      prefix: const Icon(Icons.lock_outline_rounded),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (v) =>
                          FormValidators.passwordMatch(v, _password.text.text),
                      onChanged: (_) => _validateForm(),
                      helperText: 'Must match the new password',
                    ),
                  ),
                  SizedBox(height: 40.h),

                  // Reset Password Button
                  FadeInUp(
                    delay: const Duration(milliseconds: 400),
                    child: BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return AppButton(
                          text: 'Reset Password',
                          icon: Icons.lock_reset_rounded,
                          isEnabled: _isFormValid && state is! AuthLoading,
                          isLoading: state is AuthLoading,
                          onPressed: _onResetPassword,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 30.h),

                  // Back to Login
                  Center(
                    child: FadeInUp(
                      delay: const Duration(milliseconds: 500),
                      child: TextButton.icon(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginScreen(),
                            ),
                            (route) => false,
                          );
                        },
                        icon: const Icon(Icons.arrow_back_rounded, size: 16),
                        label: Text(
                          'Back to Login',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
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
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }
}
