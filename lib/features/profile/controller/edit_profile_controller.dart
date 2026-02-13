import 'package:pdi_dost/core/constants/app_strings.dart';
import 'package:pdi_dost/core/utils/base_screen_controller.dart';
import 'package:pdi_dost/core/widgets/app_text_field.dart';
import 'package:pdi_dost/core/widgets/form_validation_helper.dart';
import 'package:pdi_dost/features/auth/bloc/auth/auth_bloc.dart';

class EditProfileController extends BaseScreenController {
  final AuthBloc authBloc;

  final name = FieldController();
  final email = FieldController();

  EditProfileController({required this.authBloc}) {
    // Initialize initial data from SharedPreferences
    final prefs = authBloc.sharedPreferences;
    name.text.text = prefs.getString('USER_NAME') ?? '';
    email.text.text = prefs.getString('USER_EMAIL') ?? '';

    // Check initial validity
    validateForm();
  }

  @override
  void validateForm() {
    final isNameValid =
        FormValidators.required(
          name.text.text.trim(),
          message: ValidationStrings.nameRequired,
        ) ==
        null;
    final isEmailValid = FormValidators.email(email.text.text.trim()) == null;

    isFormValid = isNameValid && isEmailValid;
  }

  @override
  void onSubmit() {
    if (formKey.currentState!.validate()) {
      authBloc.add(
        UpdateProfileRequested(
          name: name.text.text.trim(),
          email: email.text.text.trim(),
        ),
      );
    }
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    super.dispose();
  }
}
