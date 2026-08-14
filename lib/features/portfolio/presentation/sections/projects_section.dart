import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_portfolio/core/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/responsive.dart';
import '../../domain/entities/project_entity.dart';
import '../widgets/project_card.dart';
import '../blocs/portfolio_bloc.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  String selectedCategory = 'All';
  bool showAll = false;

  final List<String> categories = [
    'All',
    'Mobile Apps',
    'Enterprise Systems',
  ];

  List<ProjectEntity> get filteredProjects {
    return PortfolioConstants.projects.where((project) {
      return selectedCategory == 'All' || project.category == selectedCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return BlocBuilder<PortfolioBloc, PortfolioState>(
      builder: (context, state) {
        final filteredList = filteredProjects;
        final projectsToDisplay =
            showAll ? filteredList : filteredList.take(5).toList();

        return Container(
          width: double.infinity,
          color: state.isDark
              ? AppTheme.backgroundColor
              : const Color(0xFFF8FAFC),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20.w : 80.w,
              vertical: isMobile ? 32.h : 60.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Category Pill Badge
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
                        Icons.rocket_launch_rounded,
                        size: 14.sp,
                        color: AppTheme.primaryColor,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        "PROVEN PORTFOLIO & QFS APP SUITE",
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
                SizedBox(height: 16.h),

                // Main Title
                ShaderMask(
                  shaderCallback: (bounds) =>
                      AppTheme.primaryGradient.createShader(bounds),
                  child: Text(
                    "Featured Projects & Apps",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontSize: (isMobile ? 30 : 48).sp,
                      fontWeight: FontWeight.bold,
                      color: state.isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ).animate().fadeIn(delay: 100.ms),
                SizedBox(height: 12.h),

                // Subtitle
                Text(
                  "High-performance Mobile Applications, E-Commerce Storefronts, and Enterprise Management Platforms.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    fontSize: isMobile ? 14.sp : 16.sp,
                    color: state.isDark ? Colors.white70 : Colors.black54,
                    height: 1.4,
                  ),
                ).animate().fadeIn(delay: 200.ms),
                SizedBox(height: 24.h),

                // Category Filter Chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: categories.map((cat) {
                      final isSelected = selectedCategory == cat;
                      return Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: ChoiceChip(
                          label: Text(cat),
                          selected: isSelected,
                          onSelected: (selected) {
                            if (selected) {
                              setState(() {
                                selectedCategory = cat;
                                showAll = false; // Reset expand state when category changes
                              });
                            }
                          },
                          labelStyle: GoogleFonts.outfit(
                            fontSize: 12.sp,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.w500,
                            color: isSelected
                                ? Colors.white
                                : (state.isDark
                                    ? Colors.white70
                                    : Colors.black87),
                          ),
                          selectedColor: AppTheme.primaryColor,
                          backgroundColor: state.isDark
                              ? const Color(0xFF1E293B)
                              : const Color(0xFFE2E8F0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            side: BorderSide(
                              color: isSelected
                                  ? AppTheme.primaryColor
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ).animate().fadeIn(delay: 300.ms),
                SizedBox(height: 28.h),

                // Counter Tag & Toggle Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      showAll || filteredList.length <= 5
                          ? "Showing all ${filteredList.length} ${filteredList.length == 1 ? 'Project' : 'Projects'}"
                          : "Showing Top 5 of ${filteredList.length} Projects",
                      style: GoogleFonts.outfit(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: state.isDark ? Colors.white60 : Colors.black54,
                      ),
                    ),
                    if (filteredList.length > 5)
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            showAll = !showAll;
                          });
                        },
                        icon: Icon(
                          showAll
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                          size: 20.sp,
                          color: AppTheme.primaryColor,
                        ),
                        label: Text(
                          showAll ? "Show Less" : "Show All (${filteredList.length})",
                          style: GoogleFonts.outfit(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 16.h),

                // Projects Grid View with AnimatedSize
                AnimatedSize(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  child: GridView.builder(
                    key: ValueKey('grid-$selectedCategory-$showAll'),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: isMobile ? 500 : 420,
                      crossAxisSpacing: isMobile ? 16 : 24,
                      mainAxisSpacing: isMobile ? 16 : 24,
                      mainAxisExtent: isMobile ? 400 : 410,
                    ),
                    itemCount: projectsToDisplay.length,
                    itemBuilder: (context, index) {
                      final project = projectsToDisplay[index];
                      return ProjectCard(project: project)
                          .animate()
                          .fadeIn(delay: (40 * (index % 6)).ms)
                          .slideY(begin: 0.05);
                    },
                  ),
                ),

                // Show More / Show Less Large Button
                if (filteredList.length > 5) ...[
                  SizedBox(height: 36.h),
                  Center(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          showAll = !showAll;
                        });
                      },
                      borderRadius: BorderRadius.circular(30.r),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 24.w : 36.w,
                          vertical: isMobile ? 12.h : 16.h,
                        ),
                        decoration: BoxDecoration(
                          gradient: showAll
                              ? null
                              : AppTheme.primaryGradient,
                          color: showAll
                              ? (state.isDark
                                  ? Colors.white.withValues(alpha: 0.1)
                                  : Colors.black.withValues(alpha: 0.05))
                              : null,
                          borderRadius: BorderRadius.circular(30.r),
                          border: showAll
                              ? Border.all(
                                  color: AppTheme.primaryColor.withValues(alpha: 0.5),
                                  width: 1.5,
                                )
                              : null,
                          boxShadow: showAll
                              ? []
                              : [
                                  BoxShadow(
                                    color: AppTheme.primaryColor.withValues(alpha: 0.3),
                                    blurRadius: 16,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              showAll
                                  ? "Show Less Projects"
                                  : "Show More Projects (${filteredList.length - 5} More)",
                              style: GoogleFonts.outfit(
                                fontSize: isMobile ? 13.sp : 15.sp,
                                fontWeight: FontWeight.bold,
                                color: showAll
                                    ? (state.isDark ? Colors.white : AppTheme.primaryColor)
                                    : Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Icon(
                              showAll
                                  ? Icons.keyboard_arrow_up_rounded
                                  : Icons.keyboard_arrow_down_rounded,
                              color: showAll
                                  ? (state.isDark ? Colors.white : AppTheme.primaryColor)
                                  : Colors.white,
                              size: isMobile ? 20.sp : 22.sp,
                            ),
                          ],
                        ),
                      ),
                    ).animate().fadeIn(delay: 200.ms),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
