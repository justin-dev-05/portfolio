import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portfolio/core/theme/app_theme.dart';
import 'package:flutter_portfolio/core/utils/resume_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../blocs/portfolio_bloc.dart';
import 'profile_contact_card.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PortfolioBloc, PortfolioState>(
      builder: (context, state) {
        final isDark = state.isDark;

        return Drawer(
          width: 290.w,
          backgroundColor: isDark ? const Color(0xFF0F172A) : Colors.white,
          child: Column(
            children: [
              // Header Section with Gradient Banner & Profile Avatar
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(20.w, 40.h, 20.w, 24.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isDark
                        ? [const Color(0xFF1E293B), const Color(0xFF0F172A)]
                        : [AppTheme.primaryColor.withValues(alpha: 0.08), Colors.white],
                  ),
                  border: Border(
                    bottom: BorderSide(
                      color: (isDark ? Colors.white : Colors.black)
                          .withValues(alpha: 0.06),
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    // Top Bar: Close Button & Availability
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 6.r,
                                height: 6.r,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF10B981),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                "AVAILABLE",
                                style: GoogleFonts.outfit(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            Icons.close_rounded,
                            size: 20.sp,
                            color: isDark ? Colors.white70 : Colors.black54,
                          ),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    // Avatar & Name Card
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        ProfileDialog.show(context);
                      },
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: 75.r,
                                height: 75.r,
                                padding: const EdgeInsets.all(2.5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: AppTheme.primaryGradient,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppTheme.primaryColor
                                          .withValues(alpha: 0.3),
                                      blurRadius: 16,
                                    )
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40.r),
                                  child: Image.asset(
                                    "assets/images/profile.png",
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) =>
                                        Icon(Icons.person,
                                            size: 40.sp, color: Colors.white),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 2,
                                right: 2,
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? const Color(0xFF0F172A)
                                        : Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Container(
                                    width: 12.r,
                                    height: 12.r,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF10B981),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            "Justin Mahida",
                            style: GoogleFonts.outfit(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            "Mobile App Developer",
                            style: GoogleFonts.outfit(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Navigation Links List
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  child: Column(
                    children: [
                      const _SideNavItem(
                          title: "Home", index: 0, icon: Icons.grid_view_rounded),
                      SizedBox(height: 8.h),
                      const _SideNavItem(
                          title: "Projects", index: 1, icon: Icons.folder_special_rounded),
                      SizedBox(height: 8.h),
                      const _SideNavItem(
                          title: "Skills", index: 2, icon: Icons.psychology_rounded),
                      SizedBox(height: 8.h),
                      const _SideNavItem(
                          title: "Experience", index: 3, icon: Icons.work_history_rounded),
                      SizedBox(height: 8.h),
                      const _SideNavItem(
                          title: "Contact", index: 4, icon: Icons.connect_without_contact_rounded),
                    ],
                  ),
                ),
              ),

              // Bottom Section: CV Download & Social Links
              Container(
                padding: EdgeInsets.all(20.r),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: (isDark ? Colors.white : Colors.black)
                          .withValues(alpha: 0.06),
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    // Download CV Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          ResumeHelper.downloadResume();
                        },
                        icon: Icon(Icons.download_rounded, size: 16.sp),
                        label: Text(
                          "Download Resume",
                          style: GoogleFonts.outfit(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryColor,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          elevation: 0,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Quick Social Links Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _SocialIconButton(
                          icon: FontAwesomeIcons.github,
                          onTap: () => launchUrl(
                              Uri.parse("https://github.com/justin-dev-05")),
                          isDark: isDark,
                        ),
                        SizedBox(width: 12.w),
                        _SocialIconButton(
                          icon: FontAwesomeIcons.linkedinIn,
                          onTap: () => launchUrl(
                              Uri.parse("https://linkedin.com/in/justin-mahida")),
                          isDark: isDark,
                        ),
                        SizedBox(width: 12.w),
                        _SocialIconButton(
                          icon: FontAwesomeIcons.whatsapp,
                          onTap: () => launchUrl(
                              Uri.parse("https://wa.me/917359792115")),
                          isDark: isDark,
                        ),
                        SizedBox(width: 12.w),
                        _SocialIconButton(
                          icon: FontAwesomeIcons.envelope,
                          onTap: () => launchUrl(
                              Uri.parse("mailto:justinlikemja@gmail.com")),
                          isDark: isDark,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
    return BlocBuilder<PortfolioBloc, PortfolioState>(
      builder: (context, state) {
        final isActive = state.activeIndex == index;
        final isDark = state.isDark;

        return InkWell(
          onTap: () {
            context.read<PortfolioBloc>().add(ScrollToSectionRequested(index));
            Navigator.pop(context);
          },
          borderRadius: BorderRadius.circular(14.r),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: isActive
                  ? AppTheme.primaryColor.withValues(alpha: 0.15)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(14.r),
              border: isActive
                  ? Border.all(
                      color: AppTheme.primaryColor.withValues(alpha: 0.3),
                      width: 1,
                    )
                  : null,
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: isActive
                        ? AppTheme.primaryColor
                        : (isDark ? Colors.white : Colors.black)
                            .withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    icon,
                    size: 16.sp,
                    color: isActive
                        ? Colors.white
                        : (isDark ? Colors.white70 : Colors.black54),
                  ),
                ),
                SizedBox(width: 14.w),
                Text(
                  title,
                  style: GoogleFonts.outfit(
                    fontSize: 14.sp,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                    color: isActive
                        ? AppTheme.primaryColor
                        : (isDark ? Colors.white : Colors.black87),
                  ),
                ),
                const Spacer(),
                if (isActive)
                  Container(
                    width: 6.r,
                    height: 6.r,
                    decoration: const BoxDecoration(
                      color: AppTheme.primaryColor,
                      shape: BoxShape.circle,
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

class _SocialIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isDark;

  const _SocialIconButton({
    required this.icon,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.08),
          ),
        ),
        child: Icon(
          icon,
          size: 14.sp,
          color: isDark ? Colors.white70 : Colors.black87,
        ),
      ),
    );
  }
}
