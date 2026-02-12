import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdi_dost/core/widgets/api_state_bloc_listener.dart';
import 'package:pdi_dost/core/widgets/app_button.dart';
import 'package:pdi_dost/core/widgets/app_text_field.dart';
import 'package:pdi_dost/core/widgets/form_validation_helper.dart';
import '../bloc/auth_bloc.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _name = FieldController();
  final _email = FieldController();
  final _formKey = GlobalKey<FormState>();
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();

    final prefs = context.read<AuthBloc>().sharedPreferences;
    _name.text.text = prefs.getString('USER_NAME') ?? '';
    _email.text.text = prefs.getString('USER_EMAIL') ?? '';

    // Validate initial state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _validateForm();
    });
  }

  void _validateForm() {
    final isNameValid =
        FormValidators.required(
          _name.text.text.trim(),
          message: 'Name is required',
        ) ==
        null;
    final isEmailValid = FormValidators.email(_email.text.text.trim()) == null;

    final isValid = isNameValid && isEmailValid;

    if (isValid != _isFormValid) {
      setState(() => _isFormValid = isValid);
    }
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        UpdateProfileRequested(
          name: _name.text.text.trim(),
          email: _email.text.text.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile'), centerTitle: true),
      body: ApiStateBlocListener<AuthBloc, AuthState>(
        loadingStateType: AuthLoading,
        successStateType: AuthAuthenticated,
        failureStateType: AuthFailure,
        errorExtractor: (state) => (state as AuthFailure).message,
        autoPopOnSuccess: true,
        showSuccessDialog: true,
        successMessage: 'Your profile has been updated successfully.',
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Text(
                  'Personal Information',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Update your personal details below',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: 30.h),

                // Name Field
                AppField(
                  label: 'Full Name',
                  controller: _name.text,
                  focusNode: _name.focus,
                  hint: 'Enter your full name',
                  isRequired: true,
                  prefix: const Icon(Icons.person_outline),
                  keyboardType: TextInputType.name,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => FormValidators.required(
                    value,
                    message: 'Name is required',
                  ),
                  onChanged: (_) => _validateForm(),
                  helperText: 'This name will be displayed on your profile',
                ),
                SizedBox(height: 20.h),

                // Email Field
                AppField(
                  label: 'Email Address',
                  controller: _email.text,
                  focusNode: _email.focus,
                  hint: 'Enter your email',
                  isRequired: true,
                  prefix: const Icon(Icons.email_outlined),
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FormValidators.email,
                  onChanged: (_) => _validateForm(),
                  helperText: 'We\'ll send important updates to this email',
                ),
                SizedBox(height: 40.h),
                // Submit Button with validation-based styling
                AppButton(
                  text: 'Save Changes',
                  icon: Icons.check_circle_outline,
                  isEnabled: _isFormValid,
                  onPressed: _onSubmit,
                ),
                SizedBox(height: 16.h),
                // Cancel Button
                AppOutlinedButton(
                  text: 'Cancel',
                  icon: Icons.close,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    super.dispose();
  }
}
