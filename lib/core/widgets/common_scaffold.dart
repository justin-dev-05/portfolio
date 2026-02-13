import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdi_dost/core/network/network_cubit.dart';
import 'package:pdi_dost/core/widgets/no_internet_widget.dart';
import 'package:pdi_dost/core/widgets/toolbar.dart';

class CommonScaffold extends StatelessWidget {
  final String? title;
  final Widget body;
  final Widget? floatingActionButton;
  final Widget? drawer;
  final List<Widget>? actions;
  final bool showAppBar;
  final PreferredSizeWidget? appBar;
  final bool centerTitle;

  const CommonScaffold({
    super.key,
    this.title,
    required this.body,
    this.floatingActionButton,
    this.drawer,
    this.actions,
    this.appBar,
    this.showAppBar = true,
    this.centerTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkCubit, NetworkState>(
      builder: (context, state) {
        if (state is NetworkDisconnected) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: SafeArea(
              child: NoInternetWidget(
                onRetry: () => context.read<NetworkCubit>().checkConnection(),
              ),
            ),
          );
        }

        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            drawer: drawer,
            appBar: showAppBar
                ? Toolbar.simple(
                    context,
                    title: title ?? '',
                    centerTitle: centerTitle,
                    actions: actions,
                  )
                : appBar,
            body: SafeArea(child: body),
            floatingActionButton: floatingActionButton,
          ),
        );
      },
    );
  }
}
