// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdi_dost/core/network/api_state.dart';
import 'app_dialog.dart';

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
              title: 'Error',
              message: state.errorMessage ?? 'Something went wrong',
              positiveButton: 'Okay',
              icon: Icons.error_outline_rounded,
              iconColor: Colors.red,
            );
          });
        }

        if (state.isSuccess) {
          AppDialogs.hideLoading(rootContext);

          if (autoPopOnSuccess && Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }

          if (showSuccessDialog) {
            Future.microtask(() {
              AppDialogs.showMessage(
                context: rootContext,
                title: 'Success',
                message: successMessage ?? 'Operation completed successfully',
                positiveButton: 'Submit',
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
