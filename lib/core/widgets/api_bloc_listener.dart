import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_dialog.dart';

class ApiBlocListener<B extends BlocBase<S>, S> extends StatelessWidget {
  final Widget child;

  /// Function to extract the status from your state (e.g., TodoStatus, AuthStatus)
  final Enum Function(S state) statusSelector;

  /// Function to extract error message from your state
  final String? Function(S state)? errorSelector;

  /// The enum value that represents "loading" state
  final Enum loadingValue;

  /// The enum value that represents "success" state
  final Enum successValue;

  /// The enum value that represents "failure" state
  final Enum failureValue;

  /// Whether to show success dialog
  final bool showSuccessDialog;

  /// Whether to automatically pop the current route on success
  final bool autoPopOnSuccess;

  /// Success message to display
  final String? successMessage;

  /// Success dialog title
  final String successTitle;

  /// Error dialog title
  final String errorTitle;

  /// Custom callback on success
  final VoidCallback? onSuccess;

  /// Custom callback on failure
  final VoidCallback? onFailure;

  const ApiBlocListener({
    super.key,
    required this.child,
    required this.statusSelector,
    required this.loadingValue,
    required this.successValue,
    required this.failureValue,
    this.errorSelector,
    this.showSuccessDialog = false,
    this.autoPopOnSuccess = false,
    this.successMessage,
    this.successTitle = 'Success',
    this.errorTitle = 'Error',
    this.onSuccess,
    this.onFailure,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<B, S>(
      listenWhen: (previous, current) {
        final prevStatus = statusSelector(previous);
        final currStatus = statusSelector(current);
        return prevStatus != currStatus;
      },
      listener: (context, state) {
        final status = statusSelector(state);

        if (status == loadingValue) {
          AppDialogs.showLoading(context);
        } else if (status == successValue) {
          if (autoPopOnSuccess && Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }

          if (showSuccessDialog) {
            AppDialogs.showMessage(
              context: context,
              title: successTitle,
              message: successMessage ?? 'Operation completed successfully',
              positiveButton: 'Submit',
              icon: Icons.check_circle_outline_rounded,
              iconColor: Colors.green,
              callback: onSuccess,
            );
          }
        } else if (status == failureValue) {
          final errorMessage =
              errorSelector?.call(state) ?? 'Something went wrong';

          AppDialogs.showMessage(
            context: context,
            title: errorTitle,
            message: errorMessage,
            positiveButton: 'Submit',
            icon: Icons.error_outline_rounded,
            iconColor: Colors.red,
            callback: onFailure,
          );
        }
      },
      child: child,
    );
  }
}
