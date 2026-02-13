// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdi_dost/core/constants/app_strings.dart';
import 'package:pdi_dost/core/network/api_state.dart';
import 'package:pdi_dost/core/utils/app_nav.dart';
import 'package:pdi_dost/core/widgets/app_dialogs.dart';

class ApiStatusListener<B extends BlocBase<S>, S extends ApiState>
    extends StatelessWidget {
  final Widget child;
  final bool showSuccessDialog;
  final bool autoPopOnSuccess;
  final String? successMessage;

  const ApiStatusListener({
    super.key,
    required this.child,
    this.showSuccessDialog = false,
    this.autoPopOnSuccess = false,
    this.successMessage,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<B, S>(
      listenWhen: (prev, curr) =>
          prev.isLoading != curr.isLoading ||
          prev.isFailure != curr.isFailure ||
          prev.isSuccess != curr.isSuccess,
      listener: (context, state) {
        final rootContext = Navigator.of(context, rootNavigator: true).context;

        if (state.isLoading) {
          AppDialogs.showLoading(rootContext);
        }

        if (state.isFailure) {
          AppDialogs.hideLoading(rootContext);

          Future.microtask(() {
            AppDialogs.showMessage(
              context: rootContext,
              title: AppStrings.error,
              message: state.errorMessage ?? 'Something went wrong',
              positiveButton: AppStrings.okay,
              icon: Icons.error_outline_rounded,
              iconColor: Colors.red,
            );
          });
        }

        if (state.isSuccess) {
          AppDialogs.hideLoading(rootContext);

          if (autoPopOnSuccess && Navigator.of(context).canPop()) {
            AppNav.pop(context);
          }

          if (showSuccessDialog) {
            Future.microtask(() {
              AppDialogs.showMessage(
                context: rootContext,
                title: AppStrings.success,
                message: successMessage ?? AppStrings.operationCompletedSuccess,
                positiveButton: AppStrings.submit,
                icon: Icons.check_circle_outline_rounded,
                iconColor: Colors.green,
              );
            });
          }
        }
      },
      child: child,
    );
  }
}
