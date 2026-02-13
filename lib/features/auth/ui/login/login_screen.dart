import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdi_dost/core/constants/app_strings.dart';
import 'package:pdi_dost/core/constants/assets_constant.dart';
import 'package:pdi_dost/core/utils/app_nav.dart';
import 'package:pdi_dost/core/widgets/app_button.dart';
import 'package:pdi_dost/core/widgets/app_text_field.dart';
import 'package:pdi_dost/core/widgets/common_scaffold.dart';
import 'package:pdi_dost/core/widgets/form_validation_helper.dart';
import 'package:pdi_dost/features/auth/ui/forgot_password/forgot_password_screen.dart';
import 'package:pdi_dost/features/dashboard/ui/dashboard_screen.dart';
import 'package:pdi_dost/features/auth/controller/login_controller.dart';
import '../../bloc/auth/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginController _controller;

  @override
  void initState() {
    super.initState();
    _controller = LoginController(authBloc: context.read<AuthBloc>());
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
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          AppNav.replace(context, const DashboardScreen());
          // if (state is AuthAuthenticated) {
          //   Navigator.pushReplacement(
          //     context,
          //     MaterialPageRoute(builder: (_) => const DashboardScreen()),
          //   );
          // } else if (state is AuthFailure) {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(
          //       content: Text(state.message),
          //       backgroundColor: AppColors.error,
          //     ),
          //   );
          // }
        },
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(left: 30.r, right: 30.r),
            child: Form(
              key: _controller.formKey,
              child: Column(
                crossAxisAlignment: .center,
                mainAxisAlignment: .center,
                children: [
                  // App Logo
                  Center(
                    child: FadeInDown(
                      child: Image.asset(
                        AppAssets.appLogo,
                        height: 120.h,
                        width: 120.h,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  // SizedBox(height: 1.h),
                  // Header
                  FadeInDown(
                    child: Text(
                      AppStrings.welcomeBack,
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
                      AppStrings.loginSubTitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  // Email Field
                  FadeInLeft(
                    child: AppField(
                      label: AppStrings.emailAddress,
                      controller: _controller.email.text,
                      focusNode: _controller.email.focus,
                      hint: AppStrings.emailHint,
                      isRequired: true,
                      prefix: const Icon(Icons.email_outlined),
                      keyboardType: TextInputType.emailAddress,
                      validator: FormValidators.email,
                      onChanged: (_) => _controller.validateForm(),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  // Password Field
                  FadeInLeft(
                    child: AppField(
                      label: AppStrings.password,
                      controller: _controller.password.text,
                      focusNode: _controller.password.focus,
                      hint: AppStrings.passwordHint,
                      isRequired: true,
                      variant: FieldVariant.password,
                      prefix: const Icon(Icons.lock_outline_rounded),
                      validator: (v) => (v == null || v.isEmpty)
                          ? ValidationStrings.passwordRequired
                          : null,
                      onChanged: (_) => _controller.validateForm(),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  // Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: AppTextButton(
                      text: AppStrings.forgotPassword,
                      onPressed: () {
                        AppNav.push(context, const ForgotPasswordScreen());
                      },
                    ),
                  ),
                  SizedBox(height: 30.h),
                  // Login Button
                  FadeInUp(
                    child: ListenableBuilder(
                      listenable: _controller,
                      builder: (context, _) {
                        return BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            return AppButton(
                              text: AppStrings.login,
                              isEnabled: _controller.isFormValid,
                              isLoading: state is AuthLoading,
                              onPressed: _controller.onSubmit,
                            );
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20.h),
                  // Join as CJ request
                  Center(
                    child: AppTextButton(
                      text: AppStrings.joinAsCJ,
                      textColor: Theme.of(context).colorScheme.primary,
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


}
