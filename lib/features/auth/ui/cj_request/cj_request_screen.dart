import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdi_dost/core/constants/app_colors.dart';
import 'package:pdi_dost/core/constants/app_strings.dart';
import 'package:pdi_dost/core/utils/app_snackbar.dart';
import 'package:pdi_dost/core/widgets/app_button.dart';
import 'package:pdi_dost/core/widgets/app_dialogs.dart';
import 'package:pdi_dost/core/widgets/app_text_field.dart';
import 'package:pdi_dost/core/widgets/common_scaffold.dart';
import 'package:pdi_dost/core/widgets/common_widgets.dart';
import 'package:pdi_dost/core/widgets/form_validation_helper.dart';
import 'package:pdi_dost/core/widgets/selection_dialog.dart';
import 'package:pdi_dost/features/auth/controller/cj_request_controller.dart';

class CjRequestScreen extends StatefulWidget {
  const CjRequestScreen({super.key});

  @override
  State<CjRequestScreen> createState() => _CjRequestScreenState();
}

class _CjRequestScreenState extends State<CjRequestScreen> {
  late CjRequestController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CjRequestController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return CommonScaffold(
      title: AppStrings.createCJRequest,
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, child) {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(
              left: 20.r,
              right: 20.r,
              top: 20.r,
              bottom: 60.r,
            ),
            child: Form(
              key: _controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppField(
                    label: AppStrings.fullName,
                    controller: _controller.name.text,
                    focusNode: _controller.name.focus,
                    hint: AppStrings.fullNameHint,
                    isRequired: true,
                    validator: FormValidators.required,
                    onChanged: (_) => _controller.validateForm(),
                  ),
                  SizedBox(height: 16.h),
                  AppField(
                    label: AppStrings.emailAddress,
                    controller: _controller.email.text,
                    focusNode: _controller.email.focus,
                    hint: AppStrings.emailHint,
                    isRequired: true,
                    keyboardType: TextInputType.emailAddress,
                    validator: FormValidators.email,
                    onChanged: (_) => _controller.validateForm(),
                  ),
                  SizedBox(height: 16.h),
                  AppField(
                    label: AppStrings.contactNo,
                    controller: _controller.contactNo.text,
                    focusNode: _controller.contactNo.focus,
                    hint: AppStrings.enterContactNo,
                    isRequired: true,
                    keyboardType: TextInputType.phone,
                    validator: (v) => FormValidators.phone(v, length: 10),
                    onChanged: (_) => _controller.validateForm(),
                  ),
                  SizedBox(height: 16.h),
                  AppField(
                    label: AppStrings.experienceYears,
                    controller: _controller.experience.text,
                    focusNode: _controller.experience.focus,
                    hint: AppStrings.enterExperience,
                    isRequired: true,
                    keyboardType: TextInputType.number,
                    validator: FormValidators.number,
                    onChanged: (_) => _controller.validateForm(),
                  ),
                  SizedBox(height: 16.h),
                  AppField(
                    label: AppStrings.address,
                    controller: _controller.address.text,
                    focusNode: _controller.address.focus,
                    hint: AppStrings.enterAddress,
                    isRequired: true,
                    maxLines: 3,
                    validator: FormValidators.required,
                    onChanged: (_) => _controller.validateForm(),
                  ),
                  SizedBox(height: 16.h),
                  AppField(
                    label: AppStrings.country,
                    controller: _controller.country.text,
                    focusNode: _controller.country.focus,
                    hint: AppStrings.selectCountry,
                    variant: FieldVariant.dropdown,
                    readOnly: true,
                    suffix: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.textSecondaryLight,
                    ),
                    onTap: () async {
                      final result = await SelectionDialog.show(
                        context,
                        title: AppStrings.country,
                        items: ["India", "USA", "UAE", "UK"],
                        selectedItem: _controller.selectedCountry,
                      );
                      if (result != null) _controller.updateCountry(result);
                    },
                  ),
                  SizedBox(height: 16.h),
                  AppField(
                    label: AppStrings.state,
                    controller: _controller.state.text,
                    focusNode: _controller.state.focus,
                    hint: AppStrings.selectState,
                    variant: FieldVariant.dropdown,
                    readOnly: true,
                    suffix: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.textSecondaryLight,
                    ),
                    onTap: () async {
                      if (_controller.selectedCountry == null) {
                        AppSnackBar.error(
                          context,
                          "Please select country first",
                        );
                        return;
                      }
                      final result = await SelectionDialog.show(
                        context,
                        title: AppStrings.state,
                        items: ["Gujarat", "Maharashtra", "Delhi", "Punjab"],
                        selectedItem: _controller.selectedState,
                      );
                      if (result != null) _controller.updateState(result);
                    },
                  ),
                  SizedBox(height: 16.h),
                  AppField(
                    label: AppStrings.city,
                    controller: _controller.city.text,
                    focusNode: _controller.city.focus,
                    hint: AppStrings.selectCity,
                    variant: FieldVariant.dropdown,
                    readOnly: true,
                    suffix: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.textSecondaryLight,
                    ),
                    onTap: () async {
                      if (_controller.selectedState == null) {
                        AppSnackBar.error(context, "Please select state first");
                        return;
                      }
                      final result = await SelectionDialog.show(
                        context,
                        title: AppStrings.city,
                        items: ["Ahmedabad", "Surat", "Mumbai", "Pune"],
                        selectedItem: _controller.selectedCity,
                      );
                      if (result != null) _controller.updateCity(result);
                    },
                  ),
                  SizedBox(height: 16.h),
                  AppFilePicker(
                    label: AppStrings.resume,
                    path: _controller.resumePath,
                    isRequired: true,
                    onTap: () => _onPickFile('resume'),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    AppStrings.identityVerification,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimaryColor(
                        isDark,
                      ).withValues(alpha: 0.85),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      AppRadioButton(
                        value: AppStrings.panCard,
                        isSelected:
                            _controller.selectedIdentity == AppStrings.panCard,
                        onChanged: _controller.updateIdentity,
                      ),
                      SizedBox(width: 16.w),
                      AppRadioButton(
                        value: AppStrings.aadhaarCard,
                        isSelected:
                            _controller.selectedIdentity ==
                            AppStrings.aadhaarCard,
                        onChanged: _controller.updateIdentity,
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  AppField(
                    label: _controller.selectedIdentity == AppStrings.panCard
                        ? AppStrings.panCardNo
                        : AppStrings.aadhaarCardNo,
                    controller: _controller.idNo.text,
                    focusNode: _controller.idNo.focus,
                    hint: _controller.selectedIdentity == AppStrings.panCard
                        ? AppStrings.enterPanCardNo
                        : AppStrings.enterAadhaarCardNo,
                    isRequired: true,
                    validator: FormValidators.required,
                    onChanged: (_) => _controller.validateForm(),
                  ),
                  SizedBox(height: 16.h),
                  AppFilePicker(
                    label: _controller.selectedIdentity == AppStrings.panCard
                        ? AppStrings.panCardImage
                        : AppStrings.aadhaarCardImage,
                    path: _controller.identityImagePath,
                    isRequired: true,
                    onTap: () => _onPickFile('identity'),
                  ),
                  SizedBox(height: 16.h),
                  AppFilePicker(
                    label: AppStrings.cancelCheckImage,
                    path: _controller.cancelCheckPath,
                    isRequired: false,
                    onTap: () => _onPickFile('cancelCheck'),
                  ),
                  SizedBox(height: 32.h),
                  AppButton(
                    text: AppStrings.createCJRequest,
                    isEnabled: _controller.isFormValid,
                    onPressed: _controller.onSubmit,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _onPickFile(String type) async {
    final source = await AppDialogs.showImagePickerDialog(context);
    if (source != null) {
      await _controller.pickFile(type, source);
    }
  }
}
