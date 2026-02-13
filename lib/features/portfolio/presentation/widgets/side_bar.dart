import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portfolio/core/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../blocs/portfolio_bloc.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PortfolioBloc, PortfolioState>(
      builder: (context, state) {
        return Drawer(
          backgroundColor:
              state.isDark ? AppTheme.backgroundColor : Colors.white,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 40.h),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: (state.isDark ? Colors.white : Colors.black)
                          .withValues(alpha: 0.05),
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 90.w,
                      height: 90.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppTheme.primaryColor.withValues(alpha: 0.5),
                          width: 2,
                        ),
                        image: const DecorationImage(
                          image: AssetImage("assets/images/profile.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "Justin Mahida",
                      style: GoogleFonts.outfit(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: state.isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              const _SideNavItem(
                  title: "Home", index: 0, icon: Icons.home_rounded),
              const _SideNavItem(
                  title: "Projects", index: 1, icon: Icons.work_rounded),
              const _SideNavItem(
                  title: "Skills", index: 2, icon: Icons.star_rounded),
              const _SideNavItem(
                  title: "Experience", index: 3, icon: Icons.history_rounded),
              const _SideNavItem(
                  title: "Contact", index: 4, icon: Icons.mail_rounded),
              const Spacer(),
            ],
          ),
        );
      },
    );
  }
}

class _SideNavItem extends StatelessWidget {
  final String title;
  final int index;
  final IconData icon;

  const _SideNavItem({
    required this.title,
    required this.index,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);

    return BlocBuilder<PortfolioBloc, PortfolioState>(
      builder: (context, state) {
        final isActive = state.activeIndex == index;

        return ListTile(
          leading: Icon(
            icon,
            color: isActive
                ? AppTheme.primaryColor
                : (state.isDark ? Colors.white70 : Colors.black54),
          ),
          title: Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 16.sp,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
              color: isActive
                  ? AppTheme.primaryColor
                  : (state.isDark ? Colors.white70 : Colors.black87),
            ),
          ),
          selected: isActive,
          onTap: () {
            context.read<PortfolioBloc>().add(ScrollToSectionRequested(index));
            Navigator.pop(context); // Close drawer
          },
        );
      },
    );
  }
}
