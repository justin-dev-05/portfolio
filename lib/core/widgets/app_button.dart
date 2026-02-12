import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdi_dost/core/constants/app_colors.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;
  final bool isFullWidth;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? disabledColor;
  final Color? textColor;
  final double? height;
  final double? width;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final Widget? child;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.isFullWidth = true,
    this.icon,
    this.backgroundColor,
    this.disabledColor,
    this.textColor,
    this.height,
    this.width,
    this.fontSize,
    this.fontWeight,
    this.borderRadius,
    this.padding,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Determine if button should be enabled
    final effectiveEnabled = isEnabled && !isLoading && onPressed != null;

    // Colors
    final effectiveBgColor = effectiveEnabled
        ? (backgroundColor ?? AppColors.primaryLight)
        : (disabledColor ?? Colors.grey.shade400);

    final effectiveTextColor = textColor ?? Colors.white;

    return SizedBox(
      width: isFullWidth ? double.infinity : width,
      height: height ?? 55.h,
      child: ElevatedButton(
        onPressed: effectiveEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: effectiveBgColor,
          disabledBackgroundColor: disabledColor ?? Colors.grey.shade400,
          foregroundColor: effectiveTextColor,
          elevation: effectiveEnabled ? 2 : 0,
          shadowColor: effectiveEnabled
              ? AppColors.primaryLight.withValues(alpha: 0.3)
              : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 16.r),
          ),
          padding:
              padding ?? EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        ),
        child: isLoading
            ? SizedBox(
                height: 20.h,
                width: 20.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(effectiveTextColor),
                ),
              )
            : child ??
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (icon != null) ...[
                        Icon(
                          icon,
                          size: 20.sp,
                          color: isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.primaryDark,
                        ),
                        SizedBox(width: 8.w),
                      ],
                      Text(
                        text,
                        style: TextStyle(
                          fontSize: fontSize ?? 16.sp,
                          fontWeight: fontWeight ?? FontWeight.w600,
                          letterSpacing: 0.5,
                          color: isDark
                              ? AppColors.textPrimaryDark
                              : effectiveEnabled
                              ? AppColors.white
                              : AppColors.white,
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}

/// Outlined variant of AppButton
class AppOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isEnabled;
  final bool isFullWidth;
  final IconData? icon;
  final Color? borderColor;
  final Color? textColor;
  final double? height;
  final double? borderRadius;

  const AppOutlinedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isEnabled = true,
    this.isFullWidth = true,
    this.icon,
    this.borderColor,
    this.textColor,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final effectiveEnabled = isEnabled && onPressed != null;
    final effectiveBorderColor = effectiveEnabled
        ? (borderColor ?? AppColors.primaryLight)
        : Colors.grey.shade400;
    final effectiveTextColor = effectiveEnabled
        ? (textColor ?? AppColors.primaryLight)
        : Colors.grey.shade600;

    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: height ?? 55.h,
      child: OutlinedButton(
        onPressed: effectiveEnabled ? onPressed : null,
        style: OutlinedButton.styleFrom(
          foregroundColor: effectiveTextColor,
          side: BorderSide(color: effectiveBorderColor, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 16.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20.sp),
              SizedBox(width: 8.w),
            ],
            Text(
              text,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

/// Text button variant
class AppTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;

  const AppTextButton({
    super.key,
    required this.text,
    this.onPressed,
    this.textColor,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: textColor ?? AppColors.primaryLight,
          fontSize: fontSize ?? 14.sp,
          fontWeight: fontWeight ?? FontWeight.w600,
        ),
      ),
    );
  }
}
