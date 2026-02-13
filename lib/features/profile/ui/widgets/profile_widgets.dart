import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdi_dost/core/constants/app_colors.dart';
import 'package:pdi_dost/core/constants/app_strings.dart';
import 'package:pdi_dost/core/theme/theme_bloc.dart';
import 'package:pdi_dost/features/auth/bloc/auth/auth_bloc.dart';

class ProfileHeader extends StatelessWidget {
  final bool showText;
  const ProfileHeader({super.key, this.showText = true});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        String name = 'User';
        String email = '';
        String profileImg = '';

        if (state is AuthAuthenticated) {
          name = state.username.isNotEmpty ? state.username : 'User Name';
          email = state.email.isNotEmpty ? state.email : 'user@gmail.com';
          profileImg = state.profileImagePath ?? '';
        }

        final primaryColor = Theme.of(context).primaryColor;

        return Column(
          children: [
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(5.r),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        primaryColor,
                        primaryColor.withValues(alpha: 0.3),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Hero(
                    tag: 'profile_avatar',
                    child: CircleAvatar(
                      radius: 54.r,
                      backgroundColor: AppColors.white,
                      child: CircleAvatar(
                        radius: 51.r,
                        backgroundImage: profileImg.isNotEmpty
                            ? (profileImg.startsWith('http')
                                  ? NetworkImage(profileImg)
                                  : FileImage(File(profileImg))
                                        as ImageProvider)
                            : const NetworkImage('https://i.pravatar.cc/300'),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 4.r,
                  right: 4.r,
                  child: GestureDetector(
                    onTap: () => _showImagePicker(context),
                    child: Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2.w),
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withValues(alpha: 0.4),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.camera_alt_rounded,
                        color: Colors.white,
                        size: 16.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (showText) ...[
              SizedBox(height: 10.h),
              Text(
                name,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(height: 2.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: primaryColor.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  email,
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  void _showImagePicker(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
      ),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 24.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Drag Handle
                Container(
                  width: 40.w,
                  height: 4.h,
                  margin: EdgeInsets.only(bottom: 24.h),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white24
                        : Colors.grey.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                // Camera Option
                _buildPickerOption(
                  context,
                  title: AppStrings.camera,
                  icon: Icons.camera_alt_rounded,
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(context, ImageSource.camera);
                  },
                ),
                SizedBox(height: 12.h),
                // Gallery Option
                _buildPickerOption(
                  context,
                  title: AppStrings.gallery,
                  icon: Icons.photo_rounded,
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(context, ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPickerOption(
    BuildContext context, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Padding(
          padding: EdgeInsets.all(8.r),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: isDark ? Colors.white10 : const Color(0xFF2B343B),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(icon, color: Colors.white, size: 24.sp),
              ),
              SizedBox(width: 20.w),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : const Color(0xFF2B343B),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: source, imageQuality: 70);

    if (image != null) {
      if (context.mounted) {
        context.read<AuthBloc>().add(UpdateProfileImageRequested(image.path));
      }
    }
  }
}

Widget buildSettingsTile({
  required BuildContext context,
  required String title,
  required IconData icon,
  required Color color,
  required VoidCallback onTap,
  Widget? trailing,
  bool showDivider = true,
}) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  return Column(
    children: [
      ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        leading: Container(
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(icon, color: color, size: 22.sp),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        trailing:
            trailing ??
            Icon(
              Icons.chevron_right_rounded,
              size: 24.sp,
              color: Colors.grey.withValues(alpha: 0.4),
            ),
        onTap: onTap,
      ),
      if (showDivider)
        Padding(
          padding: EdgeInsets.only(left: 70.w, right: 16.w),
          child: Divider(
            height: 1,
            thickness: 1,
            color: isDark
                ? Colors.white.withValues(alpha: 0.05)
                : Colors.grey.withValues(alpha: 0.08),
          ),
        ),
    ],
  );
}

class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final isDark = state.themeMode == ThemeMode.dark;
        return buildSettingsTile(
          context: context,
          title: AppStrings.darkMode,
          icon: isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
          color: Colors.deepPurple,
          onTap: () => context.read<ThemeBloc>().add(ToggleThemeEvent()),
          trailing: Switch.adaptive(
            value: isDark,
            // ignore: deprecated_member_use
            activeColor: Theme.of(context).primaryColor,
            onChanged: (_) => context.read<ThemeBloc>().add(ToggleThemeEvent()),
          ),
        );
      },
    );
  }
}
