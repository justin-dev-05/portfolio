import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portfolio/core/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_portfolio/core/constants/portfolio_data.dart';
import 'package:flutter_portfolio/core/utils/constants.dart';
import 'package:flutter_portfolio/core/utils/resume_helper.dart';
import '../../../../core/utils/responsive.dart';
import '../blocs/portfolio_bloc.dart';

class ProfileDialog extends StatelessWidget {
  const ProfileDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.65),
      builder: (context) => const ProfileDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return BlocBuilder<PortfolioBloc, PortfolioState>(
      builder: (context, state) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          insetPadding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16.w : 24.w,
            vertical: 24.h,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isMobile ? 380.w : 520.w,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28.r),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: state.isDark
                        ? const Color(0xFF0F172A).withValues(alpha: 0.95)
                        : Colors.white.withValues(alpha: 0.95),
                    borderRadius: BorderRadius.circular(28.r),
                    border: Border.all(
                      color: state.isDark
                          ? Colors.white.withValues(alpha: 0.12)
                          : AppTheme.primaryColor.withValues(alpha: 0.2),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryColor.withValues(alpha: 0.2),
                        blurRadius: 36,
                        offset: const Offset(0, 16),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Top Decorative Banner with Close Button
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: 110.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                gradient: AppTheme.primaryGradient,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(28.r),
                                  topRight: Radius.circular(28.r),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    right: -20,
                                    top: -20,
                                    child: Container(
                                      width: 120.r,
                                      height: 120.r,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white.withValues(alpha: 0.12),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: -30,
                                    bottom: -30,
                                    child: Container(
                                      width: 100.r,
                                      height: 100.r,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white.withValues(alpha: 0.08),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Close Button (X)
                            Positioned(
                              top: 14.h,
                              right: 14.w,
                              child: Material(
                                color: Colors.black.withValues(alpha: 0.25),
                                borderRadius: BorderRadius.circular(20.r),
                                child: InkWell(
                                  onTap: () => Navigator.of(context).pop(),
                                  borderRadius: BorderRadius.circular(20.r),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.r),
                                    child: Icon(
                                      Icons.close_rounded,
                                      size: 18.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // Profile Avatar (Positioned Overlapping Header)
                            Positioned(
                              bottom: -40.h,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: Container(
                                  width: 88.r,
                                  height: 88.r,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: state.isDark
                                          ? const Color(0xFF0F172A)
                                          : Colors.white,
                                      width: 4,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppTheme.primaryColor.withValues(alpha: 0.35),
                                        blurRadius: 18,
                                        offset: const Offset(0, 6),
                                      ),
                                    ],
                                    image: const DecorationImage(
                                      image: AssetImage("assets/images/profile.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 48.h),

                        // Profile Details Header
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Column(
                            children: [
                              Text(
                                PortfolioData.name,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.outfit(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold,
                                  color: state.isDark
                                      ? Colors.white
                                      : Colors.black87,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                PortfolioConstants.designation,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.outfit(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                              SizedBox(height: 12.h),

                              // Available Tag Badge
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 5.h),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF10B981).withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(20.r),
                                  border: Border.all(
                                    color: const Color(0xFF10B981).withValues(alpha: 0.3),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 8.r,
                                      height: 8.r,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFF10B981),
                                      ),
                                    ),
                                    SizedBox(width: 6.w),
                                    Text(
                                      "Available for Mobile & Web Projects",
                                      style: GoogleFonts.outfit(
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF10B981),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 20.h),
                        Divider(
                          indent: 24.w,
                          endIndent: 24.w,
                          color: (state.isDark ? Colors.white : Colors.black)
                              .withValues(alpha: 0.08),
                        ),
                        SizedBox(height: 16.h),

                        // Contact Details Cards
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Column(
                            children: [
                              _ContactTile(
                                icon: Icons.email_outlined,
                                label: "EMAIL ADDRESS",
                                value: PortfolioData.email,
                                isDark: state.isDark,
                                isCopyable: true,
                              ),
                              SizedBox(height: 12.h),
                              _ContactTile(
                                icon: Icons.location_on_outlined,
                                label: "LOCATION",
                                value: PortfolioData.location,
                                isDark: state.isDark,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 20.h),

                        // Social Channels Row
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _SocialIconButton(
                                icon: FontAwesomeIcons.linkedinIn,
                                url: PortfolioData.socialLinks['linkedin']!,
                                isDark: state.isDark,
                                tooltip: 'LinkedIn',
                              ),
                              _SocialIconButton(
                                icon: FontAwesomeIcons.github,
                                url: PortfolioData.socialLinks['github']!,
                                isDark: state.isDark,
                                tooltip: 'GitHub',
                              ),
                              _SocialIconButton(
                                icon: FontAwesomeIcons.instagram,
                                url: PortfolioData.socialLinks['instagram']!,
                                isDark: state.isDark,
                                tooltip: 'Instagram',
                              ),
                              _SocialIconButton(
                                icon: Icons.mail_outline_rounded,
                                url: "mailto:${PortfolioData.email}",
                                isDark: state.isDark,
                                tooltip: 'Email',
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 24.h),

                        // Action Buttons Footer
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () => ResumeHelper.downloadResume(),
                                  borderRadius: BorderRadius.circular(16.r),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 13.h),
                                    decoration: BoxDecoration(
                                      gradient: AppTheme.primaryGradient,
                                      borderRadius: BorderRadius.circular(16.r),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppTheme.primaryColor
                                              .withValues(alpha: 0.3),
                                          blurRadius: 12,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.file_download_outlined,
                                          size: 18.sp,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 8.w),
                                        Text(
                                          "Download Resume",
                                          style: GoogleFonts.outfit(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ).animate().scale(
              duration: 300.ms,
              curve: Curves.easeOutBack,
              begin: const Offset(0.9, 0.9),
              end: const Offset(1.0, 1.0),
            ).fadeIn(duration: 250.ms);
      },
    );
  }
}

class ProfileContactCard extends StatelessWidget {
  const ProfileContactCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class _ContactTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isDark;
  final bool isCopyable;

  const _ContactTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.isDark,
    this.isCopyable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.06),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              icon,
              color: AppTheme.primaryColor,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.outfit(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                    color: (isDark ? Colors.white : Colors.black)
                        .withValues(alpha: 0.5),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  value,
                  style: GoogleFonts.outfit(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          if (isCopyable)
            IconButton(
              icon: Icon(
                Icons.copy_rounded,
                size: 16.sp,
                color: (isDark ? Colors.white70 : Colors.black54),
              ),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: value));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Copied to clipboard!",
                      style: GoogleFonts.outfit(fontSize: 12.sp),
                    ),
                    duration: const Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                    width: 200,
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

class _SocialIconButton extends StatelessWidget {
  final IconData icon;
  final String url;
  final bool isDark;
  final String tooltip;

  const _SocialIconButton({
    required this.icon,
    required this.url,
    required this.isDark,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: Tooltip(
        message: tooltip,
        child: InkWell(
          onTap: () async {
            final uri = Uri.parse(url);
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri);
            }
          },
          borderRadius: BorderRadius.circular(14.r),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: (isDark ? Colors.white : Colors.black)
                  .withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(
                color: (isDark ? Colors.white : Colors.black)
                    .withValues(alpha: 0.08),
              ),
            ),
            child: Icon(
              icon,
              size: 18.sp,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
