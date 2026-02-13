import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/utils/logcat.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';

export 'onboarding_event.dart';
export 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final SharedPreferences sharedPreferences;
  static const String _onboardingKey = 'ONBOARDING_COMPLETED';

  OnboardingBloc({required this.sharedPreferences})
      : super(OnboardingInitial()) {
    on<CheckOnboardingStatus>((event, emit) {
      final isCompleted = sharedPreferences.getBool(_onboardingKey) ?? false;
      if (isCompleted) {
        emit(OnboardingCompleted());
      } else {
        emit(OnboardingNotCompleted());
      }
    });

    on<CompleteOnboarding>((event, emit) async {
      Logcat.print('CompleteOnboardingEvent', "CompleteOnboardingEvent");
      await sharedPreferences.setBool(_onboardingKey, true);
      emit(OnboardingCompleted());
    });
  }
}
