import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdi_dost/core/constants/app_colors.dart';
import 'package:pdi_dost/core/constants/app_strings.dart';
import 'package:pdi_dost/core/widgets/app_button.dart';

class AppFilePicker extends StatelessWidget {
  final String label;
  final String? path;
  final VoidCallback onTap;
  final bool isRequired;

  const AppFilePicker({
    super.key,
    required this.label,
    this.path,
    required this.onTap,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4.w, bottom: 8.h),
          child: RichText(
            text: TextSpan(
              text: label,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimaryColor(
                  isDark,
                ).withValues(alpha: 0.85),
              ),
              children: [
                if (isRequired)
                  TextSpan(
                    text: ' *',
                    style: TextStyle(color: AppColors.error, fontSize: 14.sp),
                  ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              AppButton(
                text: AppStrings.chooseFile,
                isFullWidth: false,
                height: 45.h,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                onPressed: onTap,
                backgroundColor: AppColors.primaryLight,
                textColor: AppColors.primaryLight,
                borderRadius: 12.r,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.textPrimaryLight.withValues(alpha: 0.1),
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    path != null
                        ? path!.split('/').last
                        : AppStrings.noFileChosen,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: path != null
                          ? AppColors.textPrimaryColor(isDark)
                          : AppColors.textSecondaryLight,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AppRadioButton extends StatelessWidget {
  final String value;
  final bool isSelected;
  final ValueChanged<String> onChanged;

  const AppRadioButton({
    super.key,
    required this.value,
    required this.isSelected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onChanged(value),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 2.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 20.r,
              height: 20.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.primaryLight
                      : AppColors.textPrimaryColor(
                          isDark,
                        ).withValues(alpha: 0.3),
                  width: 2,
                ),
              ),
              padding: EdgeInsets.all(3.5.r),
              child: isSelected
                  ? Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryLight,
                      ),
                    )
                  : null,
            ),
            SizedBox(width: 10.w),
            Text(
              value,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: AppColors.textPrimaryColor(
                  isDark,
                ).withValues(alpha: isSelected ? 1.0 : 0.75),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
