import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdi_dost/core/network/network_cubit.dart';
import 'package:pdi_dost/core/theme/app_theme.dart';
import 'package:pdi_dost/core/theme/theme_bloc.dart';
import 'package:pdi_dost/core/utils/screen_utils.dart';
import 'package:pdi_dost/dependency/init_dependencies.dart';
import 'package:pdi_dost/features/auth/bloc/auth/auth_bloc.dart';
import 'package:pdi_dost/features/dashboard/bloc/bottom_nav/bottom_nav_bloc.dart';
import 'package:pdi_dost/features/dashboard/bloc/splash/splash_bloc.dart';
import 'package:pdi_dost/features/home/bloc/home/home_bloc.dart';
import 'package:pdi_dost/features/dashboard/ui/splash_screen.dart';
import 'package:pdi_dost/features/auth/bloc/onboarding/onboarding_bloc.dart';
import 'core/constants/app_strings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await screenOrientations();
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => serviceLocator<NetworkCubit>()),
              BlocProvider(create: (_) => serviceLocator<SplashBloc>()),
              BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
              BlocProvider(create: (_) => serviceLocator<BottomNavBloc>()),
              BlocProvider(create: (_) => serviceLocator<HomeBloc>()),
              BlocProvider(create: (_) => serviceLocator<OnboardingBloc>()),
              BlocProvider(
                create: (_) =>
                    serviceLocator<ThemeBloc>()..add(LoadThemeEvent()),
              ),
            ],
            child: BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, themeState) {
                return MaterialApp(
                  title: AppStrings.appName,
                  debugShowCheckedModeBanner: false,
                  theme: AppTheme.lightTheme,
                  darkTheme: AppTheme.darkTheme,
                  themeMode: themeState.themeMode,
                  home: child,
                );
              },
            ),
          ),
        );
      },
      child: const SplashScreen(),
    );
  }
}
