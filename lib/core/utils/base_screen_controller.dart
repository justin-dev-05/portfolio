import 'package:flutter/material.dart';

/// Base class for all screen controllers to ensure a consistent structure
abstract class BaseScreenController extends ChangeNotifier {
  /// Unique key for form validation if needed
  final formKey = GlobalKey<FormState>();

  /// Reactive boolean to track form validity
  bool _isFormValid = false;
  bool get isFormValid => _isFormValid;
  
  set isFormValid(bool value) {
    if (_isFormValid != value) {
      _isFormValid = value;
      notifyListeners();
    }
  }

  /// Needs to be called by the UI to clean up controllers
  @override
  void dispose() {
    super.dispose();
  }
  
  /// Perform validation logic
  void validateForm();

  /// Handle main action (login, submit, etc)
  void onSubmit();
}
