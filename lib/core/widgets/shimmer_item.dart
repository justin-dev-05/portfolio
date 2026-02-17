import 'package:flutter/material.dart';
import 'package:pdi_dost/core/constants/app_colors.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShimmerItem extends StatelessWidget {
  const ShimmerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(width: 150.w, height: 20.h, color: AppColors.white),
            SizedBox(height: 10.h),
            Container(
              width: double.infinity,
              height: 14.h,
              color: AppColors.white,
            ),
            SizedBox(height: 5.h),
            Container(width: 200.w, height: 14.h, color: AppColors.white),
          ],
        ),
      ),
    );
  }
}
