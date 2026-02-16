import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdi_dost/core/constants/app_strings.dart';
import 'package:pdi_dost/core/widgets/api_state_bloc_listener.dart';
import 'package:pdi_dost/core/widgets/app_button.dart';
import 'package:pdi_dost/core/widgets/app_text_field.dart';
import 'package:pdi_dost/core/widgets/common_scaffold.dart';
import 'package:pdi_dost/core/widgets/form_validation_helper.dart';
import 'package:pdi_dost/features/auth/bloc/auth/auth_bloc.dart';
import 'package:pdi_dost/features/profile/controller/change_password_controller.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late ChangePasswordController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ChangePasswordController(authBloc: context.read<AuthBloc>());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      showAppBar: true,
      title: AppStrings.changePassword,
      // appBar: Toolbar.simple(context, title: AppStrings.changePassword),
      body: ApiStateBlocListener<AuthBloc, AuthState>(
        loadingStateType: AuthLoading,
        successStateType: PasswordChanged,
        failureStateType: AuthFailure,
        errorExtractor: (state) => (state as AuthFailure).message,
        autoPopOnSuccess: false,
        onSuccess: () => Navigator.pop(context),
        showSuccessDialog: true,
        successMessage: AppStrings.passwordChangedSuccess,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.r),
          child: Form(
            key: _controller.formKey,
            // autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // FadeInDown(
                //   child: Text(
                //     AppStrings.createNewPasswordSubtitle,
                //     style: TextStyle(
                //       fontSize: 16.sp,
                //       color: Colors.grey,
                //       height: 1.5,
                //     ),
                //   ),
                // ),
                // SizedBox(height: 32.h),
                // Current Password
                FadeInLeft(
                  child: AppField(
                    label: AppStrings.currentPassword,
                    controller: _controller.currentPassword.text,
                    focusNode: _controller.currentPassword.focus,
                    hint: AppStrings.currentPasswordHint,
                    isRequired: true,
                    variant: FieldVariant.password,
                    prefix: const Icon(Icons.lock_outline_rounded),
                    validator: (v) => (v == null || v.isEmpty)
                        ? ValidationStrings.passwordRequired
                        : null,
                    onChanged: (_) => _controller.validateForm(),
                  ),
                ),
                SizedBox(height: 20.h),
                // New Password
                FadeInLeft(
                  delay: const Duration(milliseconds: 100),
                  child: AppField(
                    label: AppStrings.newPassword,
                    controller: _controller.newPassword.text,
                    focusNode: _controller.newPassword.focus,
                    hint: AppStrings.newPasswordHint,
                    isRequired: true,
                    variant: FieldVariant.password,
                    prefix: const Icon(Icons.lock_reset_rounded),
                    validator: (v) {
                      final res = FormValidators.password(v);
                      return res;
                    },
                    onChanged: (_) => _controller.validateForm(),
                  ),
                ),
                SizedBox(height: 20.h),
                // Confirm Password
                FadeInLeft(
                  delay: const Duration(milliseconds: 200),
                  child: AppField(
                    label: AppStrings.confirmNewPassword,
                    controller: _controller.confirmPassword.text,
                    focusNode: _controller.confirmPassword.focus,
                    hint: AppStrings.confirmNewPasswordHint,
                    isRequired: true,
                    variant: FieldVariant.password,
                    prefix: const Icon(Icons.lock_clock_outlined),
                    validator: (v) {
                      if (v != _controller.newPassword.text.text) {
                        return ValidationStrings.passwordsDoNotMatch;
                      }
                      return null;
                    },
                    onChanged: (_) => _controller.validateForm(),
                  ),
                ),
                SizedBox(height: 48.h),

                // Submit Button
                FadeInUp(
                  child: ListenableBuilder(
                    listenable: _controller,
                    builder: (context, _) {
                      return BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return AppButton(
                            text: AppStrings.saveChanges,
                            isEnabled: _controller.isFormValid,
                            isLoading: state is AuthLoading,
                            onPressed: _controller.onSubmit,
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
