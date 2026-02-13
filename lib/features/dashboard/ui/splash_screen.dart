import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdi_dost/core/constants/app_strings.dart';
import 'package:pdi_dost/core/constants/assets_constant.dart';
import 'package:pdi_dost/core/utils/app_nav.dart';
import 'package:pdi_dost/features/auth/ui/login/login_screen.dart';
import 'package:pdi_dost/features/dashboard/bloc/splash/splash_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SplashBloc>().add(SplashStarted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashCompleted) {
          AppNav.replace(context, const LoginScreen());
        }
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage(AppAssets.appBg),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withValues(alpha: 0.5),
                BlendMode.darken,
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 3),
              ZoomIn(
                duration: const Duration(milliseconds: 1200),
                child: Container(
                  padding: EdgeInsets.all(24.r),
                  decoration: BoxDecoration(
                    // color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(
                          context,
                        ).primaryColor.withValues(alpha: 0.1),
                        blurRadius: 60,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: Image.asset(
                    AppAssets.appLogo,
                    height: 160.h,
                    width: 160.h,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const Spacer(flex: 3),
              FadeInUp(
                duration: const Duration(seconds: 1),
                delay: const Duration(milliseconds: 800),
                child: Column(
                  children: [
                    SizedBox(
                      width: 120.w,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: LinearProgressIndicator(
                          minHeight: 4.h,
                          backgroundColor: Colors.white.withValues(alpha: 0.1),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      AppStrings.preparing,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 12.sp,
                        letterSpacing: 3,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}
