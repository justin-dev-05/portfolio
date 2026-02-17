import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdi_dost/core/constants/app_colors.dart';

import '../data/models/OnboardingData.dart';

class OnboardingBackground extends StatelessWidget {
  final PageController pageController;
  final List<OnboardingData> data;
  final int currentPage;

  const OnboardingBackground({
    super.key,
    required this.pageController,
    required this.data,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (context, _) {
        double page = 0;
        if (pageController.hasClients &&
            pageController.position.haveDimensions) {
          page = pageController.page!;
        } else {
          page = currentPage.toDouble();
        }

        int firstIdx = page.floor();
        int secondIdx = firstIdx + 1;
        double fraction = page - firstIdx;

        return Stack(
          fit: StackFit.expand,
          children: [
            Container(color: AppColors.black),
            if (firstIdx < data.length)
              _buildBackgroundImage(data[firstIdx], 1.0 - fraction),
            if (secondIdx < data.length)
              _buildBackgroundImage(data[secondIdx], fraction),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.2, 0.7, 1.0],
                  colors: [
                    AppColors.transparent,
                    AppColors.black.withValues(alpha: 0.7),
                    AppColors.black,
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBackgroundImage(OnboardingData data, double opacity) {
    return Opacity(
      opacity: opacity.clamp(0.0, 1.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.black,
          image: DecorationImage(
            image: AssetImage(data.image),
            fit: BoxFit.cover,
            onError: (exception, stackTrace) {},
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                data.color.withValues(alpha: 0.3),
                AppColors.black.withValues(alpha: 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OnboardingPageContent extends StatelessWidget {
  final OnboardingData item;
  final int index;

  const OnboardingPageContent({
    super.key,
    required this.item,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInUp(
            key: ValueKey('title_$index'),
            duration: const Duration(milliseconds: 800),
            child: Text(
              item.title,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 34.sp,
                fontWeight: FontWeight.w900,
                color: AppColors.white,
                height: 1.1,
                letterSpacing: -1,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          FadeInUp(
            key: ValueKey('desc_$index'),
            duration: const Duration(milliseconds: 800),
            delay: const Duration(milliseconds: 200),
            child: Text(
              item.description,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.white.withValues(alpha: 0.9),
                height: 1.5,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: 160.h),
        ],
      ),
    );
  }
}

class OnboardingPageIndicators extends StatelessWidget {
  final int itemCount;
  final int currentPage;

  const OnboardingPageIndicators({
    super.key,
    required this.itemCount,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          height: 8.r,
          width: currentPage == index ? 24.w : 8.r,
          decoration: BoxDecoration(
            color: currentPage == index
                ? AppColors.white
                : AppColors.white.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: currentPage == index
                ? [
                    BoxShadow(
                      color: AppColors.white.withValues(alpha: 0.4),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ]
                : [],
          ),
        ),
      ),
    );
  }
}

class OnboardingNextButton extends StatelessWidget {
  final VoidCallback onTap;

  const OnboardingNextButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14.r),
        child: Container(
          width: 48.w,
          height: 48.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(14.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.3),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Icon(
            Icons.arrow_forward_ios_rounded,
            color: AppColors.black,
            size: 20.sp,
          ),
        ),
      ),
    );
  }
}
