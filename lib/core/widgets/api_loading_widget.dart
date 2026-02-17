import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pdi_dost/core/constants/app_colors.dart';
import 'shimmer_item.dart';

class ApiLoadingWidget extends StatelessWidget {
  final int itemCount;
  const ApiLoadingWidget({super.key, this.itemCount = 6});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.h),
        LoadingAnimationWidget.staggeredDotsWave(
          color: AppColors.white,
          size: 200,
        ),
        // SpinKitWave(color: Colors.blueAccent, size: 30.r),
        SizedBox(height: 20.h),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: ListView.builder(
              itemCount: itemCount,
              itemBuilder: (context, index) => const ShimmerItem(),
            ),
          ),
        ),
      ],
    );
  }
}
