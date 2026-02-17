import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdi_dost/core/constants/api_constants.dart';
import 'package:pdi_dost/core/constants/app_strings.dart';
import 'package:pdi_dost/core/data/user_preferences.dart';
import 'package:pdi_dost/core/network/http_client.dart';
import 'package:pdi_dost/features/auth/model/LoginModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_event.dart';
import 'auth_state.dart';

export 'auth_event.dart';
export 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SharedPreferences sharedPreferences;
  final AppHttpClient httpClient;

  AuthBloc({required this.sharedPreferences, required this.httpClient})
    : super(AuthInitial()) {
    on<AuthCheckRequested>((event, emit) async {
      emit(AuthLoading());
      await Future.delayed(const Duration(seconds: 1));

      final userData = await UserPreferences().getSignInInfo();

      if (userData != null) {
        emit(
          AuthAuthenticated(
            username: userData.name,
            email: userData.emailId,
            profileImagePath: userData.profileImage,
            userData: userData,
          ),
        );
      } else {
        emit(AuthUnauthenticated());
      }
    });

    on<CjRequestSubmitted>((event, emit) async {
      // ... existing code ...
      emit(AuthLoading());
      try {
        final Map<String, File> files = {};
        for (final entry in event.filePaths.entries) {
          if (entry.value.isNotEmpty) {
            files[entry.key] = File(entry.value);
          }
        }

        final response = await httpClient.postMultipart(
          ApiConstants.cjRequest,
          fields: event.fields,
          files: files,
        );

        if (response != null && response['status'] == true) {
          emit(CjRequestSuccess(response['message'] ?? 'Request submitted'));
        } else {
          final message = response?['message'] ?? 'Something went wrong';
          final errors = response?['errors'] as Map<String, dynamic>?;

          if (errors != null && errors.isNotEmpty) {
            final firstFieldErrors = errors.values.first as List;
            final firstErrorMessage = firstFieldErrors.first.toString();
            emit(AuthFailure(firstErrorMessage));
          } else {
            emit(AuthFailure(message));
          }
        }
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<AuthLoginRequested>(
      (event, emit) => _handleLogin(event.email, event.password, emit),
    );
    on<LoginSubmitted>(
      (event, emit) => _handleLogin(event.email, event.password, emit),
    );
    on<AuthLogoutRequested>((event, emit) async {
      emit(AuthLoading());
      await UserPreferences().clearSignInInfo();
      emit(AuthUnauthenticated());
    });

    on<ForgotPasswordRequested>((event, emit) async {
      emit(AuthLoading());
      await Future.delayed(const Duration(seconds: 1));
      if (event.email.contains('@')) {
        emit(OTPSent(event.email));
      } else {
        emit(const AuthFailure(AppStrings.invalidEmailAddress));
      }
    });

    on<VerifyOTPRequested>((event, emit) async {
      emit(AuthLoading());
      await Future.delayed(const Duration(seconds: 1));
      if (event.otp == '1234') {
        emit(const OTPVerified());
      } else {
        emit(const AuthFailure(AppStrings.invalidOtpTryAgain));
      }
    });

    on<ResetPasswordRequested>((event, emit) async {
      emit(AuthLoading());
      await Future.delayed(const Duration(seconds: 1));
      if (event.newPassword.length >= 6) {
        emit(const PasswordReset());
      } else {
        emit(const AuthFailure(AppStrings.passwordMin6Chars));
      }
    });
    on<ChangePasswordRequested>((event, emit) async {
      emit(AuthLoading());
      await Future.delayed(const Duration(seconds: 2));
      // Mock success
      emit(const PasswordChanged());
    });

    on<AuthResetStateRequested>((event, emit) {
      if (state is! AuthAuthenticated) {
        emit(AuthInitial());
      }
    });
  }

  Future<void> _handleLogin(
    String email,
    String password,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final Map<String, dynamic> body = {
        "email_id": email,
        "password": password,
      };

      final response = await httpClient.post(ApiConstants.login, body);

      if (response != null && response['status'] == true) {
        final loginModel = LoginModel.fromJson(response);
        final user = loginModel.data;

        await UserPreferences().saveSignInInfo(user);

        emit(
          AuthAuthenticated(
            username: user.name,
            email: user.emailId,
            profileImagePath: user.profileImage,
            userData: user,
          ),
        );
      } else {
        final message = response?['message'] ?? 'Login failed';
        final errors = response?['errors'] as Map<String, dynamic>?;

        if (errors != null && errors.isNotEmpty) {
          final firstFieldErrors = errors.values.first as List;
          final firstErrorMessage = firstFieldErrors.first.toString();
          emit(AuthFailure(firstErrorMessage));
        } else {
          emit(AuthFailure(message));
        }
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
