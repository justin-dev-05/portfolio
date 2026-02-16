import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdi_dost/core/constants/app_colors.dart';
import 'package:pdi_dost/core/constants/app_strings.dart';
import 'package:pdi_dost/core/constants/helper.dart';
import 'package:pdi_dost/core/utils/app_nav.dart';
import 'package:pdi_dost/core/widgets/app_dialogs.dart';
import 'package:pdi_dost/features/auth/bloc/auth/auth_bloc.dart';
import 'package:pdi_dost/features/auth/ui/login/login_screen.dart';
import 'package:pdi_dost/features/profile/ui/edit_profile_screen.dart';
import 'package:pdi_dost/features/profile/ui/change_password_screen.dart';
import 'package:pdi_dost/features/profile/ui/widgets/profile_widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthUnauthenticated) {
            AppNav.pushAndRemoveUntil(context, const LoginScreen());
          }
        },
        child: Stack(
          children: [
            // Styled Background Header
            Container(
              height: 265.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withValues(alpha: 0.8)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.r),
                  bottomRight: Radius.circular(40.r),
                ),
              ),
            ),

            // Content
            SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 5.h,
                    ),
                    child: Text(
                      AppStrings.profile,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(
                  //     horizontal: 10.w,
                  //     vertical: 5.h,
                  //   ),
                  //   child: Row(
                  //     children: [
                  //       IconButton(
                  //         onPressed: () => AppNav.pop(context),
                  //         icon: const Icon(
                  //           Icons.arrow_back_rounded,
                  //           color: Colors.white,
                  //         ),
                  //       ),
                  //       const Spacer(),
                  //       Text(
                  //         AppStrings.profile,
                  //         style: TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 20.sp,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //       const Spacer(),
                  //       SizedBox(width: 48.w), // To balance the back button
                  //     ],
                  //   ),
                  // ),
                  // Header Section (Avatar + Info)
                  FadeInDown(
                    child: const ProfileHeader(
                      showText: true,
                      isDarkHeader: true,
                    ),
                  ),
                  SizedBox(height: 25.h),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      // padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                      padding: EdgeInsets.only(
                        left: 20.w,
                        right: 20.w,
                        top: 10.h,
                        bottom: 20.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // SECURITY SECTION
                          buildSectionTitle(AppStrings.account, context),
                          SizedBox(height: 10.h),
                          buildSectionCard(
                            context,
                            children: [
                              buildSettingsTile(
                                context: context,
                                title: AppStrings.editProfile,
                                icon: Icons.person_outline_rounded,
                                color: Colors.purple.shade300,
                                onTap: () => AppNav.push(
                                  context,
                                  const EditProfileScreen(),
                                ),
                              ),
                              buildSettingsTile(
                                context: context,
                                title: AppStrings.myInspections,
                                icon: Icons.assignment_outlined,
                                color: Colors.blue.shade300,
                                showDivider: false,
                                onTap: () {
                                  // Navigate to inspections
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          // SECURITY SECTION
                          buildSectionTitle(AppStrings.security, context),
                          SizedBox(height: 10.h),
                          buildSectionCard(
                            context,
                            children: [
                              const ThemeToggle(),
                              buildSettingsTile(
                                context: context,
                                title: AppStrings.changePassword,
                                icon: Icons.lock_reset_rounded,
                                color: Colors.orange.shade300,
                                showDivider: false,
                                onTap: () => AppNav.push(
                                  context,
                                  const ChangePasswordScreen(),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          // GENERAL SECTION
                          buildSectionTitle(AppStrings.general, context),
                          SizedBox(height: 12.h),
                          buildSectionCard(
                            context,
                            children: [
                              // buildSettingsTile(
                              //   context: context,
                              //   title: AppStrings.helpSupport,
                              //   icon: Icons.headset_mic_outlined,
                              //   color: Colors.teal.shade300,
                              //   onTap: () => AppNav.push(
                              //     context,
                              //     const CommonWebView(
                              //       title: AppStrings.helpSupport,
                              //       url: AppStrings.supportUrl,
                              //     ),
                              //   ),
                              // ),
                              // buildSettingsTile(
                              //   context: context,
                              //   title: AppStrings.termsAndConditions,
                              //   icon: Icons.description_outlined,
                              //   color: Colors.amber.shade300,
                              //   onTap: () => AppNav.push(
                              //     context,
                              //     const CommonWebView(
                              //       title: AppStrings.termsAndConditions,
                              //       url: AppStrings.termsUrl,
                              //     ),
                              //   ),
                              // ),
                              // buildSettingsTile(
                              //   context: context,
                              //   title: AppStrings.privacyPolicy,
                              //   icon: Icons.privacy_tip_outlined,
                              //   color: Colors.cyan.shade300,
                              //   onTap: () => AppNav.push(
                              //     context,
                              //     const CommonWebView(
                              //       title: AppStrings.privacyPolicy,
                              //       url: AppStrings.privacyUrl,
                              //     ),
                              //   ),
                              // ),
                              buildSettingsTile(
                                context: context,
                                title: AppStrings.shareApp,
                                icon: Icons.share_outlined,
                                color: Colors.blueAccent.shade100,
                                onTap: () => AppHelper().shareApp(
                                  context,
                                  androidUrl: "",
                                  appleUrl: "",
                                ),
                              ),
                              buildSettingsTile(
                                context: context,
                                title: AppStrings.deleteAccount,
                                icon: Icons.delete_outline_rounded,
                                color: Colors.red.shade300,
                                onTap: () =>
                                    AppDialogs.showConfirmDeleteAccount(
                                      context,
                                    ),
                              ),
                              buildSettingsTile(
                                context: context,
                                title: AppStrings.logout,
                                icon: Icons.logout_rounded,
                                color: Colors.red.shade400,
                                showDivider: false,
                                onTap: () =>
                                    AppDialogs.showConfirmLogout(context),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          // App Version
                          Text(
                            AppStrings.appVersion,
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:animate_do/animate_do.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:pdi_dost/core/constants/helper.dart';
// import 'package:pdi_dost/core/utils/app_nav.dart';
// import 'package:pdi_dost/core/constants/app_strings.dart';
// import 'package:pdi_dost/core/widgets/app_dialogs.dart';
// import 'package:pdi_dost/features/auth/bloc/auth/auth_bloc.dart';
// import 'package:pdi_dost/features/auth/ui/login/login_screen.dart';
// import 'package:pdi_dost/features/profile/ui/edit_profile_screen.dart';
// import 'package:pdi_dost/features/profile/ui/change_password_screen.dart';
// import 'package:pdi_dost/core/widgets/toolbar.dart';
// import 'package:pdi_dost/features/profile/ui/widgets/profile_widgets.dart';
// import 'package:pdi_dost/core/widgets/common_webview.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: Toolbar.simple(
//         context,
//         title: AppStrings.profile,
//         showBackButton: false,
//       ),
//       body: BlocListener<AuthBloc, AuthState>(
//         listener: (context, state) {
//           if (state is AuthUnauthenticated) {
//             AppNav.pushAndRemoveUntil(context, const LoginScreen());
//           }
//         },
//         child:
//          SingleChildScrollView(
//           physics: BouncingScrollPhysics(),
//           // padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
//           padding: EdgeInsets.only(
//             left: 20.w,
//             right: 20.w,
//             top: 10.h,
//             bottom: 20.h,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               FadeInDown(child: const ProfileHeader()),
//               SizedBox(height: 10.h),
//               // ACCOUNT SECTION
//               buildSectionTitle(AppStrings.account, context),
//               SizedBox(height: 10.h),
//               buildSectionCard(
//                 context,
//                 children: [
//                   buildSettingsTile(
//                     context: context,
//                     title: AppStrings.editProfile,
//                     icon: Icons.person_outline_rounded,
//                     color: Colors.purple.shade300,
//                     onTap: () =>
//                         AppNav.push(context, const EditProfileScreen()),
//                   ),
//                   buildSettingsTile(
//                     context: context,
//                     title: AppStrings.myInspections,
//                     icon: Icons.assignment_outlined,
//                     color: Colors.blue.shade300,
//                     showDivider: false,
//                     onTap: () {
//                       // Navigate to inspections
//                     },
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20.h),
//               // SECURITY SECTION
//               buildSectionTitle(AppStrings.security, context),
//               SizedBox(height: 12.h),
//               buildSectionCard(
//                 context,
//                 children: [
//                   const ThemeToggle(),
//                   buildSettingsTile(
//                     context: context,
//                     title: AppStrings.changePassword,
//                     icon: Icons.lock_reset_rounded,
//                     color: Colors.orange.shade300,
//                     showDivider: false,
//                     onTap: () =>
//                         AppNav.push(context, const ChangePasswordScreen()),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20.h),
//               // GENERAL SECTION
//               buildSectionTitle(AppStrings.general, context),
//               SizedBox(height: 12.h),
//               buildSectionCard(
//                 context,
//                 children: [
//                   // buildSettingsTile(
//                   //   context: context,
//                   //   title: AppStrings.helpSupport,
//                   //   icon: Icons.headset_mic_outlined,
//                   //   color: Colors.teal.shade300,
//                   //   onTap: () => AppNav.push(
//                   //     context,
//                   //     const CommonWebView(
//                   //       title: AppStrings.helpSupport,
//                   //       url: AppStrings.supportUrl,
//                   //     ),
//                   //   ),
//                   // ),
//                   // buildSettingsTile(
//                   //   context: context,
//                   //   title: AppStrings.termsAndConditions,
//                   //   icon: Icons.description_outlined,
//                   //   color: Colors.amber.shade300,
//                   //   onTap: () => AppNav.push(
//                   //     context,
//                   //     const CommonWebView(
//                   //       title: AppStrings.termsAndConditions,
//                   //       url: AppStrings.termsUrl,
//                   //     ),
//                   //   ),
//                   // ),
//                   // buildSettingsTile(
//                   //   context: context,
//                   //   title: AppStrings.privacyPolicy,
//                   //   icon: Icons.privacy_tip_outlined,
//                   //   color: Colors.cyan.shade300,
//                   //   onTap: () => AppNav.push(
//                   //     context,
//                   //     const CommonWebView(
//                   //       title: AppStrings.privacyPolicy,
//                   //       url: AppStrings.privacyUrl,
//                   //     ),
//                   //   ),
//                   // ),
//                   buildSettingsTile(
//                     context: context,
//                     title: AppStrings.shareApp,
//                     icon: Icons.share_outlined,
//                     color: Colors.blueAccent.shade100,
//                     onTap: () => AppHelper().shareApp(
//                       context,
//                       androidUrl: "",
//                       appleUrl: "",
//                     ),
//                   ),
//                   buildSettingsTile(
//                     context: context,
//                     title: AppStrings.deleteAccount,
//                     icon: Icons.delete_outline_rounded,
//                     color: Colors.red.shade300,
//                     onTap: () => AppDialogs.showConfirmDeleteAccount(context),
//                   ),
//                   buildSettingsTile(
//                     context: context,
//                     title: AppStrings.logout,
//                     icon: Icons.logout_rounded,
//                     color: Colors.red.shade400,
//                     showDivider: false,
//                     onTap: () => AppDialogs.showConfirmLogout(context),
//                   ),
//                 ],
//               ),
//             ],
//           ),

//         ),
//       ),
//     );
//   }
// }
