import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdi_dost/core/constants/app_colors.dart';
import 'no_internet_widget.dart';

class ApiErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ApiErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    bool isNoInternet =
        message.toLowerCase().contains('no internet') ||
        message.toLowerCase().contains('connection') ||
        message.toLowerCase().contains('socketexception');

    if (isNoInternet) {
      return NoInternetWidget(onRetry: onRetry);
    }

    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(20.r),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.error_outline_rounded,
                  size: 80.sp,
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                'Oops! Something went wrong',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 16.sp,
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              SizedBox(
                width: 200.w,
                height: 50.h,
                child: ElevatedButton.icon(
                  onPressed: onRetry,
                  icon: Icon(Icons.refresh_rounded, size: 20.sp),
                  label: Text(
                    'Try Again',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    elevation: 0,
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
