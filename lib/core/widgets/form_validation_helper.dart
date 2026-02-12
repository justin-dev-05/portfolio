import 'package:flutter/material.dart';

class FormValidationHelper {
  final Map<String, String> _fieldValues = {};
  final Map<String, String?> _fieldErrors = {};
  final ValueNotifier<bool> isFormValid = ValueNotifier(false);

  /// Update a field's value and error state
  void updateField(String fieldName, String value, {String? error}) {
    _fieldValues[fieldName] = value;
    _fieldErrors[fieldName] = error;
    _checkFormValidity();
  }

  /// Mark a field as having an error
  void setFieldError(String fieldName, String? error) {
    _fieldErrors[fieldName] = error;
    _checkFormValidity();
  }

  /// Get a field's current value
  String? getFieldValue(String fieldName) => _fieldValues[fieldName];

  /// Get a field's current error
  String? getFieldError(String fieldName) => _fieldErrors[fieldName];

  /// Check if all fields are valid
  void _checkFormValidity() {
    final hasValues = _fieldValues.values.every((value) => value.isNotEmpty);
    final hasNoErrors = _fieldErrors.values.every((error) => error == null);
    isFormValid.value = hasValues && hasNoErrors && _fieldValues.isNotEmpty;
  }

  /// Reset all fields
  void reset() {
    _fieldValues.clear();
    _fieldErrors.clear();
    isFormValid.value = false;
  }

  /// Get all field values as a map
  Map<String, String> getAllValues() => Map.from(_fieldValues);

  /// Dispose the notifier
  void dispose() {
    isFormValid.dispose();
  }
}

/// Common form validators
class FormValidators {
  /// Required field validator
  static String? required(String? value, {String? message}) {
    if (value == null || value.trim().isEmpty) {
      return message ?? 'This field is required';
    }
    return null;
  }

  /// Email validator
  static String? email(String? value, {String? message}) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)+$',
    );

    if (!emailRegex.hasMatch(value)) {
      return message ?? 'Please enter a valid email';
    }
    return null;
  }

  /// Password validator (min 8 chars, letters + numbers)
  static String? password(String? value, {String? message, int minLength = 8}) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < minLength) {
      return 'Password must be at least $minLength characters';
    }

    if (value.contains(' ')) {
      return 'Password cannot contain spaces';
    }

    final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*?&]+$');
    if (!passwordRegex.hasMatch(value)) {
      return message ?? 'Password must contain letters and numbers';
    }

    return null;
  }

  /// Confirm password validator
  static String? confirmPassword(String? value, String? originalPassword) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value != originalPassword) {
      return 'Passwords do not match';
    }

    return null;
  }

  /// Password match validator (alias for confirmPassword)
  static String? passwordMatch(String? value, String? originalPassword) {
    return confirmPassword(value, originalPassword);
  }

  /// Phone number validator
  static String? phone(String? value, {String? message, int length = 10}) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }

    final phoneRegex = RegExp(r'^\d{' + length.toString() + r'}$');
    if (!phoneRegex.hasMatch(value.replaceAll(RegExp(r'[\s-]'), ''))) {
      return message ?? 'Please enter a valid $length-digit phone number';
    }

    return null;
  }

  /// Minimum length validator
  static String? minLength(String? value, int minLength, {String? message}) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }

    if (value.length < minLength) {
      return message ?? 'Must be at least $minLength characters';
    }

    return null;
  }

  /// Maximum length validator
  static String? maxLength(String? value, int maxLength, {String? message}) {
    if (value != null && value.length > maxLength) {
      return message ?? 'Must be at most $maxLength characters';
    }
    return null;
  }

  /// Number validator
  static String? number(String? value, {String? message}) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }

    if (double.tryParse(value) == null) {
      return message ?? 'Please enter a valid number';
    }

    return null;
  }

  /// Number range validator
  static String? numberRange(
    String? value, {
    double? min,
    double? max,
    String? message,
  }) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }

    final num = double.tryParse(value);
    if (num == null) {
      return 'Please enter a valid number';
    }

    if (min != null && num < min) {
      return message ?? 'Must be at least $min';
    }

    if (max != null && num > max) {
      return message ?? 'Must be at most $max';
    }

    return null;
  }

  /// URL validator
  static String? url(String? value, {String? message}) {
    if (value == null || value.trim().isEmpty) {
      return 'URL is required';
    }

    final urlRegex = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    );

    if (!urlRegex.hasMatch(value)) {
      return message ?? 'Please enter a valid URL';
    }

    return null;
  }

  /// Combine multiple validators
  static String? Function(String?) combine(
    List<String? Function(String?)> validators,
  ) {
    return (String? value) {
      for (final validator in validators) {
        final error = validator(value);
        if (error != null) return error;
      }
      return null;
    };
  }
}
