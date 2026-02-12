import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdi_dost/core/constants/app_colors.dart';
import 'package:pdi_dost/core/widgets/app_button.dart';
import 'package:pdi_dost/core/widgets/app_text_field.dart';
import 'package:pdi_dost/core/widgets/common_scaffold.dart';
import 'package:pdi_dost/core/widgets/form_validation_helper.dart';
import '../bloc/auth_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _name = FieldController();
  final _email = FieldController();
  final _password = FieldController();
  final _formKey = GlobalKey<FormState>();
  bool _isFormValid = false;

  void _validateForm() {
    final isNameValid =
        FormValidators.required(
          _name.text.text.trim(),
          message: 'Name is required',
        ) ==
        null;
    final isEmailValid = FormValidators.email(_email.text.text.trim()) == null;
    final isPasswordValid =
        FormValidators.password(_password.text.text.trim(), minLength: 6) ==
        null;

    final isValid = isNameValid && isEmailValid && isPasswordValid;

    if (isValid != _isFormValid) {
      setState(() => _isFormValid = isValid);
    }
  }

  void _onRegister() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        AuthLoginRequested(_email.text.text.trim(), _password.text.text.trim()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            // Navigator.pushAndRemoveUntil(
            //   context,
            //   MaterialPageRoute(builder: (_) => const DashboardScreen()),
            //   (route) => false,
            // );
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 50.h),
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  FadeInDown(
                    child: Text(
                      'Create Account',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  FadeInDown(
                    delay: const Duration(milliseconds: 200),
                    child: Text(
                      'Join us and start organizing your life like a pro.',
                      style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                    ),
                  ),
                  SizedBox(height: 50.h),

                  // Name Field
                  FadeInLeft(
                    child: AppField(
                      label: 'Full Name',
                      controller: _name.text,
                      focusNode: _name.focus,
                      hint: 'Enter your full name',
                      isRequired: true,
                      prefix: const Icon(Icons.person_outline),
                      keyboardType: TextInputType.name,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (v) => FormValidators.required(
                        v,
                        message: 'Name is required',
                      ),
                      onChanged: (_) => _validateForm(),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Email Field
                  FadeInLeft(
                    delay: const Duration(milliseconds: 100),
                    child: AppField(
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
                  ),
                  SizedBox(height: 20.h),

                  // Password Field
                  FadeInLeft(
                    delay: const Duration(milliseconds: 200),
                    child: AppField(
                      label: 'Password',
                      controller: _password.text,
                      focusNode: _password.focus,
                      hint: 'Create a strong password',
                      isRequired: true,
                      variant: FieldVariant.password,
                      prefix: const Icon(Icons.lock_outline_rounded),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (v) =>
                          FormValidators.password(v, minLength: 6),
                      onChanged: (_) => _validateForm(),
                      helperText: 'Minimum 6 characters, letters and numbers',
                    ),
                  ),
                  SizedBox(height: 40.h),

                  // Register Button with auto-enable/disable
                  FadeInUp(
                    child: BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return AppButton(
                          text: 'Create Account',
                          icon: Icons.person_add_outlined,
                          isEnabled: _isFormValid && state is! AuthLoading,
                          isLoading: state is AuthLoading,
                          onPressed: _onRegister,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 30.h),

                  // Login Link
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        AppTextButton(
                          text: 'Login',
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
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
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
}
