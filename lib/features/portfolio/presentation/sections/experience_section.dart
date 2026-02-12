import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_portfolio/core/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../blocs/portfolio_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/responsive.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    final experiences = [
      {
        'company': 'Query Finders Solution',
        'role': 'Sr. Android & Flutter Developer',
        'period': 'Dec 2021 - Present',
        'description':
            'Leading mobile development projects, architecting robust Flutter applications, and delivering high-performance Android solutions.',
        'isCurrent': true,
        'logo': 'assets/images/qf_logo.png',
      },
      {
        'company': 'Way to Web',
        'role': 'PHP Web Developer (Internship)',
        'period': '1 Year & 1 Month',
        'description':
            'Gained hands-on experience in web development, focusing on PHP and backend logic during an intensive internship program.',
        'isCurrent': false,
        'logo': 'assets/images/waytoweb_logo.png',
      },
    ];

    return BlocBuilder<PortfolioBloc, PortfolioState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          color:
              state.isDark ? AppTheme.backgroundColor : const Color(0xFFF8FAFC),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 24.w : 100,
              vertical: isMobile ? 80.h : 120,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) =>
                      AppTheme.primaryGradient.createShader(bounds),
                  child: Text(
                    "EXPERIENCE",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontSize: (isMobile ? 32 : 54).sp,
                      fontWeight: FontWeight.bold,
                      color: state.isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ).animate().fadeIn(),
                SizedBox(height: 16.h),
                Container(
                  width: 80,
                  height: 4,
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ).animate().fadeIn(delay: 200.ms).scaleX(),
                SizedBox(height: 48.h),
                Center(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isMobile ? 1 : 2,
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 24,
                      mainAxisExtent: isMobile ? 240.h : 160.h,
                    ),
                    itemCount: experiences.length,
                    itemBuilder: (context, index) {
                      final exp = experiences[index];
                      return ExperienceCard(
                        company: exp['company'] as String,
                        role: exp['role'] as String,
                        period: exp['period'] as String,
                        description: exp['description'] as String,
                        isCurrent: exp['isCurrent'] as bool,
                        logo: exp['logo'] as String,
                      )
                          .animate()
                          .fadeIn(delay: (200 * index).ms)
                          .slideX(begin: 0.1);
                    },
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

class ExperienceCard extends StatefulWidget {
  final String company;
  final String role;
  final String period;
  final String description;
  final bool isCurrent;
  final String logo;

  const ExperienceCard({
    super.key,
    required this.company,
    required this.role,
    required this.period,
    required this.description,
    required this.isCurrent,
    required this.logo,
  });

  @override
  State<ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<ExperienceCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PortfolioBloc, PortfolioState>(
      builder: (context, state) {
        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: EdgeInsets.all(14.r),
            decoration: BoxDecoration(
              color: isHovered
                  ? (state.isDark
                      ? AppTheme.surfaceColor.withValues(alpha: 0.8)
                      : Colors.white)
                  : (state.isDark
                      ? AppTheme.surfaceColor.withValues(alpha: 0.4)
                      : Colors.white),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isHovered
                    ? AppTheme.primaryColor
                    : (state.isDark ? Colors.white12 : Colors.black12),
                width: 2,
              ),
              boxShadow: [
                if (isHovered)
                  BoxShadow(
                    color: AppTheme.primaryColor.withValues(alpha: 0.1),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  )
                else
                  BoxShadow(
                    color: Colors.black
                        .withValues(alpha: state.isDark ? 0.2 : 0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 5),
                  )
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      widget.logo,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(width: 20.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.company,
                              style: GoogleFonts.outfit(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: state.isDark
                                    ? Colors.white
                                    : Colors.black87,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: widget.isCurrent
                                  ? AppTheme.primaryColor.withValues(alpha: 0.1)
                                  : Colors.grey.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              widget.period,
                              style: GoogleFonts.outfit(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                                color: widget.isCurrent
                                    ? AppTheme.primaryColor
                                    : (state.isDark
                                        ? Colors.white70
                                        : Colors.black54),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.role,
                        style: GoogleFonts.outfit(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.secondaryColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        widget.description,
                        style: GoogleFonts.outfit(
                          fontSize: 14.sp,
                          color: state.isDark ? Colors.white70 : Colors.black54,
                          height: 1.5,
                        ),
                      ),
                    ],
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
