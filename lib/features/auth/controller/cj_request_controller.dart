import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdi_dost/core/widgets/app_text_field.dart';
import 'package:pdi_dost/core/widgets/form_validation_helper.dart';

class CjRequestController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  // Form Fields
  final name = FieldController();
  final email = FieldController();
  final contactNo = FieldController();
  final experience = FieldController();
  final address = FieldController();
  final idNo = FieldController();
  final country = FieldController();
  final state = FieldController();
  final city = FieldController();

  // Selection Fields
  String? selectedPlatform;
  String? selectedCountry;
  String? selectedState;
  String? selectedCity;
  String selectedIdentity = "PAN Card"; // Default

  // File Paths
  String? resumePath;
  String? identityImagePath;
  String? cancelCheckPath;

  bool isFormValid = false;

  void validateForm() {
    // Silent validation for button enablement
    final isNameValid = FormValidators.required(name.text.text) == null;
    final isEmailValid = FormValidators.email(email.text.text) == null;
    final isContactValid =
        FormValidators.phone(contactNo.text.text, length: 10) == null;
    final isExpValid = FormValidators.number(experience.text.text) == null;
    final isAddressValid = FormValidators.required(address.text.text) == null;
    final isIdNoValid = FormValidators.required(idNo.text.text) == null;

    final hasFiles = resumePath != null && identityImagePath != null;

    final isValid =
        isNameValid &&
        isEmailValid &&
        isContactValid &&
        isExpValid &&
        isAddressValid &&
        isIdNoValid &&
        hasFiles;

    if (isFormValid != isValid) {
      isFormValid = isValid;
      notifyListeners();
    }
  }

  void updateIdentity(String value) {
    selectedIdentity = value;
    idNo.text.clear();
    identityImagePath = null;
    validateForm();
    notifyListeners();
  }

  void updatePlatform(String? value) {
    selectedPlatform = value;
    validateForm();
    notifyListeners();
  }

  void updateCountry(String? value) {
    selectedCountry = value;
    country.text.text = value ?? "";
    selectedState = null;
    state.text.clear();
    selectedCity = null;
    city.text.clear();
    validateForm();
    notifyListeners();
  }

  void updateState(String? value) {
    selectedState = value;
    state.text.text = value ?? "";
    selectedCity = null;
    city.text.clear();
    validateForm();
    notifyListeners();
  }

  void updateCity(String? value) {
    selectedCity = value;
    city.text.text = value ?? "";
    validateForm();
    notifyListeners();
  }

  Future<void> pickFile(String type, ImageSource source) async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      if (type == 'resume') {
        resumePath = image.path;
      } else if (type == 'identity') {
        identityImagePath = image.path;
      } else if (type == 'cancelCheck') {
        cancelCheckPath = image.path;
      }
      validateForm();
      notifyListeners();
    }
  }

  void onSubmit() {
    if (isFormValid) {
      // Logic to submit the request
    }
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    contactNo.dispose();
    experience.dispose();
    address.dispose();
    idNo.dispose();
    country.dispose();
    state.dispose();
    city.dispose();
    super.dispose();
  }
}
