import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portfolio/core/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/project_entity.dart';
import '../blocs/portfolio_bloc.dart';
import 'project_detail_dialog.dart';

class ProjectCard extends StatefulWidget {
  final ProjectEntity project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool isHovered = false;

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Desktop Apps':
        return Icons.desktop_windows_rounded;
      case 'Enterprise Systems':
        return Icons.business_center_rounded;
      case 'Mobile Apps':
      default:
        return Icons.smartphone_rounded;
    }
  }

  List<Color> _getHeaderGradient(String category) {
    if (category == 'Desktop Apps') {
      return [const Color(0xFF0EA5E9), const Color(0xFF6366F1)];
    } else if (category == 'Enterprise Systems') {
      return [const Color(0xFF6366F1), const Color(0xFFA855F7)];
    } else {
      return [AppTheme.primaryColor, AppTheme.secondaryColor];
    }
  }

  String _getAppInitials(String name) {
    final cleanName = name.replaceAll(RegExp(r'\([^)]*\)'), '').trim();
    final words = cleanName.split(RegExp(r'\s+'));
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    } else if (cleanName.length >= 2) {
      return cleanName.substring(0, 2).toUpperCase();
    }
    return cleanName.toUpperCase();
  }

  String _getShortAppName(String name) {
    return name.split('(')[0].trim();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PortfolioBloc, PortfolioState>(
      builder: (context, state) {
        final isDesktopApp = widget.project.category == 'Desktop Apps';

        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => ProjectDetailDialog(project: widget.project),
              );
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              transform: isHovered
                  // ignore: deprecated_member_use
                  ? (Matrix4.identity()..translate(0, -8, 0))
                  : Matrix4.identity(),
              decoration: BoxDecoration(
                color: isHovered
                    ? (state.isDark
                        ? const Color(0xFF1E293B)
                        : Colors.white)
                    : (state.isDark
                        ? const Color(0xFF1E293B).withValues(alpha: 0.7)
                        : Colors.white),
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(
                  color: isHovered
                      ? AppTheme.primaryColor.withValues(alpha: 0.6)
                      : (isDesktopApp
                          ? AppTheme.primaryColor.withValues(alpha: 0.3)
                          : (state.isDark
                              ? Colors.white.withValues(alpha: 0.08)
                              : Colors.black.withValues(alpha: 0.08))),
                  width: isHovered || isDesktopApp ? 1.8 : 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: isHovered
                        ? AppTheme.primaryColor.withValues(alpha: 0.18)
                        : Colors.black.withValues(alpha: state.isDark ? 0.25 : 0.04),
                    blurRadius: isHovered ? 28 : 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24.r),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Card Top Visual Header with App Logo & Monogram
                        Container(
                          height: 100.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: _getHeaderGradient(widget.project.category),
                            ),
                          ),
                          child: Stack(
                            children: [
                              // Decorative Background Pattern Circle
                              Positioned(
                                right: -20,
                                bottom: -20,
                                child: Container(
                                  width: 100.r,
                                  height: 100.r,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white.withValues(alpha: 0.1),
                                  ),
                                ),
                              ),

                              // App Logo & App Name Visual Banner
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Custom App Logo Container
                                      Container(
                                        width: 44.r,
                                        height: 44.r,
                                        decoration: BoxDecoration(
                                          color: Colors.black.withValues(alpha: 0.25),
                                          borderRadius: BorderRadius.circular(14.r),
                                          border: Border.all(
                                            color: Colors.white.withValues(alpha: 0.4),
                                            width: 1.5,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withValues(alpha: 0.2),
                                              blurRadius: 10,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Text(
                                            _getAppInitials(widget.project.name),
                                            style: GoogleFonts.outfit(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.white,
                                              letterSpacing: 1.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 12.w),
                                      Flexible(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _getShortAppName(widget.project.name),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.outfit(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                shadows: [
                                                  Shadow(
                                                    color: Colors.black.withValues(alpha: 0.3),
                                                    blurRadius: 8,
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 2.h),
                                            Text(
                                              widget.project.clientOrPlatform ?? widget.project.category,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.outfit(
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white.withValues(alpha: 0.85),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),



                        // Card Content
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(16.r),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.project.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.outfit(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    height: 1.2,
                                    color: state.isDark
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                Text(
                                  widget.project.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.outfit(
                                    fontSize: 11.sp,
                                    color: state.isDark
                                        ? Colors.white70
                                        : Colors.black54,
                                    height: 1.35,
                                  ),
                                ),

                                const Spacer(),


                                // Tech stack pills
                                if (widget.project.technologies.isNotEmpty) ...[
                                  Wrap(
                                    spacing: 6.w,
                                    runSpacing: 6.h,
                                    children: widget.project.technologies
                                        .take(2)
                                        .map((tech) => Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 9.w, vertical: 4.h),
                                              decoration: BoxDecoration(
                                                color: state.isDark
                                                    ? Colors.white.withValues(alpha: 0.07)
                                                    : const Color(0xFFF1F5F9),
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                border: Border.all(
                                                  color: state.isDark
                                                      ? Colors.white.withValues(alpha: 0.05)
                                                      : Colors.black.withValues(alpha: 0.04),
                                                ),
                                              ),
                                              child: Text(
                                                tech,
                                                style: GoogleFonts.outfit(
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: state.isDark
                                                      ? Colors.white70
                                                      : Colors.black87,
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                  SizedBox(height: 8.h),
                                ],


                                // Action link
                                Row(
                                  children: [
                                    Text(
                                      "EXPLORE DETAILS",
                                      style: GoogleFonts.outfit(
                                        fontSize: 11.sp,
                                        color: AppTheme.primaryColor,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                    SizedBox(width: 6.w),
                                    AnimatedContainer(
                                      duration: const Duration(milliseconds: 200),
                                      transform: isHovered
                                          ? (Matrix4.identity()..translate(4, 0, 0))
                                          : Matrix4.identity(),
                                      child: Icon(
                                        Icons.arrow_forward_rounded,
                                        size: 13.sp,
                                        color: AppTheme.primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),

                    // Featured Ribbon (Top Right)
                    if (widget.project.isFeatured)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 5.h),
                          decoration: BoxDecoration(
                            gradient: AppTheme.primaryGradient,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12.r),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.primaryColor.withValues(alpha: 0.3),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star_rounded,
                                  size: 11.sp, color: Colors.white),
                              SizedBox(width: 3.w),
                              Text(
                                "FEATURED",
                                style: GoogleFonts.outfit(
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
