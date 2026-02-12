import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_event.dart';
import 'auth_state.dart';

export 'auth_event.dart';
export 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SharedPreferences sharedPreferences;
  static const String _userKey = 'USER_NAME';
  static const String _emailKey = 'USER_EMAIL';
  static const String _imageKey = 'PROFILE_IMAGE';

  AuthBloc({required this.sharedPreferences}) : super(AuthInitial()) {
    on<AuthCheckRequested>((event, emit) async {
      emit(AuthLoading());
      await Future.delayed(const Duration(seconds: 1));
      final username = sharedPreferences.getString(_userKey);
      final email = sharedPreferences.getString(_emailKey);
      final imageKey = sharedPreferences.getString(_imageKey);
      if (username != null) {
        emit(
          AuthAuthenticated(
            username: username,
            email: email ?? '',
            profileImagePath: imageKey,
          ),
        );
      } else {
        emit(AuthUnauthenticated());
      }
    });

    on<AuthLoginRequested>((event, emit) async {
      emit(AuthLoading());
      await Future.delayed(const Duration(seconds: 1));
      if (event.email.contains('@') && event.password.length > 5) {
        final username = event.email.split('@')[0];
        await sharedPreferences.setString(_userKey, username);
        emit(AuthAuthenticated(username: username, email: event.email));
      } else {
        emit(const AuthFailure('Invalid email or password (min 6 chars)'));
      }
    });

    on<LoginSubmitted>((event, emit) async {
      emit(AuthLoading());
      await Future.delayed(const Duration(seconds: 2));
      // Mock success for any input
      final username = event.email.split('@')[0];
      await sharedPreferences.setString(_userKey, username);
      emit(AuthAuthenticated(username: username, email: event.email));
    });

    on<AuthLogoutRequested>((event, emit) async {
      emit(AuthLoading());
      await sharedPreferences.remove(_userKey);
      await Future.delayed(const Duration(milliseconds: 500));
      emit(AuthUnauthenticated());
    });

    on<UpdateProfileRequested>((event, emit) async {
      emit(AuthLoading());

      await sharedPreferences.setString(_userKey, event.name);
      await sharedPreferences.setString(_emailKey, event.email);
      await Future.delayed(const Duration(milliseconds: 500));
      emit(AuthAuthenticated(username: event.name, email: event.email));
    });

    on<UpdateProfileImageRequested>((event, emit) async {
      if (state is AuthAuthenticated) {
        final current = state as AuthAuthenticated;
        await sharedPreferences.setString(_imageKey, event.imagePath);
        emit(
          AuthAuthenticated(
            username: current.username,
            email: current.email,
            profileImagePath: event.imagePath,
          ),
        );
      }
    });

    on<ForgotPasswordRequested>((event, emit) async {
      emit(AuthLoading());
      await Future.delayed(const Duration(seconds: 1));
      if (event.email.contains('@')) {
        emit(OTPSent(event.email));
      } else {
        emit(const AuthFailure('Invalid email address'));
      }
    });

    on<VerifyOTPRequested>((event, emit) async {
      emit(AuthLoading());
      await Future.delayed(const Duration(seconds: 1));
      if (event.otp == '1234') {
        emit(const OTPVerified());
      } else {
        emit(const AuthFailure('Invalid OTP. Please try again.'));
      }
    });

    on<ResetPasswordRequested>((event, emit) async {
      emit(AuthLoading());
      await Future.delayed(const Duration(seconds: 1));
      if (event.newPassword.length >= 6) {
        emit(const PasswordReset());
      } else {
        emit(const AuthFailure('Password must be at least 6 characters'));
      }
    });
  }
}
