import 'dart:ui';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pdi_dost/core/constants/app_colors.dart';
import 'package:pdi_dost/core/constants/app_strings.dart';
import 'package:pdi_dost/core/constants/assets_constant.dart';
import 'package:pdi_dost/core/constants/helper.dart';
import 'package:pdi_dost/core/widgets/app_button.dart';
import 'package:pdi_dost/features/auth/bloc/auth/auth_bloc.dart';

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
                            child: LoadingAnimationWidget.threeArchedCircle(
                              color: AppColors.primaryLight,
                              size: 40.r,
                            ),
                            // CircularProgressIndicator(
                            //   strokeWidth: 6.r,
                            //   strokeCap: StrokeCap.round,
                            //   backgroundColor: const Color(0xFFE6ECFF),
                            //   valueColor: const AlwaysStoppedAnimation(
                            //     Color(0xFF5B6CFF),
                            //   ),
                            // ),
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
                                AppAssets.appLogo,
                                fit: BoxFit.contain,
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        AppStrings.pleaseWait,
                        style: TextStyle(
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
      barrierLabel: AppStrings.close,
      barrierColor: Colors.black.withValues(
        alpha: isDarkMode(context) ? 0.5 : 0.6,
      ),
      transitionDuration: const Duration(milliseconds: 350),
      pageBuilder: (context, anim, secondaryAnim) {
        return _AppDialogContent(
          title: title,
          message: message,
          positiveButton: positiveButton,
          negativeButton: negativeButton,
          isTitleLeft: isTitleLeft,
          icon: icon,
          iconColor: iconColor,
          logo: logo,
          callback: callback,
        );
      },
      transitionBuilder: (context, anim, _, child) {
        return FadeTransition(
          opacity: anim,
          child: SlideTransition(
            position: Tween<Offset>(begin: Offset(0, 0.2.h), end: Offset.zero)
                .animate(
                  CurvedAnimation(parent: anim, curve: Curves.easeOutCubic),
                ),
            child: child,
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
      title: AppStrings.exitApp,
      message: AppStrings.exitAppMsg,
      positiveButton: AppStrings.confirm,
      negativeButton: AppStrings.cancel,
      icon: Icons.logout_rounded,
      iconColor: AppColors.error,
      callback: onConfirm,
    );
  }

  static void showAboutDialog(BuildContext context) {
    showMessage(
      context: context,
      title: AppStrings.appName,
      message:
          '${AppStrings.appVersion}\n\n'
          '${AppStrings.aboutAppDescription}',
      positiveButton: AppStrings.viewLicenses,
      negativeButton: AppStrings.close,
      logo: Image.asset(AppAssets.appLogo, width: 48, height: 48),
      callback: () {
        showLicensePage(
          context: context,
          applicationName: AppStrings.appName,
          applicationVersion: '1.0.0',
        );
      },
    );
  }

  static void showConfirmLogout(BuildContext context) {
    showMessage(
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

  static void showConfirmDeleteAccount(BuildContext context) {
    showMessage(
      context: context,
      title: AppStrings.deleteAccount,
      message: AppStrings.confirmDeleteAccountMsg,
      positiveButton: AppStrings.deleteAccount,
      negativeButton: AppStrings.cancel,
      icon: Icons.delete_forever_rounded,
      iconColor: AppColors.error,
      callback: () {
        // Handle delete account logic here
        // Usually context.read<AuthBloc>().add(AuthDeleteAccountRequested());
      },
    );
  }

  static Future<ImageSource?> showImagePickerDialog(BuildContext context) {
    hideLoading(context);
    return showGeneralDialog<ImageSource>(
      context: context,
      barrierDismissible: true,
      barrierLabel: AppStrings.close,
      barrierColor: Colors.black.withValues(
        alpha: isDarkMode(context) ? 0.5 : 0.6,
      ),
      transitionDuration: const Duration(milliseconds: 350),
      pageBuilder: (context, anim, secondaryAnim) {
        final isDark = isDarkMode(context);
        return Center(
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
                    color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.1),
                    offset: Offset(0, 10.h),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.image_search_rounded,
                      size: 44.sp,
                      color: AppColors.primaryLight,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    AppStrings.chooseImage,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : AppColors.backgroundDark,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    AppStrings.selectSourceMsg,
                    textAlign: TextAlign.center,
                    style: TextStyle(
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
                      Expanded(
                        child: AppOutlinedButton(
                          text: AppStrings.camera,
                          height: 48.h,
                          borderRadius: 14.r,
                          borderColor:
                              (isDark ? Colors.white : AppColors.primaryLight)
                                  .withValues(alpha: 0.2),
                          textColor: isDark
                              ? Colors.white70
                              : AppColors.primaryLight,
                          onPressed: () =>
                              Navigator.pop(context, ImageSource.camera),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: AppButton(
                          text: AppStrings.gallery,
                          height: 48.h,
                          borderRadius: 14.r,
                          backgroundColor: AppColors.primaryLight,
                          textColor: isDark
                              ? Colors.white70
                              : AppColors.textPrimaryDark,
                          onPressed: () =>
                              Navigator.pop(context, ImageSource.gallery),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim, _, child) {
        return FadeTransition(
          opacity: anim,
          child: SlideTransition(
            position: Tween<Offset>(begin: Offset(0, 0.2.h), end: Offset.zero)
                .animate(
                  CurvedAnimation(parent: anim, curve: Curves.easeOutCubic),
                ),
            child: child,
          ),
        );
      },
    );
  }
}

class _AppDialogContent extends StatefulWidget {
  final String? title;
  final String? message;
  final String? positiveButton;
  final String? negativeButton;
  final bool isTitleLeft;
  final IconData? icon;
  final Color? iconColor;
  final Widget? logo;
  final VoidCallback? callback;

  const _AppDialogContent({
    this.title,
    this.message,
    this.positiveButton,
    this.negativeButton,
    this.isTitleLeft = false,
    this.icon,
    this.iconColor,
    this.logo,
    this.callback,
  });

  @override
  State<_AppDialogContent> createState() => _AppDialogContentState();
}

class _AppDialogContentState extends State<_AppDialogContent> {
  bool _isPopping = false;

  void _handlePop([VoidCallback? afterPop]) {
    if (_isPopping) return;
    setState(() => _isPopping = true);
    Navigator.of(context).pop();
    afterPop?.call();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    return Center(
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
                color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.1),
                offset: Offset(0, 10.h),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.logo != null) ...[
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryLight.withValues(alpha: 0.08),
                  ),
                  child: widget.logo,
                ),
                const SizedBox(height: 20),
              ],
              if (widget.icon != null)
                Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: (widget.iconColor ?? AppColors.primaryLight)
                        .withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    widget.icon,
                    size: 44.sp,
                    color: widget.iconColor ?? AppColors.primaryLight,
                  ),
                ),
              if (widget.icon != null) SizedBox(height: 20.h),
              if ((widget.title ?? '').isNotEmpty)
                Text(
                  widget.title!,
                  textAlign: widget.isTitleLeft
                      ? TextAlign.left
                      : TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : AppColors.backgroundDark,
                  ),
                ),
              if ((widget.title ?? '').isNotEmpty) SizedBox(height: 12.h),
              if ((widget.message ?? '').isNotEmpty)
                Text(
                  widget.message!,
                  textAlign: widget.isTitleLeft
                      ? TextAlign.left
                      : TextAlign.center,
                  style: TextStyle(
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
                  if ((widget.negativeButton ?? '').isNotEmpty)
                    Expanded(
                      child: AppOutlinedButton(
                        text: widget.negativeButton!,
                        height: 48.h,
                        borderRadius: 14.r,
                        borderColor:
                            (isDark ? Colors.white : AppColors.primaryLight)
                                .withValues(alpha: 0.2),
                        textColor: isDark
                            ? Colors.white70
                            : AppColors.primaryLight,
                        onPressed: _isPopping ? null : () => _handlePop(),
                      ),
                    ),
                  if ((widget.negativeButton ?? '').isNotEmpty &&
                      (widget.positiveButton ?? '').isNotEmpty)
                    SizedBox(width: 12.w),
                  if ((widget.positiveButton ?? '').isNotEmpty)
                    Expanded(
                      child: AppButton(
                        text: widget.positiveButton!,
                        height: 48.h,
                        borderRadius: 14.r,
                        backgroundColor: AppColors.primaryLight,
                        textColor: isDark
                            ? Colors.white70
                            : AppColors.textPrimaryDark,
                        onPressed: _isPopping
                            ? null
                            : () => _handlePop(widget.callback),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
