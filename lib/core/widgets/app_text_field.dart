import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdi_dost/core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';

class FieldController {
  final TextEditingController text;
  final FocusNode focus;

  FieldController() : text = TextEditingController(), focus = FocusNode();

  void dispose() {
    text.dispose();
    focus.dispose();
  }
}

enum FieldVariant { normal, password, search, dropdown }

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.hint,
    this.errorText,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.enabled = true,
    this.readOnly = false,
    this.variant = FieldVariant.normal,
    this.onTap,
    this.prefix,
    this.suffix,
    this.maxLines = 1,
    this.validator,
    this.autovalidateMode,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final String hint;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType;
  final bool enabled;
  final bool readOnly;
  final FieldVariant variant;
  final VoidCallback? onTap;
  final Widget? prefix;
  final Widget? suffix;
  final int maxLines;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.variant == FieldVariant.password;
  }

  @override
  Widget build(BuildContext context) {
    final isPassword = widget.variant == FieldVariant.password;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      obscureText: _obscureText,
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLines,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      validator: widget.validator,
      autovalidateMode: widget.autovalidateMode,
      style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: theme.textTheme.bodyLarge?.copyWith(
          color: AppColors.textSecondaryLight.withValues(alpha: 0.6),
        ),
        errorText: widget.errorText,
        prefixIcon: widget.prefix != null
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: IconTheme(
                  data: IconThemeData(
                    color: widget.focusNode.hasFocus
                        ? AppColors.primaryLight
                        : AppColors.textSecondaryLight,
                    size: 22.sp,
                  ),
                  child: widget.prefix!,
                ),
              )
            : null,
        prefixIconConstraints: BoxConstraints(minWidth: 40.w),
        suffixIcon: isPassword
            ? GestureDetector(
                onTap: () => setState(() => _obscureText = !_obscureText),
                child: Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: Icon(
                    _obscureText
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 22.sp,
                    color: _obscureText
                        ? AppColors.textPrimaryLight
                        : AppColors.primaryLight,
                  ),
                ),
              )
            : widget.suffix != null
            ? Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: widget.suffix,
              )
            : null,
        suffixIconConstraints: BoxConstraints(minWidth: 40.w),
        filled: true,
        fillColor: widget.enabled
            ? (widget.focusNode.hasFocus
                  ? AppColors.primaryLight.withValues(alpha: 0.1)
                  : AppColors.surfaceGreyColor(isDark).withValues(alpha: 0.5))
            : AppColors.surfaceGreyColor(isDark),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        border: _buildBorder(AppColors.textPrimaryLight.withValues(alpha: 0.2)),
        enabledBorder: _buildBorder(
          AppColors.textPrimaryLight.withValues(alpha: 0.1),
        ),
        focusedBorder: _buildBorder(AppColors.primaryLight, width: 1.5),
        errorBorder: _buildBorder(AppColors.error),
        focusedErrorBorder: _buildBorder(AppColors.error, width: 1.5),
        disabledBorder: _buildBorder(
          AppColors.textPrimaryLight.withValues(alpha: 0.05),
        ),
      ),
    );
  }

  OutlineInputBorder _buildBorder(Color color, {double width = 1.0}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}

class AppField extends StatefulWidget {
  const AppField({
    super.key,
    required this.label,
    required this.controller,
    required this.focusNode,
    required this.hint,
    this.errorText,
    this.onChanged,
    this.isRequired = false,
    this.variant = FieldVariant.normal,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.onTap,
    this.prefix,
    this.suffix,
    this.maxLines = 1,
    this.validator,
    this.autovalidateMode,
    this.helperText,
    this.maxLength,
    this.showCharacterCount = false,
    this.enabled = true,
  });

  final String label;
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hint;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final bool isRequired;
  final FieldVariant variant;
  final TextInputType keyboardType;
  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? prefix;
  final Widget? suffix;
  final int maxLines;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final String? helperText;
  final int? maxLength;
  final bool showCharacterCount;
  final bool enabled;

  @override
  State<AppField> createState() => _AppFieldState();
}

class _AppFieldState extends State<AppField> {
  String? _currentError;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    if (widget.autovalidateMode == AutovalidateMode.onUserInteraction ||
        widget.autovalidateMode == AutovalidateMode.always) {
      _validateField();
    }
  }

  void _validateField() {
    if (widget.validator != null) {
      final error = widget.validator!(widget.controller.text);
      if (error != _currentError) {
        setState(() {
          _currentError = error;
        });
        widget.onChanged?.call(widget.controller.text);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Use external error if provided, otherwise use internal validation error
    final displayError = widget.errorText ?? _currentError;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label with required indicator
        Padding(
          padding: EdgeInsets.only(left: 4.w, bottom: 8.h),
          child: RichText(
            text: TextSpan(
              text: widget.label,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimaryColor(
                  isDark,
                ).withValues(alpha: 0.85),
              ),
              children: [
                if (widget.isRequired)
                  TextSpan(
                    text: ' *',
                    style: TextStyle(color: AppColors.error, fontSize: 14.sp),
                  ),
              ],
            ),
          ),
        ),

        // Text field
        AppTextField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          hint: widget.hint,
          errorText: displayError,
          onChanged: (value) {
            _validateField();
            widget.onChanged?.call(value);
          },
          keyboardType: widget.keyboardType,
          variant: widget.variant,
          readOnly: widget.readOnly,
          enabled: widget.enabled,
          onTap: widget.onTap,
          prefix: widget.prefix,
          suffix: widget.suffix,
          maxLines: widget.maxLines,
          validator: widget.validator,
          autovalidateMode: widget.autovalidateMode,
        ),

        // Helper text or character count
        if (widget.helperText != null || widget.showCharacterCount) ...[
          SizedBox(height: 4.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (widget.helperText != null)
                  Expanded(
                    child: Text(
                      widget.helperText!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondaryColor(isDark),
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                if (widget.showCharacterCount && widget.maxLength != null)
                  Text(
                    '${widget.controller.text.length}/${widget.maxLength}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: widget.controller.text.length > widget.maxLength!
                          ? AppColors.error
                          : AppColors.textSecondaryColor(isDark),
                      fontSize: 12.sp,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class ValidationResult {
  final String value;
  final String? error;
  final bool isValid;

  const ValidationResult({
    required this.value,
    this.error,
    required this.isValid,
  });

  factory ValidationResult.valid(String value) =>
      ValidationResult(value: value, isValid: true);

  factory ValidationResult.invalid(String value, String error) =>
      ValidationResult(value: value, error: error, isValid: false);
}

enum FieldType {
  otp,
  common,
  email,
  pincode,
  number,
  password,
  confirmPassword,
  selection,
}

class FormValidator {
  static ValidationResult validate({
    required String value,
    required FieldType type,

    // optional messages
    String? error1,
    String? error2,
    String? error3,

    // optional dependencies
    String? confirmPasswordValue,
    double? totalAmount,
    String? mediumGroupValue,
    String? roleGroupValue,
  }) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)+$',
    );

    final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*?&]+$');

    /// ---------------- SELECTION ----------------
    if (type == FieldType.selection) {
      if (mediumGroupValue == '' || roleGroupValue == '') {
        return ValidationResult.invalid(
          value,
          error1 ?? ValidationStrings.selectionRequired,
        );
      }
      return ValidationResult.valid(value);
    }

    /// ---------------- EMPTY ----------------
    if (value.isEmpty) {
      return ValidationResult.invalid(
        value,
        error1 ?? ValidationStrings.requiredField,
      );
    }

    /// ---------------- SPACE ----------------
    if (value.startsWith(' ')) {
      return ValidationResult.invalid(
        value,
        ValidationStrings.removeSpaceAtBeginning,
      );
    }

    /// ---------------- TYPE VALIDATION ----------------
    switch (type) {
      case FieldType.otp:
        if (value.length != 4) {
          return ValidationResult.invalid(
            value,
            error2 ?? ValidationStrings.invalidOtp,
          );
        }
        break;

      case FieldType.email:
        if (!value.contains('@')) {
          return ValidationResult.invalid(
            value,
            error2 ?? ValidationStrings.invalidEmail,
          );
        }
        if (!emailRegex.hasMatch(value)) {
          return ValidationResult.invalid(
            value,
            error3 ?? ValidationStrings.invalidEmail,
          );
        }
        break;

      case FieldType.pincode:
        if (value.length != 6) {
          return ValidationResult.invalid(
            value,
            error2 ?? ValidationStrings.invalidPincode,
          );
        }
        break;

      case FieldType.number:
        final parsed = double.tryParse(value);
        if (parsed == null || parsed <= 0) {
          return ValidationResult.invalid(
            value,
            error1 ?? ValidationStrings.invalidNumber,
          );
        }
        if (totalAmount != null && parsed > totalAmount) {
          return ValidationResult.invalid(
            value,
            error2 ?? ValidationStrings.amountExceedsTotal,
          );
        }
        break;

      case FieldType.password:
        if (value.contains(' ')) {
          return ValidationResult.invalid(
            value,
            error2 ?? ValidationStrings.noSpacesAllowed,
          );
        }
        if (value.length < 8) {
          return ValidationResult.invalid(
            value,
            error3 ?? ValidationStrings.min8Chars,
          );
        }
        if (value.length > 16) {
          return ValidationResult.invalid(
            value,
            ValidationStrings.passwordTooLong,
          );
        }
        if (!passwordRegex.hasMatch(value)) {
          return ValidationResult.invalid(
            value,
            ValidationStrings.lettersAndNumbers,
          );
        }
        break;

      case FieldType.confirmPassword:
        if (value != confirmPasswordValue) {
          return ValidationResult.invalid(
            value,
            error3 ?? ValidationStrings.passwordsDoNotMatch,
          );
        }
        break;

      case FieldType.common:
      case FieldType.selection:
        break;
    }

    return ValidationResult.valid(value);
  }
}
