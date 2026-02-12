import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdi_dost/core/constants/app_colors.dart';
import 'package:pdi_dost/core/constants/app_strings.dart';
import 'package:pdi_dost/core/theme/theme_bloc.dart';
import 'package:pdi_dost/core/widgets/app_dialog.dart';
import '../bloc/auth_bloc.dart';
import 'edit_profile_screen.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.profile)),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthUnauthenticated) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
              (route) => false,
            );
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.r),
          child: Column(
            children: [
              FadeInDown(child: _buildProfileHeader(context)),
              SizedBox(height: 40.h),
              FadeInUp(
                child: Column(
                  children: [
                    _buildSettingsTile(
                      context: context,
                      title: AppStrings.editProfile,
                      icon: Icons.person_outline_rounded,
                      color: Colors.blue,
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (_) => const EditProfileScreen(),
                        //   ),
                        // );
                      },
                    ),
                    // _buildThemeToggle(context),
                    _buildSettingsTile(
                      context: context,
                      title: AppStrings.notificationSettings,
                      icon: Icons.notifications_none_rounded,
                      color: Colors.orange,
                      onTap: () {},
                    ),
                    _buildSettingsTile(
                      context: context,
                      title: AppStrings.aboutApp,
                      icon: Icons.info_outline_rounded,
                      color: Colors.teal,
                      // onTap: () => _showAboutDialog(context),
                      onTap: () {},
                    ),
                    SizedBox(height: 20.h),
                    const Divider(),
                    SizedBox(height: 10.h),
                    _buildSettingsTile(
                      context: context,
                      title: AppStrings.logout,
                      icon: Icons.logout_rounded,
                      color: Colors.red,
                      onTap: () => _confirmLogout(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        String name = 'User';
        String email = '';
        String profileImg = '';

        if (state is AuthAuthenticated) {
          name = state.username.isNotEmpty
              ? state.username.toString().toUpperCase()
              : 'User Name';
          email = state.email.isNotEmpty
              ? state.email.toString()
              : 'user@gmail.com';
          profileImg = state.profileImagePath ?? '';
        }
        // print("name: $name, email: $email, profileImg: $profileImg");
        return Column(
          children: [
            Stack(
              children: [
                GestureDetector(
                  onTap: () => _showImagePicker(context),
                  child: Container(
                    padding: EdgeInsets.all(4.r),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 2.w,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 50.r,
                      backgroundImage:
                          state is AuthAuthenticated &&
                              state.profileImagePath != null
                          ? FileImage(File(state.profileImagePath!))
                          : profileImg.isNotEmpty
                          ? NetworkImage(profileImg)
                          : const NetworkImage('https://i.pravatar.cc/300')
                                as ImageProvider,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(6.r),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.edit_rounded,
                      color: Colors.white,
                      size: 18.sp,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Text(
              name,
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              email,
              style: TextStyle(color: Colors.grey, fontSize: 14.sp),
            ),
          ],
        );
      },
    );
  }

  void _showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt, size: 22.sp),
                title: Text('Camera', style: TextStyle(fontSize: 14.sp)),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(context, ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo, size: 22.sp),
                title: Text('Gallery', style: TextStyle(fontSize: 14.sp)),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(context, ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: source, imageQuality: 70);

    if (image != null) {
      // ignore: use_build_context_synchronously
      context.read<AuthBloc>().add(UpdateProfileImageRequested(image.path));
    }
  }

  Widget _buildSettingsTile({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Icon(icon, color: color, size: 22.sp),
      ),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        size: 16.sp,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }

  Widget _buildThemeToggle(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final isDark = state.themeMode == ThemeMode.dark;
        return ListTile(
          leading: Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: Colors.deepPurple.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
              color: Colors.deepPurple,
              size: 22.sp,
            ),
          ),
          title: Text(
            'Dark Mode',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
          ),
          trailing: Switch(
            value: isDark,
            onChanged: (_) => context.read<ThemeBloc>().add(ToggleThemeEvent()),
          ),
        );
      },
    );
  }

  void _showAboutDialog(BuildContext context) {
    AppDialogs.showMessage(
      context: context,
      title: AppStrings.appName,
      message:
          'Version 1.0.0\n\n'
          'Task Reminder is a Flutter Todo app built with BLoC and Clean Architecture. '
          'It offers task management, reminders, dark mode, filtering, and a scalable '
          'API-driven design for multi-user support.',
      positiveButton: 'View Licenses',
      negativeButton: "Close",
      logo: Image.asset('assets/images/app_icon.png', width: 48, height: 48),
      callback: () {
        showLicensePage(
          context: context,
          applicationName: AppStrings.appName,
          applicationVersion: '1.0.0',
        );
      },
    );
  }

  void _confirmLogout(BuildContext context) {
    AppDialogs.showMessage(
      context: context,
      title: AppStrings.logout,
      message: AppStrings.confirmLogoutMsg,
      positiveButton: AppStrings.logout,
      negativeButton: AppStrings.cancel,
      icon: Icons.logout_rounded,
      iconColor: Colors.red,
      callback: () {
        context.read<AuthBloc>().add(AuthLogoutRequested());
      },
    );
  }
}
