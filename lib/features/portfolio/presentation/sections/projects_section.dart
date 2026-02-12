import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_portfolio/core/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/responsive.dart';
import '../widgets/project_card.dart';
import '../blocs/portfolio_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    // final theme = Theme.of(context);

    return BlocBuilder<PortfolioBloc, PortfolioState>(
        builder: (context, state) {
      return Container(
        width: double.infinity,
        color:
            state.isDark ? AppTheme.backgroundColor : const Color(0xFFF8FAFC),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24.w : 100,
            vertical: isMobile ? 20.h : 40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ShaderMask(
                shaderCallback: (bounds) =>
                    AppTheme.primaryGradient.createShader(bounds),
                child: Text(
                  "Projects",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    fontSize: (isMobile ? 32 : 54).sp,
                    fontWeight: FontWeight.bold,
                    color: state.isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ).animate().fadeIn(),
              SizedBox(height: 14.h),
              Container(
                width: 80,
                height: 4,
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(2),
                ),
              ).animate().fadeIn(delay: 200.ms).scaleX(),
              SizedBox(height: 64.h),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: isMobile ? 500 : 450,
                  crossAxisSpacing: isMobile ? 20 : 32,
                  mainAxisSpacing: isMobile ? 20 : 32,
                  mainAxisExtent: isMobile ? 400.h : 400.h,
                ),
                itemCount: PortfolioConstants.projects.length,
                itemBuilder: (context, index) {
                  final project = PortfolioConstants.projects[index];
                  return ProjectCard(project: project)
                      .animate()
                      .fadeIn(delay: (100 * (index % 3)).ms)
                      .slideY(begin: 0.1);
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
