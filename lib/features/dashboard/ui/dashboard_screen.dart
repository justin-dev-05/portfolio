import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdi_dost/core/constants/app_colors.dart';
import 'package:pdi_dost/core/constants/app_strings.dart';
import 'package:pdi_dost/core/constants/helper.dart';
import 'package:pdi_dost/core/widgets/app_dialogs.dart';
import '../../profile/ui/profile_screen.dart';
import '../../home/ui/home_screen.dart';
import '../bloc/bottom_nav/bottom_nav_bloc.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBloc, BottomNavState>(
      builder: (context, state) {
        final screens = [
          const HomeScreen(),
          const PlaceholderScreen(title: AppStrings.inquiries),
          const PlaceholderScreen(title: AppStrings.history),
          const ProfileScreen(),
        ];

        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) return;
            if (state.currentIndex != 0) {
              context.read<BottomNavBloc>().add(const TabChangedEvent(0));
            } else {
              AppDialogs.showExitDialog(context, () => exit(0));
            }
          },
          child: Scaffold(
            body: IndexedStack(index: state.currentIndex, children: screens),
            bottomNavigationBar: _buildBottomNav(context, state),
          ),
        );
      },
    );
  }
}

Widget _buildBottomNav(BuildContext context, BottomNavState state) {
  return ClipRRect(
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
    ),
    child: NavigationBar(
      selectedIndex: state.currentIndex,
      onDestinationSelected: (index) {
        context.read<BottomNavBloc>().add(TabChangedEvent(index));
      },
      backgroundColor: Theme.of(context).cardColor,
      indicatorColor: isDarkMode(context)
          ? AppColors.backgroundDark
          : Theme.of(context).primaryColor,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: AppStrings.home,
        ),
        NavigationDestination(
          icon: Icon(Icons.question_answer_outlined),
          selectedIcon: Icon(Icons.question_answer),
          label: AppStrings.inquiries,
        ),
        NavigationDestination(
          icon: Icon(Icons.history_outlined),
          selectedIcon: Icon(Icons.history),
          label: AppStrings.history,
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline_rounded),
          selectedIcon: Icon(Icons.person_rounded),
          label: AppStrings.profile,
        ),
      ],
    ),
  );
}

class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      // body: Center(child: Text('$title Screen Placeholder')),
      body: const Center(child: Text(AppStrings.comingSoon)),
    );
  }
}
