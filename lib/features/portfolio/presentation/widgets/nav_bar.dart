import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portfolio/core/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/utils/responsive.dart';
import '../blocs/portfolio_bloc.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return BlocBuilder<PortfolioBloc, PortfolioState>(
      builder: (context, state) {
        return SafeArea(
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                height: isMobile ? 60.h : 80.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: (state.isDark
                      ? const Color(0xFF0F172A).withValues(alpha: 0.8)
                      : Colors.white.withValues(alpha: 0.7)),
                  border: Border(
                    bottom: BorderSide(
                      color: (state.isDark ? Colors.white : Colors.black)
                          .withValues(alpha: 0.05),
                    ),
                  ),
                  boxShadow: [
                    if (!state.isDark)
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 15.w : 40),
                child: Row(
                  children: [
                    // Profile Circle & Name
                    Row(
                      children: [
                        Container(
                          width: 40.w,
                          height: 40.w,
                          decoration: const BoxDecoration(
                            gradient: AppTheme.primaryGradient,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              "JM",
                              style: GoogleFonts.outfit(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        ShaderMask(
                          shaderCallback: (bounds) =>
                              AppTheme.primaryGradient.createShader(bounds),
                          child: Text(
                            "Justin Mahida",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.outfit(
                              fontSize: (isMobile ? 21 : 21).sp,
                              fontWeight: FontWeight.bold,
                              height: 1.1,
                              letterSpacing: 1.0,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    if (!isMobile)
                      Row(
                        children: [
                          const _NavItem(title: "Home", index: 0),
                          const _NavItem(title: "Projects", index: 1),
                          const _NavItem(title: "Skills", index: 2),
                          const _NavItem(title: "Experience", index: 3),
                          const _NavItem(title: "Contact", index: 4),
                          SizedBox(width: 24.w),
                          _ThemeToggle(),
                        ],
                      )
                    else
                      Row(
                        children: [
                          _ThemeToggle(),
                          SizedBox(width: 10.w),
                          IconButton(
                            icon: FaIcon(FontAwesomeIcons.bars, size: 20.sp),
                            color:
                                state.isDark ? Colors.white70 : Colors.black54,
                            onPressed: () => Scaffold.of(context).openDrawer(),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80.h);
}

class _NavItem extends StatelessWidget {
  final String title;
  final int index;

  const _NavItem({required this.title, required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PortfolioBloc, PortfolioState>(
      builder: (context, state) {
        final isActive = state.activeIndex == index;

        return InkWell(
          onTap: () {
            context.read<PortfolioBloc>().add(ScrollToSectionRequested(index));
          },
          onHover: (hovering) {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                    color: isActive
                        ? AppTheme.primaryColor
                        : (state.isDark ? Colors.white70 : Colors.black54),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 2,
                  width: isActive ? 20 : 0,
                  margin: const EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ThemeToggle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PortfolioBloc, PortfolioState>(
      builder: (context, state) {
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () =>
                context.read<PortfolioBloc>().add(ToggleThemeRequested()),
            child: Container(
              width: 42.w,
              height: 42.w,
              decoration: BoxDecoration(
                color: (state.isDark ? Colors.white : Colors.black)
                    .withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                state.isDark
                    ? Icons.light_mode_rounded
                    : Icons.dark_mode_rounded,
                size: 20.sp,
                color: state.isDark ? Colors.white : Colors.black87,
              ),
            ),
          ),
        );
      },
    );
  }
}
