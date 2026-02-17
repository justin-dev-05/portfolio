import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdi_dost/core/widgets/app_dialogs.dart';

class ApiStateBlocListener<B extends BlocBase<S>, S> extends StatefulWidget {
  final Widget child;

  /// The Type of the loading state (e.g., AuthLoading)
  final Type loadingStateType;

  /// The Type of the success state (e.g., AuthAuthenticated)
  final Type successStateType;

  /// The Type of the failure state (e.g., AuthFailure)
  final Type failureStateType;

  /// Function to extract error message from failure state
  final String? Function(S state)? errorExtractor;

  /// Function to extract success message from success state
  final String? Function(S state)? successMessageExtractor;

  /// Whether to show success dialog
  final bool showSuccessDialog;

  /// Whether to automatically pop the current route on success
  final bool autoPopOnSuccess;

  /// Success message to display (fallback if extractor is null or returns null)
  final String? successMessage;

  /// Success dialog title
  final String successTitle;

  /// Error dialog title
  final String errorTitle;

  /// Custom callback on success
  final VoidCallback? onSuccess;

  /// Custom callback on failure
  final VoidCallback? onFailure;

  const ApiStateBlocListener({
    super.key,
    required this.child,
    required this.loadingStateType,
    required this.successStateType,
    required this.failureStateType,
    this.errorExtractor,
    this.successMessageExtractor,
    this.showSuccessDialog = false,
    this.autoPopOnSuccess = false,
    this.successMessage,
    this.successTitle = 'Success',
    this.errorTitle = 'Error',
    this.onSuccess,
    this.onFailure,
  });

  @override
  State<ApiStateBlocListener<B, S>> createState() =>
      _ApiStateBlocListenerState<B, S>();
}

class _ApiStateBlocListenerState<B extends BlocBase<S>, S>
    extends State<ApiStateBlocListener<B, S>> {
  bool _iStartedLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<B, S>(
      listener: (context, state) {
        final stateType = state.runtimeType;
        final isCurrent = ModalRoute.of(context)?.isCurrent ?? true;

        if (!isCurrent && !_iStartedLoading) return;

        if (stateType == widget.loadingStateType) {
          if (isCurrent) {
            _iStartedLoading = true;
            AppDialogs.showLoading(context);
          }
        } else if (stateType == widget.successStateType) {
          if (_iStartedLoading) {
            _iStartedLoading = false;
            AppDialogs.hideLoading(context);
          }

          if (widget.autoPopOnSuccess && Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }

          if (widget.showSuccessDialog) {
            final msg =
                widget.successMessageExtractor?.call(state) ??
                widget.successMessage ??
                'Operation completed successfully';
            AppDialogs.showMessage(
              context: context,
              title: widget.successTitle,
              message: msg,
              positiveButton: 'Okay',
              icon: Icons.check_circle_outline_rounded,
              iconColor: Colors.green,
              callback: widget.onSuccess,
            );
          } else {
            widget.onSuccess?.call();
          }
        } else if (stateType == widget.failureStateType) {
          if (_iStartedLoading) {
            _iStartedLoading = false;
            AppDialogs.hideLoading(context);
          }

          final errorMessage =
              widget.errorExtractor?.call(state) ?? 'Something went wrong';

          AppDialogs.showMessage(
            context: context,
            title: widget.errorTitle,
            message: errorMessage,
            positiveButton: 'Okay',
            icon: Icons.error_outline_rounded,
            iconColor: Colors.red,
            callback: widget.onFailure,
          );
        } else {
          _iStartedLoading = false;
        }
      },
      child: widget.child,
    );
  }
}
