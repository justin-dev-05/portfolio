import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portfolio/core/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/utils/responsive.dart';
import '../blocs/portfolio_bloc.dart';
import 'profile_contact_card.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isMobile = Responsive.isMobile(context);

    return BlocBuilder<PortfolioBloc, PortfolioState>(
      builder: (context, state) {
        final isDark = state.isDark;

        return SafeArea(
          child: Container(
            height: isMobile ? 65.h : 80.h,
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 12.w : 40.w,
              vertical: isMobile ? 6.h : 10.h,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(isMobile ? 16.r : 24.r),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: (isDark
                        ? const Color(0xFF0F172A).withValues(alpha: 0.85)
                        : Colors.white.withValues(alpha: 0.85)),
                    borderRadius: BorderRadius.circular(isMobile ? 16.r : 24.r),
                    border: Border.all(
                      color: (isDark ? Colors.white : Colors.black)
                          .withValues(alpha: 0.08),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryColor
                            .withValues(alpha: isDark ? 0.08 : 0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 12.w : 20.w,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Left: Logo & Name Branding
                      Row(
                        children: [
                          if (!isDesktop)
                            IconButton(
                              icon: FaIcon(FontAwesomeIcons.bars, size: 16.sp),
                              color: isDark ? Colors.white70 : Colors.black87,
                              onPressed: () => Scaffold.of(context).openDrawer(),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          if (!isDesktop) SizedBox(width: 10.w),

                          // Avatar / Monogram Logo Badge
                          GestureDetector(
                            onTap: () => ProfileDialog.show(context),
                            child: Container(
                              width: isMobile ? 32.r : 40.r,
                              height: isMobile ? 32.r : 40.r,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: AppTheme.primaryGradient,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppTheme.primaryColor
                                        .withValues(alpha: 0.3),
                                    blurRadius: 8,
                                  )
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  "JM",
                                  style: GoogleFonts.outfit(
                                    fontSize: isMobile ? 12.sp : 15.sp,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),

                          // Name & Sub-badge
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Justin Mahida",
                                style: GoogleFonts.outfit(
                                  fontSize: isMobile ? 14.sp : 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.white : Colors.black87,
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 6.r,
                                    height: 6.r,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF10B981),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    "Mobile App Developer",
                                    style: GoogleFonts.outfit(
                                      fontSize: isMobile ? 10.sp : 11.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Center: Modern Pill Navigation (Desktop)
                      if (isDesktop)
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: (isDark ? Colors.white : Colors.black)
                                .withValues(alpha: 0.04),
                            borderRadius: BorderRadius.circular(30.r),
                            border: Border.all(
                              color: (isDark ? Colors.white : Colors.black)
                                  .withValues(alpha: 0.05),
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _NavItem(title: "Home", index: 0),
                              _NavItem(title: "Projects", index: 1),
                              _NavItem(title: "Skills", index: 2),
                              _NavItem(title: "Experience", index: 3),
                              _NavItem(title: "Contact", index: 4),
                            ],
                          ),
                        ),

                      // Right: Actions (Theme Toggle & Profile Avatar)
                      Row(
                        children: [
                          _ThemeToggle(),
                          if (!isMobile) ...[
                            SizedBox(width: 10.w),
                            const _ProfileToggle(),
                          ],
                        ],
                      ),
                    ],
                  ),
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
        final isDark = state.isDark;

        return InkWell(
          onTap: () {
            context.read<PortfolioBloc>().add(ScrollToSectionRequested(index));
          },
          borderRadius: BorderRadius.circular(20.r),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: isActive
                  ? AppTheme.primaryColor.withValues(alpha: 0.18)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(20.r),
              border: isActive
                  ? Border.all(
                      color: AppTheme.primaryColor.withValues(alpha: 0.4))
                  : null,
            ),
            child: Text(
              title,
              style: GoogleFonts.outfit(
                fontSize: 13.sp,
                fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                color: isActive
                    ? AppTheme.primaryColor
                    : (isDark ? Colors.white70 : Colors.black87),
              ),
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
        final isDark = state.isDark;
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () =>
                context.read<PortfolioBloc>().add(ToggleThemeRequested()),
            child: Container(
              width: 36.r,
              height: 36.r,
              decoration: BoxDecoration(
                color: (isDark ? Colors.white : Colors.black)
                    .withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: (isDark ? Colors.white : Colors.black)
                      .withValues(alpha: 0.08),
                ),
              ),
              child: Icon(
                isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                size: 16.sp,
                color: isDark ? const Color(0xFFFBBF24) : Colors.black87,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ProfileToggle extends StatelessWidget {
  const _ProfileToggle();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PortfolioBloc, PortfolioState>(
      builder: (context, state) {
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => ProfileDialog.show(context),
            child: Container(
              width: 36.r,
              height: 36.r,
              decoration: BoxDecoration(
                color: (state.isDark ? Colors.white : Colors.black)
                    .withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: AppTheme.primaryColor.withValues(alpha: 0.4),
                  width: 1.2,
                ),
              ),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.asset(
                    "assets/images/profile.png",
                    width: 24.r,
                    height: 24.r,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.person_rounded,
                      size: 18.sp,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
