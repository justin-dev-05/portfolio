import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdi_dost/core/constants/app_colors.dart';
import 'package:pdi_dost/core/constants/app_strings.dart';
import 'package:pdi_dost/core/constants/helper.dart';
import 'package:pdi_dost/core/theme/theme_bloc.dart';
import 'package:pdi_dost/core/widgets/app_dialogs.dart';
import 'package:pdi_dost/features/auth/bloc/auth/auth_bloc.dart';

class ProfileHeader extends StatelessWidget {
  final bool showText;
  final bool isDarkHeader;
  const ProfileHeader({
    super.key,
    this.showText = true,
    this.isDarkHeader = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        String name = 'User';
        String email = '';
        String profileImg = '';

        if (state is AuthAuthenticated) {
          name = state.username.isNotEmpty
              ? state.username.capitalize()
              : 'User Name';
          email = state.email.isNotEmpty ? state.email : 'user@gmail.com';
          profileImg = state.profileImagePath ?? '';
        }

        final primaryColor = Theme.of(context).primaryColor;

        return Column(
          children: [
            GestureDetector(
              onTap: () => showImagePicker(context),
              child: Stack(
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
                        radius: 50.r,
                        backgroundColor: AppColors.white,
                        child: CircleAvatar(
                          radius: 47.r,
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
                      // onTap: () => showImagePicker(context),
                      child: Container(
                        padding: EdgeInsets.all(8.r),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.white,
                            width: 2.w,
                          ),
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
                          color: AppColors.white,
                          size: 16.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (showText) ...[
              SizedBox(height: 5.h),
              Text(
                // name,
                "User Name",
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                  color: isDarkHeader ? AppColors.white : null,
                ),
              ),
              SizedBox(height: 1.h),
              Text(
                // email,
                "testuser@gmail.com",
                style: TextStyle(
                  color: isDarkHeader ? AppColors.white : primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                ),
              ),
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
              //   decoration: BoxDecoration(
              //     color: isDarkHeader
              //         ? AppColors.white.withValues(alpha: 0.2)
              //         : primaryColor.withValues(alpha: 0.08),
              //     borderRadius: BorderRadius.circular(20.r),
              //   ),
              //   child: Text(
              //     email,
              //     style: TextStyle(
              //       color: isDarkHeader ? AppColors.white : primaryColor,
              //       fontWeight: FontWeight.w600,
              //       fontSize: 12.sp,
              //     ),
              //   ),
              // ),
            ],
          ],
        );
      },
    );
  }
}

Widget buildSectionTitle(String title, BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  return Align(
    alignment: AlignmentGeometry.topLeft,
    child: Padding(
      padding: EdgeInsets.only(left: 4.w),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          color: isDark ? AppColors.white : Colors.black.withValues(alpha: 0.8),
          letterSpacing: -0.2,
        ),
      ),
    ),
  );
}

Widget buildSectionCard(
  BuildContext context, {
  required List<Widget> children,
}) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  return FadeInUp(
    child: Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.white.withValues(alpha: 0.04)
            : AppColors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: Column(children: children),
      ),
    ),
  );
}

void showImagePicker(BuildContext context) async {
  final source = await AppDialogs.showImagePickerDialog(context);
  if (source != null && context.mounted) {
    _pickImage(context, source);
  }
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
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        leading: Container(
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.white.withValues(alpha: 0.05)
                : AppColors.white,
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
            color: isDark ? AppColors.white : Colors.black87,
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
                ? AppColors.white.withValues(alpha: 0.05)
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
