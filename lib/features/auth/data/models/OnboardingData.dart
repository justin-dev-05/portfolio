import 'dart:ui';
import 'package:pdi_dost/core/constants/assets_constant.dart';

import '../../../../core/constants/app_strings.dart';

class OnboardingData {
  final String title;
  final String description;
  final String image;
  final Color color;

  OnboardingData({
    required this.title,
    required this.description,
    required this.image,
    required this.color,
  });
}

var onBoardingData = [
  OnboardingData(
    title: AppStrings.onboarding1Title,
    description: AppStrings.onboarding1Desc,
    image: AppAssets.onboarding1,
    color: const Color(0xFF52CAF5),
  ),
  OnboardingData(
    title: AppStrings.onboarding2Title,
    description: AppStrings.onboarding2Desc,
    image: AppAssets.onboarding2,
    color: const Color(0xFFE31D1A),
  ),
  OnboardingData(
    title: AppStrings.onboarding3Title,
    description: AppStrings.onboarding3Desc,
    image: AppAssets.onboarding3,
    color: const Color(0xFF06578E),
  ),
];
