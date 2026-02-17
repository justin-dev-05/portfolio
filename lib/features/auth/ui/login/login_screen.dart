import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdi_dost/core/constants/app_colors.dart';
import 'package:pdi_dost/core/constants/app_strings.dart';
import 'package:pdi_dost/core/constants/assets_constant.dart';
import 'package:pdi_dost/core/utils/app_nav.dart';
import 'package:pdi_dost/core/widgets/api_state_bloc_listener.dart';
import 'package:pdi_dost/core/widgets/app_button.dart';
import 'package:pdi_dost/core/widgets/app_text_field.dart';
import 'package:pdi_dost/core/widgets/common_scaffold.dart';
import 'package:pdi_dost/core/widgets/form_validation_helper.dart';
import 'package:pdi_dost/features/auth/ui/forgot_password/forgot_password_screen.dart';
import 'package:pdi_dost/features/dashboard/ui/dashboard_screen.dart';
import 'package:pdi_dost/features/auth/controller/login_controller.dart';
import 'package:pdi_dost/core/widgets/common_webview.dart';
import 'package:pdi_dost/features/dashboard/bloc/bottom_nav/bottom_nav_bloc.dart';
import 'package:pdi_dost/features/auth/ui/cj_request/cj_request_screen.dart';
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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return CommonScaffold(
      showAppBar: false,
      body: ApiStateBlocListener<AuthBloc, AuthState>(
        loadingStateType: AuthLoading,
        successStateType: AuthAuthenticated,
        failureStateType: AuthFailure,
        errorExtractor: (state) => (state as AuthFailure).message,
        onSuccess: () {
          context.read<BottomNavBloc>().add(const TabChangedEvent(0));
          AppNav.replace(context, const DashboardScreen());
        },
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Form(
                key: _controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    SizedBox(height: 10.h),
                    // Welcome Texts
                    FadeInDown(
                      delay: const Duration(milliseconds: 200),
                      child: Column(
                        children: [
                          Text(
                            AppStrings.welcomeBack,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: isDark
                                  ? AppColors.white
                                  : AppColors.textPrimaryLight,
                              letterSpacing: -0.5,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            AppStrings.loginSubTitle,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: isDark
                                  ? AppColors.textSecondaryDark
                                  : AppColors.textSecondaryLight,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Login Card / Container
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
                            // Email Field
                            AppField(
                              label: AppStrings.emailAddress,
                              controller: _controller.email.text,
                              focusNode: _controller.email.focus,
                              hint: AppStrings.emailHint,
                              isRequired: true,
                              prefix: const Icon(Icons.email_rounded, size: 20),
                              keyboardType: TextInputType.emailAddress,
                              validator: FormValidators.email,
                              onChanged: (_) => _controller.validateForm(),
                            ),
                            SizedBox(height: 20.h),
                            // Password Field
                            AppField(
                              label: AppStrings.password,
                              controller: _controller.password.text,
                              focusNode: _controller.password.focus,
                              hint: AppStrings.passwordHint,
                              isRequired: true,
                              variant: FieldVariant.password,
                              prefix: const Icon(Icons.lock_rounded, size: 20),
                              validator: (v) {
                                if (v == null || v.isEmpty) {
                                  return ValidationStrings.passwordRequired;
                                }
                                if (v.length < 6) {
                                  return AppStrings.min6Chars;
                                }
                                return null;
                              },
                              onChanged: (_) => _controller.validateForm(),
                            ),

                            SizedBox(height: 4.h),
                            // Forgot Password
                            Align(
                              alignment: Alignment.centerRight,
                              child: AppTextButton(
                                text: AppStrings.forgotPassword,
                                fontWeight: FontWeight.w700,
                                onPressed: () {
                                  AppNav.push(
                                    context,
                                    const ForgotPasswordScreen(),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 20.h),
                            // Login Button
                            ListenableBuilder(
                              listenable: _controller,
                              builder: (context, _) {
                                return BlocBuilder<AuthBloc, AuthState>(
                                  builder: (context, state) {
                                    return AppButton(
                                      text: AppStrings.login,
                                      isEnabled: _controller.isFormValid,
                                      // onPressed: _controller.onSubmit,
                                      onPressed: () {
                                        AppNav.replace(
                                          context,
                                          const DashboardScreen(),
                                        );
                                      },
                                      borderRadius: 15.r,
                                      height: 56.h,
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    // Join as CJ request
                    FadeInUp(
                      delay: const Duration(milliseconds: 600),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.dontHaveAccount,
                            style: TextStyle(
                              color: isDark
                                  ? Colors.white70
                                  : AppColors.textSecondaryLight,
                              fontSize: 14.sp,
                            ),
                          ),
                          AppTextButton(
                            text: AppStrings.joinAsCJ,
                            fontWeight: FontWeight.w800,
                            textColor: theme.primaryColor,
                            // onPressed: () {},
                            onPressed: () =>
                                AppNav.push(context, const CjRequestScreen()),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32.h),
                    // Terms and Privacy Policy
                    FadeInUp(
                      delay: const Duration(milliseconds: 800),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(
                            text: AppStrings.termsAgreement,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.sp,
                              height: 1.5,
                            ),
                            children: [
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: GestureDetector(
                                  onTap: () => AppNav.push(
                                    context,
                                    const CommonWebView(
                                      title: AppStrings.termsAndConditions,
                                      url: AppStrings.termsUrl,
                                    ),
                                  ),
                                  child: Text(
                                    AppStrings.termsAndConditions,
                                    style: TextStyle(
                                      color: theme.primaryColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                              TextSpan(text: AppStrings.and),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: GestureDetector(
                                  onTap: () => AppNav.push(
                                    context,
                                    const CommonWebView(
                                      title: AppStrings.privacyPolicy,
                                      url: AppStrings.privacyUrl,
                                    ),
                                  ),
                                  child: Text(
                                    AppStrings.privacyPolicy,
                                    style: TextStyle(
                                      color: theme.primaryColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:animate_do/animate_do.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:pdi_dost/core/constants/app_colors.dart';
// import 'package:pdi_dost/core/constants/app_strings.dart';
// import 'package:pdi_dost/core/constants/assets_constant.dart';
// import 'package:pdi_dost/core/utils/app_nav.dart';
// import 'package:pdi_dost/core/widgets/api_state_bloc_listener.dart';
// import 'package:pdi_dost/core/widgets/app_button.dart';
// import 'package:pdi_dost/core/widgets/app_text_field.dart';
// import 'package:pdi_dost/core/widgets/common_scaffold.dart';
// import 'package:pdi_dost/core/widgets/form_validation_helper.dart';
// import 'package:pdi_dost/features/auth/ui/forgot_password/forgot_password_screen.dart';
// import 'package:pdi_dost/features/dashboard/ui/dashboard_screen.dart';
// import 'package:pdi_dost/features/auth/controller/login_controller.dart';
// import 'package:pdi_dost/core/widgets/common_webview.dart';
// import 'package:pdi_dost/features/dashboard/bloc/bottom_nav/bottom_nav_bloc.dart';
// import '../../bloc/auth/auth_bloc.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   late LoginController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = LoginController(authBloc: context.read<AuthBloc>());
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CommonScaffold(
//       showAppBar: false,
//       body: ApiStateBlocListener<AuthBloc, AuthState>(
//         loadingStateType: AuthLoading,
//         successStateType: AuthAuthenticated,
//         failureStateType: AuthFailure,
//         errorExtractor: (state) => (state as AuthFailure).message,
//         onSuccess: () {
//           context.read<BottomNavBloc>().add(const TabChangedEvent(0));
//           AppNav.replace(context, const DashboardScreen());
//         },
//         child: Center(
//           child: SingleChildScrollView(
//             padding: EdgeInsets.only(left: 30.r, right: 30.r),
//             child: Form(
//               key: _controller.formKey,
//               child: Column(
//                 crossAxisAlignment: .center,
//                 mainAxisAlignment: .center,
//                 children: [
//                   // App Logo
//                   Center(
//                     child: FadeInDown(
//                       child: Image.asset(
//                         AppAssets.appLogo,
//                         height: 120.h,
//                         width: 120.h,
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//                   ),
//                   // Header
//                   FadeInDown(
//                     child: Text(
//                       AppStrings.welcomeBack,
//                       style: Theme.of(context).textTheme.displaySmall?.copyWith(
//                         fontWeight: FontWeight.bold,
//                         color: Theme.of(context).primaryColor,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 10.h),
//                   FadeInDown(
//                     delay: const Duration(milliseconds: 200),
//                     child: Text(
//                       AppStrings.loginSubTitle,
//                       textAlign: TextAlign.center,
//                       style: TextStyle(fontSize: 16.sp, color: Colors.grey),
//                     ),
//                   ),
//                   SizedBox(height: 20.h),
//                   // Email Field
//                   FadeInLeft(
//                     child: AppField(
//                       label: AppStrings.emailAddress,
//                       controller: _controller.email.text,
//                       focusNode: _controller.email.focus,
//                       hint: AppStrings.emailHint,
//                       isRequired: true,
//                       prefix: const Icon(Icons.email_outlined),
//                       keyboardType: TextInputType.emailAddress,
//                       validator: FormValidators.email,
//                       onChanged: (_) => _controller.validateForm(),
//                     ),
//                   ),
//                   SizedBox(height: 20.h),
//                   // Password Field
//                   FadeInLeft(
//                     child: AppField(
//                       label: AppStrings.password,
//                       controller: _controller.password.text,
//                       focusNode: _controller.password.focus,
//                       hint: AppStrings.passwordHint,
//                       isRequired: true,
//                       variant: FieldVariant.password,
//                       prefix: const Icon(Icons.lock_outline_rounded),
//                       validator: (v) {
//                         if (v == null || v.isEmpty) {
//                           return ValidationStrings.passwordRequired;
//                         }
//                         if (v.length < 6) {
//                           return AppStrings.min6Chars;
//                         }
//                         return null;
//                       },
//                       onChanged: (_) => _controller.validateForm(),
//                     ),
//                   ),
//                   SizedBox(height: 10.h),
//                   // Forgot Password
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: AppTextButton(
//                       text: AppStrings.forgotPassword,
//                       onPressed: () {
//                         AppNav.push(context, const ForgotPasswordScreen());
//                       },
//                     ),
//                   ),
//                   SizedBox(height: 30.h),
//                   // Login Button
//                   FadeInUp(
//                     child: ListenableBuilder(
//                       listenable: _controller,
//                       builder: (context, _) {
//                         return BlocBuilder<AuthBloc, AuthState>(
//                           builder: (context, state) {
//                             return AppButton(
//                               text: AppStrings.login,
//                               isEnabled: _controller.isFormValid,
//                               // isLoading: state is AuthLoading,
//                               onPressed: _controller.onSubmit,
//                             );
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                   SizedBox(height: 5.h),
//                   // Join as CJ request
//                   Center(
//                     child: AppTextButton(
//                       text: AppStrings.joinAsCJ,
//                       textColor: Theme.of(context).colorScheme.primary,
//                       onPressed: () {},
//                     ),
//                   ),
//                   SizedBox(height: 10.h),
//                   // Terms and Privacy Policy
//                   FadeInUp(
//                     delay: const Duration(milliseconds: 400),
//                     child: Center(
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 20.w),
//                         child: Text.rich(
//                           textAlign: TextAlign.center,
//                           TextSpan(
//                             text: AppStrings.termsAgreement,
//                             style: TextStyle(
//                               color: Colors.grey,
//                               fontSize: 12.sp,
//                             ),
//                             children: [
//                               WidgetSpan(
//                                 child: GestureDetector(
//                                   onTap: () => AppNav.push(
//                                     context,
//                                     const CommonWebView(
//                                       title: AppStrings.termsAndConditions,
//                                       url: AppStrings.termsUrl,
//                                     ),
//                                   ),
//                                   child: Text(
//                                     AppStrings.termsAndConditions,
//                                     style: TextStyle(
//                                       color: Theme.of(context).primaryColor,
//                                       fontSize: 12.sp,
//                                       fontWeight: FontWeight.bold,
//                                       decoration: TextDecoration.underline,
//                                       decorationColor: AppColors.primaryLight,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               TextSpan(text: AppStrings.and),
//                               WidgetSpan(
//                                 child: GestureDetector(
//                                   onTap: () => AppNav.push(
//                                     context,
//                                     const CommonWebView(
//                                       title: AppStrings.privacyPolicy,
//                                       url: AppStrings.privacyUrl,
//                                     ),
//                                   ),
//                                   child: Text(
//                                     AppStrings.privacyPolicy,
//                                     style: TextStyle(
//                                       color: Theme.of(context).primaryColor,
//                                       fontSize: 12.sp,
//                                       fontWeight: FontWeight.bold,
//                                       decoration: TextDecoration.underline,
//                                       decorationColor: AppColors.primaryLight,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
