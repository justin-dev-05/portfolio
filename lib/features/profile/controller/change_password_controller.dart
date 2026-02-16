import 'package:flutter/material.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/form_validation_helper.dart';
import '../../auth/bloc/auth/auth_bloc.dart';

class ChangePasswordController extends ChangeNotifier {
  final AuthBloc authBloc;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final FieldController currentPassword = FieldController();
  final FieldController newPassword = FieldController();
  final FieldController confirmPassword = FieldController();

  ChangePasswordController({required this.authBloc});

  bool _isFormValid = false;
  bool get isFormValid => _isFormValid;

  void validateForm() {
    final curPass = currentPassword.text.text.trim();
    final newPass = newPassword.text.text.trim();
    final confPass = confirmPassword.text.text.trim();

    final isCurValid = curPass.isNotEmpty;
    final isNewValid = FormValidators.password(newPass) == null;
    final isConfValid = confPass == newPass && confPass.isNotEmpty;

    _isFormValid = isCurValid && isNewValid && isConfValid;
    notifyListeners();
  }

  void onSubmit() {
    if (formKey.currentState!.validate()) {
      authBloc.add(
        ChangePasswordRequested(
          currentPassword: currentPassword.text.text.trim(),
          newPassword: newPassword.text.text.trim(),
        ),
      );
    }
  }

  @override
  void dispose() {
    currentPassword.dispose();
    newPassword.dispose();
    confirmPassword.dispose();
    super.dispose();
  }
}
