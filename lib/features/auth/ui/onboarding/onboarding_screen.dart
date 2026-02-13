import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdi_dost/core/constants/app_strings.dart';
import 'package:pdi_dost/core/utils/app_nav.dart';
import 'package:pdi_dost/features/auth/bloc/onboarding/onboarding_bloc.dart';
import '../login/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _data = [
    OnboardingData(
      title: AppStrings.onboarding1Title,
      description: AppStrings.onboarding1Desc,
      icon: Icons.task_alt_rounded,
      color: const Color(0xFF6366F1),
    ),
    OnboardingData(
      title: AppStrings.onboarding2Title,
      description: AppStrings.onboarding2Desc,
      icon: Icons.priority_high_rounded,
      color: const Color(0xFFF43F5E),
    ),
    OnboardingData(
      title: AppStrings.onboarding3Title,
      description: AppStrings.onboarding3Desc,
      icon: Icons.bar_chart_rounded,
      color: const Color(0xFF10B981),
    ),
  ];

  void _onFinish() {
    context.read<OnboardingBloc>().add(CompleteOnboarding());
    AppNav.replace(context, const LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemCount: _data.length,
            itemBuilder: (context, index) {
              final item = _data[index];
              return Container(
                color: item.color.withValues(alpha: 0.05),
                padding: EdgeInsets.all(40.r),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FadeInDown(
                      child: Container(
                        padding: EdgeInsets.all(30.r),
                        decoration: BoxDecoration(
                          color: item.color.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(item.icon, size: 100.sp, color: item.color),
                      ),
                    ),
                    SizedBox(height: 50.h),
                    FadeInUp(
                      child: Text(
                        item.title,
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                          color: item.color,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    FadeInUp(
                      delay: const Duration(milliseconds: 200),
                      child: Text(
                        item.description,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.grey,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            bottom: 50.h,
            left: 20.w,
            right: 20.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: _onFinish,
                  child: Text(
                    AppStrings.skip,
                    style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                  ),
                ),
                Row(
                  children: List.generate(
                    _data.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: EdgeInsets.only(right: 8.w),
                      height: 8.h,
                      width: _currentPage == index ? 24.w : 8.w,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? _data[index].color
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ),
                ),
                FloatingActionButton(
                  key: Key("onBoaring"),
                  onPressed: () {
                    if (_currentPage < _data.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      _onFinish();
                    }
                  },
                  backgroundColor: _data[_currentPage].color,
                  child: Icon(
                    _currentPage == _data.length - 1
                        ? Icons.check
                        : Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 18.sp,
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

class OnboardingData {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  OnboardingData({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}
