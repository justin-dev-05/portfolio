import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdi_dost/core/constants/app_colors.dart';
import 'package:pdi_dost/core/constants/app_strings.dart';
import 'package:pdi_dost/core/utils/app_nav.dart';
import 'package:pdi_dost/features/auth/bloc/onboarding/onboarding_bloc.dart';
import 'package:pdi_dost/core/widgets/app_button.dart';
import 'package:pdi_dost/features/auth/data/models/OnboardingData.dart';
import '../login/login_screen.dart';
import '../../widgets/onboarding_widgets.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;
  final Duration _transitionDuration = const Duration(milliseconds: 1200);
  final Curve _transitionCurve = Curves.easeInOutCubic;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentPage < onBoardingData.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: _transitionDuration,
          curve: _transitionCurve,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _onFinish() {
    _timer?.cancel();
    context.read<OnboardingBloc>().add(CompleteOnboarding());
    AppNav.replace(context, const LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          // GLOBAL BACKGROUND
          Positioned.fill(
            child: OnboardingBackground(
              pageController: _pageController,
              data: onBoardingData,
              currentPage: _currentPage,
            ),
          ),

          // CONTENT LAYER
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
              _startAutoScroll();
            },
            physics: const BouncingScrollPhysics(),
            itemCount: onBoardingData.length,
            itemBuilder: (context, index) {
              return OnboardingPageContent(
                item: onBoardingData[index],
                index: index,
              );
            },
          ),

          // BOTTOM CONTROLS LAYER
          Positioned(
            bottom: 40.h,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                layoutBuilder: (currentChild, previousChildren) {
                  return Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[...previousChildren, ?currentChild],
                  );
                },
                transitionBuilder: (child, animation) =>
                    FadeTransition(opacity: animation, child: child),
                child: _currentPage == onBoardingData.length - 1
                    ? AppButton(
                        key: const ValueKey('get_started_btn'),
                        text: "Get Started",
                        onPressed: _onFinish,
                        borderRadius: 30.r,
                        backgroundColor: AppColors.primaryLight,
                        textColor: AppColors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      )
                    : Row(
                        key: const ValueKey('nav_btns'),
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppTextButton(
                            text: AppStrings.skip,
                            textColor: AppColors.white,
                            onPressed: _onFinish,
                          ),
                          Expanded(
                            child: OnboardingPageIndicators(
                              itemCount: onBoardingData.length,
                              currentPage: _currentPage,
                            ),
                          ),
                          OnboardingNextButton(
                            onTap: () {
                              _pageController.nextPage(
                                duration: _transitionDuration,
                                curve: _transitionCurve,
                              );
                            },
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
