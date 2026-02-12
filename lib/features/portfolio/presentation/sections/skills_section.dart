import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_portfolio/core/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../blocs/portfolio_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/responsive.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    // final theme = Theme.of(context);

    final skills = [
      {'name': 'Flutter', 'icon': Icons.flutter_dash, 'color': Colors.blue},
      {'name': 'Dart', 'icon': Icons.code, 'color': Colors.teal},
      {
        'name': 'Firebase',
        'icon': Icons.local_fire_department,
        'color': Colors.orange
      },
      {
        'name': 'State Management',
        'icon': Icons.layers,
        'color': Colors.purple
      },
      {
        'name': 'Clean Architecture',
        'icon': Icons.architecture,
        'color': Colors.red
      },
      {
        'name': 'Git/GitHub',
        'icon': FontAwesomeIcons.github,
        'color': Colors.black
      },
      {'name': 'REST API', 'icon': Icons.api, 'color': Colors.green},
      {
        'name': 'Responsive Design',
        'icon': Icons.devices,
        'color': Colors.indigo
      },
    ];

    return BlocBuilder<PortfolioBloc, PortfolioState>(
        builder: (context, state) {
      return Container(
        width: double.infinity,
        color:
            state.isDark ? AppTheme.backgroundColor : const Color(0xFFF1F5F9),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24.w : 100,
            vertical: (isMobile ? 20 : 30).h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShaderMask(
                shaderCallback: (bounds) =>
                    AppTheme.primaryGradient.createShader(bounds),
                child: Text(
                  "Skills & Expertise",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    fontSize: (isMobile ? 32 : 54).sp,
                    fontWeight: FontWeight.bold,
                    color: state.isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ).animate().fadeIn(),
              SizedBox(height: 20.h),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isMobile ? 2 : 4,
                  crossAxisSpacing: isMobile ? 12 : 32,
                  mainAxisSpacing: isMobile ? 12 : 32,
                  mainAxisExtent: isMobile ? 130.h : 160.h,
                ),
                itemCount: skills.length,
                itemBuilder: (context, index) {
                  final skill = skills[index];
                  return HoverSkillCard(
                    name: skill['name'] as String,
                    icon: skill['icon'] as IconData,
                    color: skill['color'] as Color,
                  )
                      .animate()
                      .fadeIn(delay: (index * 50).ms)
                      .scale(duration: 400.ms, curve: Curves.easeOutBack);
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}

class HoverSkillCard extends StatefulWidget {
  final String name;
  final IconData icon;
  final Color color;

  const HoverSkillCard({
    super.key,
    required this.name,
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
      // final theme = Theme.of(context);

      return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            // Removed fixed width/height to let GridView manage sizing
            decoration: BoxDecoration(
              color: isHovered
                  ? widget.color.withValues(alpha: 0.1)
                  : (state.isDark ? AppTheme.surfaceColor : Colors.grey[100]!),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isHovered
                    ? widget.color
                    : (state.isDark ? Colors.white12 : Colors.black12),
                width: 2,
              ),
              boxShadow: [
                if (isHovered)
                  BoxShadow(
                    color: widget.color.withAlpha(50),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(widget.icon,
                    size: 48.sp,
                    color: isHovered
                        ? widget.color
                        : (state.isDark
                            ? Colors.white70
                            : widget.color.withValues(alpha: 0.7))),
                SizedBox(height: 12.h),
                Text(
                  widget.name,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: state.isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
          ));
    });
  }
}
