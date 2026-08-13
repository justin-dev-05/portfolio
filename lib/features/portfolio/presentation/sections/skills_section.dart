import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_portfolio/core/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/portfolio_bloc.dart';
import '../../../../core/utils/responsive.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    final skills = [
      {
        'name': 'Flutter & Dart',
        'category': 'Cross-Platform',
        'icon': Icons.flutter_dash,
        'color': const Color(0xFF02569B)
      },
      {
        'name': 'Native Android (Kotlin/Java)',
        'category': 'Mobile Native',
        'icon': Icons.android,
        'color': const Color(0xFF3DDC84)
      },
      {
        'name': 'BLoC & Provider',
        'category': 'Architecture',
        'icon': Icons.layers_rounded,
        'color': const Color(0xFF9C27B0)
      },
      {
        'name': 'Clean MVVM',
        'category': 'Architecture',
        'icon': Icons.architecture,
        'color': const Color(0xFFE91E63)
      },
      {
        'name': 'Google Gemini AI & OCR',
        'category': 'AI / ML',
        'icon': Icons.psychology_rounded,
        'color': const Color(0xFF673AB7)
      },
      {
        'name': 'Pine Labs POS & Barcode',
        'category': 'Hardware Integration',
        'icon': Icons.point_of_sale_rounded,
        'color': const Color(0xFFFF9800)
      },
      {
        'name': 'Razorpay & Stripe',
        'category': 'Payments',
        'icon': Icons.credit_card_rounded,
        'color': const Color(0xFF00C853)
      },
      {
        'name': 'HLS / DASH Streaming',
        'category': 'Media',
        'icon': Icons.play_circle_fill_rounded,
        'color': const Color(0xFFF44336)
      },
      {
        'name': 'Firebase & WebSockets',
        'category': 'Backend & Real-time',
        'icon': Icons.local_fire_department,
        'color': const Color(0xFFFFCA28)
      },
      {
        'name': 'REST API & Dio',
        'category': 'Networking',
        'icon': Icons.api,
        'color': const Color(0xFF00BCD4)
      },
      {
        'name': 'Google Maps & GPS',
        'category': 'Geospatial',
        'icon': Icons.map_rounded,
        'color': const Color(0xFF4CAF50)
      },
      {
        'name': 'Git & CI/CD',
        'category': 'DevOps',
        'icon': FontAwesomeIcons.github,
        'color': const Color(0xFF212121)
      },
    ];

    return BlocBuilder<PortfolioBloc, PortfolioState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          color: state.isDark
              ? AppTheme.backgroundColor
              : const Color(0xFFF1F5F9),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20.w : 80.w,
              vertical: isMobile ? 40.h : 60.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: AppTheme.primaryColor.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.workspace_premium_rounded,
                        size: 14.sp,
                        color: AppTheme.primaryColor,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        "TECHNICAL STACK & CAPABILITIES",
                        style: GoogleFonts.outfit(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(),
                SizedBox(height: 14.h),

                ShaderMask(
                  shaderCallback: (bounds) =>
                      AppTheme.primaryGradient.createShader(bounds),
                  child: Text(
                    "Skills & Technical Arsenal",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontSize: (isMobile ? 30 : 48).sp,
                      fontWeight: FontWeight.bold,
                      color: state.isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ).animate().fadeIn(delay: 100.ms),
                SizedBox(height: 12.h),

                Text(
                  "Production-grade mobile architecture, cross-platform engineering, and hardware integrations.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    fontSize: isMobile ? 14.sp : 16.sp,
                    color: state.isDark ? Colors.white70 : Colors.black54,
                  ),
                ).animate().fadeIn(delay: 150.ms),
                SizedBox(height: 36.h),

                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isMobile ? 2 : (Responsive.isTablet(context) ? 3 : 4),
                    crossAxisSpacing: isMobile ? 12 : 20,
                    mainAxisSpacing: isMobile ? 12 : 20,
                    mainAxisExtent: isMobile ? 130.h : 150.h,
                  ),
                  itemCount: skills.length,
                  itemBuilder: (context, index) {
                    final skill = skills[index];
                    return HoverSkillCard(
                      name: skill['name'] as String,
                      category: skill['category'] as String,
                      icon: skill['icon'] as IconData,
                      color: skill['color'] as Color,
                    )
                        .animate()
                        .fadeIn(delay: (40 * index).ms)
                        .scale(duration: 350.ms, curve: Curves.easeOutCubic);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class HoverSkillCard extends StatefulWidget {
  final String name;
  final String category;
  final IconData icon;
  final Color color;

  const HoverSkillCard({
    super.key,
    required this.name,
    required this.category,
    required this.icon,
    required this.color,
  });

  @override
  State<HoverSkillCard> createState() => _HoverSkillCardState();
}

class _HoverSkillCardState extends State<HoverSkillCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PortfolioBloc, PortfolioState>(
      builder: (context, state) {
        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: EdgeInsets.all(14.r),
            decoration: BoxDecoration(
              color: isHovered
                  ? widget.color.withValues(alpha: 0.12)
                  : (state.isDark
                      ? const Color(0xFF1E293B)
                      : Colors.white),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: isHovered
                    ? widget.color
                    : (state.isDark
                        ? Colors.white.withValues(alpha: 0.08)
                        : Colors.black.withValues(alpha: 0.06)),
                width: isHovered ? 1.8 : 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: isHovered
                      ? widget.color.withValues(alpha: 0.2)
                      : Colors.black.withValues(alpha: state.isDark ? 0.2 : 0.03),
                  blurRadius: isHovered ? 20 : 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    color: widget.color.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    widget.icon,
                    size: 26.sp,
                    color: widget.color,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  widget.name,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: state.isDark ? Colors.white : Colors.black87,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  widget.category,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: state.isDark ? Colors.white60 : Colors.black54,
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
