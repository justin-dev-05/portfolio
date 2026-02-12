import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:pdi_dost/core/network/http_client.dart';
import 'package:pdi_dost/core/network/network_cubit.dart';
import 'package:pdi_dost/core/theme/theme_bloc.dart';
import 'package:pdi_dost/features/auth/bloc/auth_bloc.dart';
import 'package:pdi_dost/features/auth/bloc/onboarding_bloc.dart';
import 'package:pdi_dost/features/dashboard/bloc/bottom_nav_bloc.dart';
import 'package:pdi_dost/features/dashboard/bloc/splash_bloc.dart';
import 'package:pdi_dost/features/home/bloc/home_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  serviceLocator.registerFactory(() => NetworkCubit());

  final sharedPreferences = await SharedPreferences.getInstance();

  // External
  serviceLocator.registerLazySingleton(() => sharedPreferences);
  serviceLocator.registerLazySingleton(() => http.Client());

  // Core
  serviceLocator.registerLazySingleton(() => AppHttpClient(serviceLocator()));

  // Bloc
  serviceLocator.registerFactory<OnboardingBloc>(
    () => OnboardingBloc(sharedPreferences: serviceLocator()),
  );

  serviceLocator.registerFactory<AuthBloc>(
    () => AuthBloc(sharedPreferences: serviceLocator()),
  );

  serviceLocator.registerFactory<BottomNavBloc>(() => BottomNavBloc());

  serviceLocator.registerFactory<SplashBloc>(() => SplashBloc());

  serviceLocator.registerFactory<HomeBloc>(() => HomeBloc());

  serviceLocator.registerLazySingleton<ThemeBloc>(
    () => ThemeBloc(sharedPreferences: serviceLocator()),
  );
}
