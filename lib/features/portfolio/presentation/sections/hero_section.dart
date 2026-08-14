import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portfolio/core/theme/app_theme.dart';
import 'package:flutter_portfolio/features/portfolio/presentation/blocs/portfolio_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/utils/resume_helper.dart';
import '../widgets/modern_cta.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isDesktop = Responsive.isDesktop(context);

    return BlocBuilder<PortfolioBloc, PortfolioState>(
      builder: (context, state) {
        final isDark = state.isDark;

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
            gradient: RadialGradient(
              center: const Alignment(0, -0.6),
              radius: 1.4,
              colors: [
                isDark
                    ? AppTheme.primaryColor.withValues(alpha: 0.15)
                    : AppTheme.primaryColor.withValues(alpha: 0.08),
                isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
              ],
            ),
          ),
          child: Stack(
            children: [
              // Ambient Decorative Glow Bubbles
              Positioned(
                top: -80,
                right: -80,
                child: Container(
                  width: 320.r,
                  height: 320.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.primaryColor.withValues(alpha: isDark ? 0.08 : 0.05),
                  ),
                ),
              ),
              Positioned(
                bottom: -100,
                left: -100,
                child: Container(
                  width: 380.r,
                  height: 380.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.secondaryColor.withValues(alpha: isDark ? 0.08 : 0.04),
                  ),
                ),
              ),

              // Main Section Content Container
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 20.w : 60.w,
                  vertical: isMobile ? 60.h : 90.h,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: isDesktop
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Left Column: Developer Info & Title
                              Expanded(
                                flex: 6,
                                child: _buildTextContent(context, isMobile: false, isDark: isDark),
                              ),
                              SizedBox(width: 50.w),
                              // Right Column: IDE Code Window
                              Expanded(
                                flex: 5,
                                child: _buildDeveloperCodeCard(context, isDark: isDark),
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _buildTextContent(context, isMobile: true, isDark: isDark),
                              SizedBox(height: 40.h),
                              _buildDeveloperCodeCard(context, isDark: isDark),
                            ],
                          ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextContent(BuildContext context, {required bool isMobile, required bool isDark}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Developer Badge Header with Glowing Flutter Icon
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(30.r),
              border: Border.all(
                color: AppTheme.primaryColor.withValues(alpha: 0.4),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryColor.withValues(alpha: 0.15),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Glowing Flutter Icon
                Container(
                  padding: EdgeInsets.all(5.r),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withValues(alpha: 0.18),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    FontAwesomeIcons.flutter,
                    size: 16.sp,
                    color: AppTheme.primaryColor,
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  "< MOBILE APP DEVELOPER />",
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: isMobile ? 11.sp : 13.sp,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(width: 10.w),
                Container(
                  width: 8.r,
                  height: 8.r,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF10B981),
                  ),
                ),
              ],
            ),
          ),
        ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.2),

        SizedBox(height: 24.h),

        // Main Title with Name & Flutter Accent
        Column(
          crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Justin Mahida",
                  style: GoogleFonts.outfit(
                    fontSize: isMobile ? 26.sp : 36.sp,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white70 : Colors.black87,
                  ),
                ),
                SizedBox(width: 8.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: AppTheme.secondaryColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    "5+ YEARS EXPERIENCE",
                    style: GoogleFonts.outfit(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.secondaryColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            ShaderMask(
              shaderCallback: (bounds) => AppTheme.primaryGradient.createShader(bounds),
              child: Text(
                "Flutter & Android Developer",
                textAlign: isMobile ? TextAlign.center : TextAlign.left,
                style: GoogleFonts.outfit(
                  fontSize: isMobile ? 32.sp : 54.sp,
                  fontWeight: FontWeight.w900,
                  height: 1.1,
                  color: Colors.white,
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ],
        ).animate().fadeIn(delay: 150.ms).slideY(begin: 0.1),

        SizedBox(height: 20.h),

        // Subtitle / Description
        Text(
          "Building high-performance cross-platform mobile apps, native Android solutions, Gemini AI integrations, and hardware-level POS systems.",
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: GoogleFonts.outfit(
            fontSize: isMobile ? 14.sp : 17.sp,
            height: 1.6,
            color: isDark ? Colors.white.withValues(alpha: 0.75) : Colors.black87.withValues(alpha: 0.75),
          ),
        ).animate().fadeIn(delay: 300.ms),

        SizedBox(height: 24.h),

        // Developer Tech Stack Pills
        Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            _TechChip(icon: FontAwesomeIcons.flutter, label: "Flutter & Dart", isDark: isDark),
            _TechChip(icon: FontAwesomeIcons.android, label: "Android & Kotlin", isDark: isDark),
            _TechChip(icon: FontAwesomeIcons.wandMagicSparkles, label: "Gemini AI & OCR", isDark: isDark),
            _TechChip(icon: FontAwesomeIcons.cubes, label: "BLoC & Clean Architecture", isDark: isDark),
          ],
        ).animate().fadeIn(delay: 450.ms),

        SizedBox(height: 36.h),

        // Action Buttons Row
        Wrap(
          spacing: 16.w,
          runSpacing: 16.h,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            ModernCTA(
              label: "Explore Work",
              onTap: () {
                context.read<PortfolioBloc>().add(ScrollToSectionRequested(1));
              },
              isPrimary: true,
            ),
            ModernCTA(
              label: "Download CV",
              onTap: () => ResumeHelper.downloadResume(),
              isPrimary: false,
            ),
            ModernCTA(
              label: "Contact Me",
              onTap: () {
                context.read<PortfolioBloc>().add(ScrollToSectionRequested(4));
              },
              isPrimary: false,
            ),
          ],
        ).animate().fadeIn(delay: 600.ms).scale(curve: Curves.easeOutBack),
      ],
    );
  }

  Widget _buildDeveloperCodeCard(BuildContext context, {required bool isDark}) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B).withValues(alpha: 0.95) : Colors.white.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: isDark
              ? AppTheme.primaryColor.withValues(alpha: 0.3)
              : AppTheme.primaryColor.withValues(alpha: 0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withValues(alpha: 0.2),
            blurRadius: 36,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // MacOS Window Header
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              color: isDark ? const Color(0xFF0F172A) : const Color(0xFFE2E8F0),
              child: Row(
                children: [
                  Container(width: 12.r, height: 12.r, decoration: const BoxDecoration(color: Color(0xFFFF5F56), shape: BoxShape.circle)),
                  SizedBox(width: 8.w),
                  Container(width: 12.r, height: 12.r, decoration: const BoxDecoration(color: Color(0xFFFFBD2E), shape: BoxShape.circle)),
                  SizedBox(width: 8.w),
                  Container(width: 12.r, height: 12.r, decoration: const BoxDecoration(color: Color(0xFF27C93F), shape: BoxShape.circle)),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Center(
                      child: Text(
                        "justin_mahida.dart",
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 12.sp,
                          color: isDark ? Colors.white70 : Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Icon(FontAwesomeIcons.flutter, size: 14.sp, color: AppTheme.primaryColor),
                ],
              ),
            ),

            // Code Content Body
            Padding(
              padding: EdgeInsets.all(20.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _CodeLine(line: "class JustinMahida extends Developer {", color: isDark ? Colors.white : Colors.black87),
                  _CodeLine(line: "  final String role = 'Senior Mobile Architect';", color: AppTheme.primaryColor),
                  _CodeLine(line: "  final int experienceYears = 5;", color: AppTheme.secondaryColor),
                  _CodeLine(line: "  final List<String> techStack = [", color: isDark ? Colors.white70 : Colors.black87),
                  _CodeLine(line: "    'Flutter & Dart', 'Android (Kotlin)',", color: const Color(0xFF10B981)),
                  _CodeLine(line: "    'Gemini AI', 'Pine Labs POS', 'BLoC'", color: const Color(0xFF10B981)),
                  _CodeLine(line: "  ];", color: isDark ? Colors.white70 : Colors.black87),
                  SizedBox(height: 10.h),
                  _CodeLine(line: "  Widget buildApp() {", color: isDark ? Colors.white : Colors.black87),
                  _CodeLine(line: "    return HighPerformanceApp();", color: AppTheme.primaryColor),
                  _CodeLine(line: "  }", color: isDark ? Colors.white : Colors.black87),
                  _CodeLine(line: "}", color: isDark ? Colors.white : Colors.black87),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 350.ms).scale(curve: Curves.easeOutCubic);
  }
}

class _TechChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isDark;

  const _TechChip({required this.icon, required this.label, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13.sp, color: AppTheme.primaryColor),
          SizedBox(width: 6.w),
          Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class _CodeLine extends StatelessWidget {
  final String line;
  final Color color;

  const _CodeLine({required this.line, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h),
      child: Text(
        line,
        style: GoogleFonts.jetBrainsMono(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: color,
          height: 1.4,
        ),
      ),
    );
  }
}
