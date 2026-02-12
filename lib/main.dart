import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portfolio/core/utils/responsive.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/router.dart';
import 'features/portfolio/presentation/blocs/portfolio_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PortfolioBloc(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final designSize = DesignSize.resolve(constraints.maxWidth);
          return ScreenUtilInit(
            designSize: designSize,
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp.router(
                title: 'Justin Mahida | Portfolio',
                debugShowCheckedModeBanner: false,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: ThemeMode.system,
                routerConfig: AppRouter.router,
              );
            },
          );
        },
      ),
    );
  }
}
//  return BlocProvider(
//       create: (context) => PortfolioBloc(),
//       child: LayoutBuilder(
//         builder: (context, constraints) {
//           final designSize = DesignSize.resolve(constraints.maxWidth);
//           return BlocListener<PortfolioBloc, PortfolioState>(
//             listener: (context, state) {
//               SystemChrome.setSystemUIOverlayStyle(
//                 SystemUiOverlayStyle(
//                   statusBarColor: Colors.transparent,
//                   statusBarIconBrightness:
//                       state.isDark ? Brightness.light : Brightness.dark,
//                   statusBarBrightness:
//                       state.isDark ? Brightness.dark : Brightness.light,
//                 ),
//               );
//             },
//             child: ScreenUtilInit(
//               designSize: designSize,
//               minTextAdapt: true,
//               splitScreenMode: true,
//               builder: (context, child) {
//                 return MaterialApp.router(
//                   title: 'Justin Mahida | Portfolio',
//                   debugShowCheckedModeBanner: false,
//                   theme: AppTheme.lightTheme,
//                   darkTheme: AppTheme.darkTheme,
//                   themeMode: ThemeMode.system,
//                   routerConfig: AppRouter.router,
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
