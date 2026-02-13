import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdi_dost/core/utils/app_nav.dart';
import 'package:pdi_dost/core/constants/app_strings.dart';
import 'package:pdi_dost/core/widgets/app_dialogs.dart';
import 'package:pdi_dost/features/auth/bloc/auth/auth_bloc.dart';
import 'package:pdi_dost/features/auth/ui/login/login_screen.dart';
import 'package:pdi_dost/features/profile/ui/edit_profile_screen.dart';
import 'package:pdi_dost/core/widgets/toolbar.dart';
import 'package:pdi_dost/features/profile/ui/widgets/profile_widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Toolbar.simple(
        context,
        title: AppStrings.profile,
        showBackButton: false,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthUnauthenticated) {
            AppNav.pushAndRemoveUntil(context, const LoginScreen());
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.r),
          child: Column(
            children: [
              FadeInDown(child: ProfileHeader()),
              SizedBox(height: 20.h),
              FadeInUp(
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white.withValues(alpha: 0.04)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(28.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        buildSettingsTile(
                          context: context,
                          title: AppStrings.editProfile,
                          icon: Icons.person_outline_rounded,
                          color: Colors.purple.shade300,
                          onTap: () =>
                              AppNav.push(context, const EditProfileScreen()),
                        ),
                        const ThemeToggle(),
                        buildSettingsTile(
                          context: context,
                          title: AppStrings.notificationSettings,
                          icon: Icons.notifications_none_rounded,
                          color: Colors.cyan.shade300,
                          onTap: () {},
                        ),
                        buildSettingsTile(
                          context: context,
                          title: AppStrings.aboutApp,
                          icon: Icons.info_outline_rounded,
                          color: Colors.teal.shade300,
                          onTap: () => AppDialogs.showAboutDialog(context),
                          showDivider:
                              false, 
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25.h),
              FadeInUp(
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white.withValues(alpha: 0.04)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(28.r),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: buildSettingsTile(
                      context: context,
                      title: AppStrings.logout,
                      icon: Icons.logout_rounded,
                      color: Colors.red.shade400,
                      onTap: () => AppDialogs.showConfirmLogout(context),
                      showDivider: false,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
