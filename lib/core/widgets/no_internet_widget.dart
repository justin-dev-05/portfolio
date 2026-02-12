import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoInternetWidget extends StatelessWidget {
  final VoidCallback onRetry;

  const NoInternetWidget({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Column(
          mainAxisAlignment: .center,
          children: [
            // Cloud with lightning bolt icon
            ElasticIn(
              duration: const Duration(milliseconds: 1000),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 180.r,
                    height: 180.r,
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Icon(
                    Icons.cloud_off_rounded,
                    size: 100.sp,
                    color: Colors.redAccent.shade400,
                  ),
                  Positioned(
                    bottom: 40.h,
                    right: 40.w,
                    child: Icon(
                      Icons.bolt_rounded,
                      size: 40.sp,
                      color: Colors.orange.shade400,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.h),
            FadeInUp(
              child: Text(
                'Ooops!',
                style: TextStyle(
                  fontSize: 34.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            SizedBox(height: 15.h),
            FadeInUp(
              delay: const Duration(milliseconds: 200),
              child: Text(
                'No Internet Connection found\nCheck your connection',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey,
                  height: 1.5,
                ),
              ),
            ),
            SizedBox(height: 60.h),
            FadeInUp(
              delay: const Duration(milliseconds: 400),
              child: SizedBox(
                width: double.infinity,
                height: 55.h,
                child: ElevatedButton(
                  onPressed: onRetry,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent.shade400,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Try Again',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
