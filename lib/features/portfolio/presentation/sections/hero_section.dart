import 'dart:math' as math;
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
              // Continuous Animated Background (Floating Objects, Particle Field & Ambient Glow)
              Positioned.fill(
                child: ContinuousHeroBackground(isDark: isDark),
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
              color: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : AppTheme.primaryColor.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(30.r),
              border: Border.all(
                color: (isDark ? AppTheme.primaryColor : const Color(0xFF0284C7))
                    .withValues(alpha: 0.4),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryColor.withValues(alpha: isDark ? 0.15 : 0.08),
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
                    color: isDark ? AppTheme.primaryColor : const Color(0xFF0284C7),
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  "< MOBILE APP DEVELOPER />",
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: isMobile ? 11.sp : 13.sp,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppTheme.primaryColor : const Color(0xFF0284C7),
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
                    color: isDark ? Colors.white70 : const Color(0xFF0F172A),
                  ),
                ),
                SizedBox(width: 8.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: (isDark ? AppTheme.secondaryColor : const Color(0xFF6366F1))
                        .withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    "5+ YEARS EXPERIENCE",
                    style: GoogleFonts.outfit(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppTheme.secondaryColor : const Color(0xFF6366F1),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            ShaderMask(
              shaderCallback: (bounds) => (isDark
                      ? AppTheme.primaryGradient
                      : const LinearGradient(
                          colors: [Color(0xFF0284C7), Color(0xFF4F46E5)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ))
                  .createShader(bounds),
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
            color: isDark ? Colors.white.withValues(alpha: 0.75) : const Color(0xFF334155),
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
        color: isDark ? const Color(0xFF1E293B).withValues(alpha: 0.95) : Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: isDark
              ? AppTheme.primaryColor.withValues(alpha: 0.3)
              : const Color(0xFFCBD5E1),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? AppTheme.primaryColor.withValues(alpha: 0.2)
                : Colors.black.withValues(alpha: 0.06),
            blurRadius: 28,
            offset: const Offset(0, 10),
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
              color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9),
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
                          color: isDark ? Colors.white70 : const Color(0xFF475569),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Icon(FontAwesomeIcons.flutter, size: 14.sp, color: isDark ? AppTheme.primaryColor : const Color(0xFF0284C7)),
                ],
              ),
            ),

            // Code Content Body
            Padding(
              padding: EdgeInsets.all(20.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _CodeLine(line: "class JustinMahida extends Developer {", color: isDark ? Colors.white : const Color(0xFF0F172A)),
                  _CodeLine(line: "  final String role = 'Senior Mobile Architect';", color: isDark ? AppTheme.primaryColor : const Color(0xFF0284C7)),
                  _CodeLine(line: "  final int experienceYears = 5;", color: isDark ? AppTheme.secondaryColor : const Color(0xFF6366F1)),
                  _CodeLine(line: "  final List<String> techStack = [", color: isDark ? Colors.white70 : const Color(0xFF0F172A)),
                  _CodeLine(line: "    'Flutter & Dart', 'Android (Kotlin)',", color: isDark ? const Color(0xFF10B981) : const Color(0xFF059669)),
                  _CodeLine(line: "    'Gemini AI', 'Pine Labs POS', 'BLoC'", color: isDark ? const Color(0xFF10B981) : const Color(0xFF059669)),
                  _CodeLine(line: "  ];", color: isDark ? Colors.white70 : const Color(0xFF0F172A)),
                  SizedBox(height: 10.h),
                  _CodeLine(line: "  Widget buildApp() {", color: isDark ? Colors.white : const Color(0xFF0F172A)),
                  _CodeLine(line: "    return HighPerformanceApp();", color: isDark ? AppTheme.primaryColor : const Color(0xFF0284C7)),
                  _CodeLine(line: "  }", color: isDark ? Colors.white : const Color(0xFF0F172A)),
                  _CodeLine(line: "}", color: isDark ? Colors.white : const Color(0xFF0F172A)),
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
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : const Color(0xFFE2E8F0),
        ),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 13.sp,
            color: isDark ? AppTheme.primaryColor : const Color(0xFF0284C7),
          ),
          SizedBox(width: 6.w),
          Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white70 : const Color(0xFF0F172A),
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

/// Continuous background animation widget with floating tech icons,
/// dynamic particle field, and smooth ambient glowing orbs.
class ContinuousHeroBackground extends StatefulWidget {
  final bool isDark;
  const ContinuousHeroBackground({super.key, required this.isDark});

  @override
  State<ContinuousHeroBackground> createState() => _ContinuousHeroBackgroundState();
}

class _ContinuousHeroBackgroundState extends State<ContinuousHeroBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildFloatingBadge({
    required double leftFraction,
    required double topFraction,
    required IconData icon,
    required String label,
    required Color color,
    required double progress,
    required double phaseOffset,
    required bool isDark,
  }) {
    final yOffset = 18 * math.sin((progress * 2 * math.pi) + phaseOffset);
    final rotation = 0.08 * math.cos((progress * 2 * math.pi) + phaseOffset);

    return Positioned(
      left: ScreenUtil().screenWidth * leftFraction,
      top: 600.h * topFraction + yOffset,
      child: Transform.rotate(
        angle: rotation,
        child: Opacity(
          opacity: isDark ? 0.35 : 0.45,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E293B) : Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: color.withValues(alpha: 0.4),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 14.sp, color: color),
                if (label.isNotEmpty) ...[
                  SizedBox(width: 6.w),
                  Text(
                    label,
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white70 : const Color(0xFF0F172A),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final progress = _controller.value;
        final isDark = widget.isDark;
        final screenWidth = MediaQuery.of(context).size.width;
        final isMobile = screenWidth < 768;

        return Stack(
          children: [
            // Floating Ambient Gradient Glowing Spheres
            Positioned(
              top: -60 + (30 * math.sin(progress * 2 * math.pi)),
              right: -60 + (30 * math.cos(progress * 2 * math.pi)),
              child: Container(
                width: 340.r,
                height: 340.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppTheme.primaryColor.withValues(alpha: isDark ? 0.16 : 0.10),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -80 + (25 * math.cos(progress * 2 * math.pi + 1)),
              left: -80 + (25 * math.sin(progress * 2 * math.pi + 1)),
              child: Container(
                width: 380.r,
                height: 380.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppTheme.secondaryColor.withValues(alpha: isDark ? 0.14 : 0.08),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // Continuous Floating Particle Field Canvas
            CustomPaint(
              size: Size.infinite,
              painter: _ContinuousParticlesPainter(
                progress: progress,
                isDark: isDark,
              ),
            ),

            // Continuous Floating Tech Badges (Only visible when screen is wide enough)
            if (!isMobile) ...[
              _buildFloatingBadge(
                leftFraction: 0.03,
                topFraction: 0.15,
                icon: FontAwesomeIcons.flutter,
                label: "Flutter",
                color: AppTheme.primaryColor,
                progress: progress,
                phaseOffset: 0,
                isDark: isDark,
              ),
              _buildFloatingBadge(
                leftFraction: 0.88,
                topFraction: 0.12,
                icon: FontAwesomeIcons.code,
                label: "</>",
                color: AppTheme.secondaryColor,
                progress: progress,
                phaseOffset: 1.5,
                isDark: isDark,
              ),
              _buildFloatingBadge(
                leftFraction: 0.02,
                topFraction: 0.72,
                icon: FontAwesomeIcons.android,
                label: "Android",
                color: const Color(0xFF10B981),
                progress: progress,
                phaseOffset: 3.0,
                isDark: isDark,
              ),
              _buildFloatingBadge(
                leftFraction: 0.90,
                topFraction: 0.78,
                icon: FontAwesomeIcons.wandMagicSparkles,
                label: "Gemini AI",
                color: const Color(0xFFA855F7),
                progress: progress,
                phaseOffset: 4.2,
                isDark: isDark,
              ),
            ],
          ],
        );
      },
    );
  }
}

/// Custom painter to render moving particles and connecting lines
class _ContinuousParticlesPainter extends CustomPainter {
  final double progress;
  final bool isDark;

  _ContinuousParticlesPainter({
    required this.progress,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final paint = Paint()
      ..color = (isDark ? AppTheme.primaryColor : const Color(0xFF0284C7))
          .withValues(alpha: isDark ? 0.25 : 0.20)
      ..style = PaintingStyle.fill;

    final linePaint = Paint()
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;

    final int particleCount = size.width < 768 ? 12 : 22;
    final List<Offset> points = [];

    for (int i = 0; i < particleCount; i++) {
      final double speed = 0.4 + (i % 5) * 0.12;
      final double initialX = (i * 137.5) % size.width;
      final double initialY = (i * 93.3) % size.height;

      final double dy = (initialY - (progress * size.height * speed)) % size.height;
      final double dx = (initialX + math.sin((progress * 2 * math.pi) + i) * 18) % size.width;

      final point = Offset(dx, dy < 0 ? dy + size.height : dy);
      points.add(point);

      final double radius = 2.0 + (i % 3) * 1.0;
      canvas.drawCircle(point, radius, paint);
    }

    // Connect close points with subtle constellation lines
    for (int i = 0; i < points.length; i++) {
      for (int j = i + 1; j < points.length; j++) {
        final double dist = (points[i] - points[j]).distance;
        if (dist < 110) {
          final double lineAlpha = (1.0 - (dist / 110)) * (isDark ? 0.12 : 0.08);
          linePaint.color = (isDark ? AppTheme.primaryColor : const Color(0xFF0284C7))
              .withValues(alpha: lineAlpha);
          canvas.drawLine(points[i], points[j], linePaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _ContinuousParticlesPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.isDark != isDark;
  }
}
