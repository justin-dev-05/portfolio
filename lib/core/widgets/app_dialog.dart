import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdi_dost/core/constants/app_colors.dart';
import 'package:pdi_dost/core/constants/helper.dart';

class AppDialogs {
  static bool _isLoadingOpen = false;
  static Future<void> showLoading(
    BuildContext context, {
    bool showLogo = false,
  }) {
    if (_isLoadingOpen) return Future.value();
    _isLoadingOpen = true;
    return showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: 0.3),
      builder: (context) {
        final isDark = isDarkMode(context);

        return PopScope(
          canPop: true,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4.r, sigmaY: 4.r),
            child: Center(
              child: IntrinsicWidth(
                child: Container(
                  padding: EdgeInsets.all(20.r),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.surfaceDark : Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 20.r,
                        offset: Offset(0, 10.h),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: (showLogo ? 60 : 52).r,
                            height: (showLogo ? 60 : 52).r,
                            child: CircularProgressIndicator(
                              strokeWidth: 6.r,
                              strokeCap: StrokeCap.round,
                              backgroundColor: const Color(0xFFE6ECFF),
                              valueColor: const AlwaysStoppedAnimation(
                                Color(0xFF5B6CFF),
                              ),
                            ),
                          ),

                          if (showLogo)
                            Container(
                              width: 44.r,
                              height: 44.r,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isDark
                                    ? AppColors.surfaceDark
                                    : Colors.white,
                              ),
                              padding: EdgeInsets.all(6.r),
                              child: Image.asset(
                                'assets/images/app_icon.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        "Please wait...",
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? Colors.white
                              : AppColors.textPrimaryLight,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ).then((_) => _isLoadingOpen = false);
  }

  static Future<void> showMessage({
    required BuildContext context,
    VoidCallback? callback,
    String? title,
    String? message,
    String? positiveButton,
    String? negativeButton,
    bool isTitleLeft = false,
    IconData? icon,
    Color? iconColor,
    Widget? logo,
  }) {
    hideLoading(context);
    return showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: "Dialog",
      barrierColor: Colors.black.withValues(
        alpha: isDarkMode(context) ? 0.5 : 0.6,
      ),
      transitionDuration: const Duration(milliseconds: 350),
      pageBuilder: (context, _, __) => const SizedBox(),
      transitionBuilder: (context, anim, _, child) {
        final isDark = isDarkMode(context);
        return FadeTransition(
          opacity: anim,
          child: SlideTransition(
            position: Tween<Offset>(begin: Offset(0, 0.2.h), end: Offset.zero)
                .animate(
                  CurvedAnimation(parent: anim, curve: Curves.easeOutCubic),
                ),
            child: Center(
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 0.8.sw,
                  padding: EdgeInsets.all(24.r),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.surfaceDark : AppColors.white,
                    borderRadius: BorderRadius.circular(28.r),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 25.r,
                        color: Colors.black.withValues(
                          alpha: isDark ? 0.3 : 0.1,
                        ),
                        offset: Offset(0, 10.h),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (logo != null) ...[
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryLight.withValues(
                              alpha: 0.08,
                            ),
                          ),
                          child: logo,
                        ),
                        const SizedBox(height: 20),
                      ],

                      if (icon != null)
                        Container(
                          padding: EdgeInsets.all(16.r),
                          decoration: BoxDecoration(
                            color: (iconColor ?? AppColors.primaryLight)
                                .withValues(alpha: 0.12),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            icon,
                            size: 44.sp,
                            color: iconColor ?? AppColors.primaryLight,
                          ),
                        ),
                      if (icon != null) SizedBox(height: 20.h),
                      if ((title ?? '').isNotEmpty)
                        Text(
                          title!,
                          textAlign: isTitleLeft
                              ? TextAlign.left
                              : TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? Colors.white
                                : AppColors.backgroundDark,
                          ),
                        ),
                      if ((title ?? '').isNotEmpty) SizedBox(height: 12.h),
                      if ((message ?? '').isNotEmpty)
                        Text(
                          message!,
                          textAlign: isTitleLeft
                              ? TextAlign.left
                              : TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 15.sp,
                            height: 1.5,
                            color: isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondaryLight,
                          ),
                        ),
                      SizedBox(height: 28.h),
                      Row(
                        children: [
                          if ((negativeButton ?? '').isNotEmpty)
                            Expanded(
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                    color:
                                        (isDark
                                                ? Colors.white
                                                : AppColors.primaryLight)
                                            .withValues(alpha: 0.2),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14.r),
                                  ),
                                  minimumSize: Size.fromHeight(48.h),
                                  padding: EdgeInsets.symmetric(vertical: 14.h),
                                ),
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text(
                                  negativeButton!,
                                  style: GoogleFonts.poppins(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                    color: isDark
                                        ? Colors.white70
                                        : AppColors.primaryLight,
                                  ),
                                ),
                              ),
                            ),
                          if ((negativeButton ?? '').isNotEmpty &&
                              (positiveButton ?? '').isNotEmpty)
                            SizedBox(width: 12.w),
                          if ((positiveButton ?? '').isNotEmpty)
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size.fromHeight(48.h),
                                  backgroundColor: AppColors.primaryLight,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14.r),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 14.h),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  callback?.call();
                                },
                                child: Text(
                                  positiveButton!,
                                  style: GoogleFonts.poppins(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    color: isDark
                                        ? Colors.white70
                                        : AppColors.textPrimaryDark,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static void hideLoading(BuildContext context) {
    if (_isLoadingOpen) {
      _isLoadingOpen = false;
      if (context.mounted) Navigator.of(context, rootNavigator: true).pop();
    }
  }

  void closeSheet(BuildContext context) {
    if (context.mounted && Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  static Future<void> showExitDialog(
    BuildContext context,
    VoidCallback onConfirm,
  ) {
    return showMessage(
      context: context,
      title: 'Exit App',
      message: 'Are you sure you want to quit the app?',
      positiveButton: 'Confirm',
      negativeButton: 'Cancel',
      icon: Icons.logout_rounded,
      iconColor: AppColors.error,
      callback: onConfirm,
    );
  }
}
