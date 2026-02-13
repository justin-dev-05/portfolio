import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portfolio/core/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_portfolio/core/constants/portfolio_data.dart';
import '../blocs/portfolio_bloc.dart';

class ProfileContactCard extends StatelessWidget {
  const ProfileContactCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PortfolioBloc, PortfolioState>(
      builder: (context, state) {
        if (!state.showProfileCard) return const SizedBox.shrink();

        return TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, -20 * (1 - value)),
              child: Opacity(
                opacity: value,
                child: child,
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24.r),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(32.w),
                  decoration: BoxDecoration(
                    color: (state.isDark
                        ? const Color(0xFF1E293B).withValues(alpha: 0.9)
                        : Colors.white.withValues(alpha: 0.9)),
                    borderRadius: BorderRadius.circular(24.r),
                    border: Border.all(
                      color: (state.isDark ? Colors.white : Colors.black)
                          .withValues(alpha: 0.1),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Profile Image
                          Container(
                            width: 100.w,
                            height: 100.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(
                                color: AppTheme.primaryColor
                                    .withValues(alpha: 0.5),
                                width: 2,
                              ),
                              image: const DecorationImage(
                                image: AssetImage("assets/images/profile.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 24.w),

                          // Name and Resume
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  PortfolioData.name,
                                  style: GoogleFonts.outfit(
                                    fontSize: 32.sp,
                                    fontWeight: FontWeight.bold,
                                    color: state.isDark
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                _ResumeButton(isDark: state.isDark),
                              ],
                            ),
                          ),

                          // Hide Button
                          _HideButton(isDark: state.isDark),
                        ],
                      ),

                      SizedBox(height: 32.h),
                      const Divider(),
                      SizedBox(height: 32.h),

                      // Contact Info
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _ContactInfoItem(
                              icon: Icons.email_outlined,
                              label: "EMAIL",
                              value: PortfolioData.email,
                              isDark: state.isDark,
                            ),
                          ),
                          Expanded(
                            child: _ContactInfoItem(
                              icon: Icons.location_on_outlined,
                              label: "LOCATION",
                              value: PortfolioData.location,
                              isDark: state.isDark,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 32.h),
                      const Divider(),
                      SizedBox(height: 24.h),

                      // Social Links
                      Row(
                        children: [
                          _SocialIcon(
                              icon: FontAwesomeIcons.linkedinIn,
                              url: PortfolioData.socialLinks['linkedin']!),
                          _SocialIcon(
                              icon: FontAwesomeIcons.instagram,
                              url: PortfolioData.socialLinks['instagram']!),
                          _SocialIcon(
                              icon: Icons.mail_outline,
                              url: "mailto:${PortfolioData.email}"),
                          _SocialIcon(
                              icon: FontAwesomeIcons.github,
                              url: PortfolioData.socialLinks['github']!),
                        ],
                      )
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
}

class _ResumeButton extends StatelessWidget {
  final bool isDark;
  const _ResumeButton({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.primaryColor.withValues(alpha: 0.3)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.description_outlined,
                    size: 18, color: AppTheme.primaryColor),
                SizedBox(width: 8),
                Text(
                  "Resume",
                  style: GoogleFonts.outfit(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HideButton extends StatelessWidget {
  final bool isDark;
  const _HideButton({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => context.read<PortfolioBloc>().add(ToggleProfileCard()),
      style: OutlinedButton.styleFrom(
        foregroundColor: isDark ? Colors.white : Colors.black87,
        side: BorderSide(
            color:
                (isDark ? Colors.white : Colors.black).withValues(alpha: 0.2)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      ),
      child: Text(
        "Hide Contacts",
        style: GoogleFonts.outfit(fontWeight: FontWeight.w500),
      ),
    );
  }
}

class _ContactInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isDark;

  const _ContactInfoItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color:
                (isDark ? Colors.white : Colors.black).withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(icon, color: AppTheme.primaryColor, size: 24.sp),
        ),
        SizedBox(width: 16.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                color: (isDark ? Colors.white : Colors.black)
                    .withValues(alpha: 0.5),
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              value,
              style: GoogleFonts.outfit(
                fontSize: 14.sp,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final String url;

  const _SocialIcon({required this.icon, required this.url});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 12.w),
      child: InkWell(
        onTap: () async {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
          ),
          child: Icon(icon, size: 20.sp, color: Colors.white70),
        ),
      ),
    );
  }
}
