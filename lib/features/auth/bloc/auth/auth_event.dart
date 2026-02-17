import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class AuthCheckRequested extends AuthEvent {}

class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;
  const AuthLoginRequested(this.email, this.password);
  @override
  List<Object?> get props => [email, password];
}

class LoginSubmitted extends AuthEvent {
  final String email;
  final String password;
  const LoginSubmitted(this.email, this.password);
  @override
  List<Object?> get props => [email, password];
}

class AuthLogoutRequested extends AuthEvent {}

class ForgotPasswordRequested extends AuthEvent {
  final String email;
  const ForgotPasswordRequested(this.email);
  @override
  List<Object?> get props => [email];
}

class VerifyOTPRequested extends AuthEvent {
  final String otp;
  const VerifyOTPRequested(this.otp);
  @override
  List<Object?> get props => [otp];
}

class ResetPasswordRequested extends AuthEvent {
  final String newPassword;
  const ResetPasswordRequested(this.newPassword);
  @override
  List<Object?> get props => [newPassword];
}

class UpdateProfileRequested extends AuthEvent {
  final String name;
  final String email;

  const UpdateProfileRequested({required this.name, required this.email});

  @override
  List<Object?> get props => [name, email];
}

class UpdateProfileImageRequested extends AuthEvent {
  final String imagePath;
  const UpdateProfileImageRequested(this.imagePath);

  @override
  List<Object?> get props => [imagePath];
}

class ChangePasswordRequested extends AuthEvent {
  final String currentPassword;
  final String newPassword;

  const ChangePasswordRequested({
    required this.currentPassword,
    required this.newPassword,
  });

  @override
  List<Object?> get props => [currentPassword, newPassword];
}

class AuthResetStateRequested extends AuthEvent {}

class CjRequestSubmitted extends AuthEvent {
  final Map<String, String> fields;
  final Map<String, String> filePaths;

  const CjRequestSubmitted({required this.fields, required this.filePaths});

  @override
  List<Object?> get props => [fields, filePaths];
}
