import 'package:pdi_dost/core/utils/base_screen_controller.dart';
import 'package:pdi_dost/core/widgets/app_text_field.dart';
import 'package:pdi_dost/core/widgets/form_validation_helper.dart';
import 'package:pdi_dost/features/auth/bloc/auth/auth_bloc.dart';

class LoginController extends BaseScreenController {
  final AuthBloc authBloc;

  final email = FieldController();
  final password = FieldController();

  LoginController({required this.authBloc});

  @override
  void validateForm() {
    final isEmailValid = FormValidators.email(email.text.text.trim()) == null;
    final isPasswordValid = password.text.text.trim().isNotEmpty;

    isFormValid = isEmailValid && isPasswordValid;
  }

  @override
  void onSubmit() {
    authBloc.add(
      LoginSubmitted(email.text.text.trim(), password.text.text.trim()),
    );
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
}
