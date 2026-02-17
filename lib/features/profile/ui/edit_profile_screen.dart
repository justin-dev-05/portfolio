import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdi_dost/core/constants/app_strings.dart';
import 'package:pdi_dost/core/utils/app_nav.dart';
import 'package:pdi_dost/core/widgets/api_state_bloc_listener.dart';
import 'package:pdi_dost/core/widgets/app_button.dart';
import 'package:pdi_dost/core/widgets/app_text_field.dart';
import 'package:pdi_dost/core/widgets/common_scaffold.dart';
import 'package:pdi_dost/core/widgets/form_validation_helper.dart';
import 'package:pdi_dost/features/auth/bloc/auth/auth_bloc.dart';
import 'package:pdi_dost/core/widgets/toolbar.dart';

import 'package:pdi_dost/features/profile/controller/edit_profile_controller.dart';
import 'package:pdi_dost/features/profile/widgets/profile_widgets.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late EditProfileController _controller;

  @override
  void initState() {
    super.initState();
    _controller = EditProfileController(authBloc: context.read<AuthBloc>());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      showAppBar: false,
      appBar: Toolbar.simple(context, title: AppStrings.editProfile),
      body: ApiStateBlocListener<AuthBloc, AuthState>(
        loadingStateType: AuthLoading,
        successStateType: AuthAuthenticated,
        failureStateType: AuthFailure,
        errorExtractor: (state) => (state as AuthFailure).message,
        autoPopOnSuccess: false,
        onSuccess: () => AppNav.pop(context),
        showSuccessDialog: true,
        successMessage: AppStrings.profileUpdatedSuccess,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [
              ProfileHeader(showText: false),
              SizedBox(height: 30.h),
              Form(
                key: _controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    // Text(
                    //   AppStrings.personalInformation,
                    //   style: TextStyle(
                    //     fontSize: 20.sp,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    // SizedBox(height: 8.h),
                    // Text(
                    //   AppStrings.updatePersonalDetails,
                    //   style: TextStyle(
                    //     fontSize: 14.sp,
                    //     color: Colors.grey.shade600,
                    //   ),
                    // ),
                    SizedBox(height: 10.h),
                    // Name Field
                    AppField(
                      label: AppStrings.fullName,
                      controller: _controller.name.text,
                      focusNode: _controller.name.focus,
                      hint: AppStrings.fullNameHint,
                      isRequired: true,
                      prefix: const Icon(Icons.person_outline),
                      keyboardType: TextInputType.name,
                      // autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => FormValidators.required(
                        value,
                        message: ValidationStrings.nameRequired,
                      ),
                      onChanged: (_) => _controller.validateForm(),
                      helperText: AppStrings.nameHelperProfile,
                    ),
                    SizedBox(height: 20.h),

                    // Email Field
                    AppField(
                      label: AppStrings.emailAddress,
                      controller: _controller.email.text,
                      focusNode: _controller.email.focus,
                      hint: AppStrings.emailHint,
                      isRequired: true,
                      prefix: const Icon(Icons.email_outlined),
                      keyboardType: TextInputType.emailAddress,
                      // autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: FormValidators.email,
                      onChanged: (_) => _controller.validateForm(),
                      helperText: AppStrings.emailUpdates,
                    ),
                    SizedBox(height: 40.h),
                    // Submit Button with validation-based styling
                    ListenableBuilder(
                      listenable: _controller,
                      builder: (context, _) {
                        return AppButton(
                          text: AppStrings.saveChanges,
                          // icon: Icons.check_circle_outline,
                          isEnabled: _controller.isFormValid,
                          onPressed: _controller.onSubmit,
                        );
                      },
                    ),
                    // SizedBox(height: 16.h),
                    // // Cancel Button
                    // AppOutlinedButton(
                    //   text: AppStrings.cancel,
                    //   icon: Icons.close,
                    //   onPressed: () => AppNav.pop(context),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
