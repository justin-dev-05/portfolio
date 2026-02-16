import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdi_dost/core/constants/app_colors.dart';
import 'package:pdi_dost/core/constants/app_strings.dart';
import 'package:pdi_dost/core/constants/helper.dart';

class Toolbar {
  /// Simple AppBar with back button and title
  static PreferredSizeWidget simple(
    BuildContext context, {
    required String title,
    List<Widget>? actions,
    bool centerTitle = true,
    bool showBackButton = true,
    VoidCallback? onBackTap,
    TextStyle? titleStyle,
  }) {
    return AppBar(
      title: Text(
        title,
        style:
            titleStyle ??
            TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              // fontFamily: AppFonts.archivo,
              color: Theme.of(context).primaryColor,
            ),
      ),
      centerTitle: centerTitle,
      elevation: 0,
      backgroundColor: AppColors.transparent,
      leading: showBackButton
          ? Center(
              child: Padding(
                padding: EdgeInsets.only(left: 12.w),
                child: Material(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white.withValues(alpha: 0.05)
                      : Colors.white,
                  shape: const CircleBorder(),
                  child: InkWell(
                    onTap: onBackTap ?? () => Navigator.of(context).pop(),
                    customBorder: const CircleBorder(),
                    child: Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: Icon(
                        Icons.arrow_back_rounded,
                        color: Theme.of(context).primaryColor,
                        size: 24.sp,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : null,
      actions: actions,
    );
  }

  /// Home Screen Header Toolbar with User Info and Search
  static Widget homeHeader(
    BuildContext context, {
    required String name,
    required VoidCallback onProfileTap,
    required VoidCallback onNotificationTap,
    required ValueChanged<String> onSearchChanged,
    int notificationCount = 0,
  }) {
    final isDark = AppHelper.isDarkMode(context);

    return Padding(
      padding: EdgeInsets.only(
        top: 12.h,
        left: 16.w,
        right: 16.w,
        bottom: 12.h,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: onProfileTap,
                      child: CircleAvatar(
                        radius: 24.r,
                        backgroundColor: Theme.of(
                          context,
                        ).primaryColor.withValues(alpha: 0.1),
                        child: Icon(
                          Icons.person,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.welcome,
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: AppColors.textSecondaryColor(isDark),
                            ),
                          ),
                          Text(
                            name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: onNotificationTap,
                child: Container(
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceColor(isDark),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Badge(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    label: Text(notificationCount.toString()),
                    isLabelVisible: notificationCount > 0,
                    child: Icon(
                      Icons.notifications_none_rounded,
                      size: 24.sp,
                      color: AppColors.textPrimaryColor(isDark),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            height: 50.h,
            decoration: BoxDecoration(
              color: AppColors.surfaceColor(isDark),
              borderRadius: BorderRadius.circular(15.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: AppColors.textSecondaryColor(
                    isDark,
                  ).withValues(alpha: 0.5),
                  size: 20.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: TextField(
                    onChanged: onSearchChanged,
                    decoration: InputDecoration(
                      hintText: AppStrings.searchInspections,
                      hintStyle: TextStyle(
                        color: AppColors.textSecondaryColor(
                          isDark,
                        ).withValues(alpha: 0.5),
                        fontSize: 14.sp,
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      filled: false,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
