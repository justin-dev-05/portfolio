import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final String username;
  final String email;
  final String? profileImagePath;

  const AuthAuthenticated({
    required this.username,
    required this.email,
    this.profileImagePath,
  });
  @override
  List<Object?> get props => [username, email, profileImagePath];
}

class AuthUnauthenticated extends AuthState {}

class AuthFailure extends AuthState {
  final String message;
  const AuthFailure(this.message);
  @override
  List<Object?> get props => [message];
}

class OTPSent extends AuthState {
  final String email;
  const OTPSent(this.email);
  @override
  List<Object?> get props => [email];
}

class OTPVerified extends AuthState {
  const OTPVerified();
}

class PasswordReset extends AuthState {
  const PasswordReset();
}
