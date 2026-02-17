import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:pdi_dost/core/constants/app_colors.dart';

class OTPTheme {
  static PinTheme defaultPinTheme(BuildContext context) {
    return PinTheme(
      width: 50.w,
      height: 55.h,
      textStyle: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).primaryColor,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppColors.white.withValues(alpha: 0.05)
            : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.white.withValues(alpha: 0.1)
              : Colors.grey.shade300,
          width: 2,
        ),
      ),
    );
  }

  static PinTheme focusedPinTheme(BuildContext context) {
    return defaultPinTheme(context).copyWith(
      decoration: defaultPinTheme(context).decoration!.copyWith(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppColors.white.withValues(alpha: 0.1)
            : AppColors.white,
        border: Border.all(color: AppColors.primaryLight, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryLight.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );
  }

  static PinTheme submittedPinTheme(BuildContext context) {
    return defaultPinTheme(context).copyWith(
      decoration: defaultPinTheme(context).decoration!.copyWith(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppColors.white.withValues(alpha: 0.08)
            : AppColors.white,
        border: Border.all(
          color: AppColors.primaryLight.withValues(alpha: 0.6),
          width: 2,
        ),
      ),
    );
  }
}
