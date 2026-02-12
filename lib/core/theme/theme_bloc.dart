import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Events
abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
  @override
  List<Object?> get props => [];
}

class ToggleThemeEvent extends ThemeEvent {}

class LoadThemeEvent extends ThemeEvent {}

// States
class ThemeState extends Equatable {
  final ThemeMode themeMode;
  const ThemeState(this.themeMode);
  @override
  List<Object?> get props => [themeMode];
}

// Bloc
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final SharedPreferences sharedPreferences;
  static const String _themeKey = 'THEME_MODE';

  ThemeBloc({required this.sharedPreferences})
    : super(const ThemeState(ThemeMode.light)) {
    on<LoadThemeEvent>((event, emit) {
      final isDark = sharedPreferences.getBool(_themeKey) ?? false;
      emit(ThemeState(isDark ? ThemeMode.dark : ThemeMode.light));
    });

    on<ToggleThemeEvent>((event, emit) async {
      final isDark = state.themeMode == ThemeMode.dark;
      await sharedPreferences.setBool(_themeKey, !isDark);
      emit(ThemeState(!isDark ? ThemeMode.dark : ThemeMode.light));
    });
  }
}
