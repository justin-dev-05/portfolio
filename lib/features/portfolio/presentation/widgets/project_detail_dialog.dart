import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/responsive.dart';
import '../../domain/entities/project_entity.dart';

class ProjectDetailDialog extends StatelessWidget {
  final ProjectEntity project;

  const ProjectDetailDialog({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = Responsive.isMobile(context);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: isMobile ? 12.w : 24.w,
        vertical: isMobile ? 16.h : 24.h,
      ),
      child: Container(
        constraints: BoxConstraints(maxWidth: 680.w),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E293B) : Colors.white,
          borderRadius: BorderRadius.circular(isMobile ? 20.r : 28.r),
          border: Border.all(
            color: isDark
                ? AppTheme.primaryColor.withValues(alpha: 0.3)
                : AppTheme.primaryColor.withValues(alpha: 0.2),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryColor.withValues(alpha: 0.15),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(isMobile ? 20.r : 28.r),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Banner
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(isMobile ? 16.r : 24.r),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: project.category == 'Desktop Apps'
                          ? [const Color(0xFF0EA5E9), const Color(0xFF6366F1)]
                          : [AppTheme.primaryColor, AppTheme.secondaryColor],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: isMobile ? 10.w : 12.w,
                                vertical: isMobile ? 4.h : 6.h),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.25),
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  project.category == 'Desktop Apps'
                                      ? Icons.desktop_windows_rounded
                                      : (project.category == 'Enterprise Systems'
                                          ? Icons.business_center_rounded
                                          : Icons.smartphone_rounded),
                                  size: isMobile ? 12.sp : 14.sp,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  project.category.toUpperCase(),
                                  style: GoogleFonts.outfit(
                                    fontSize: isMobile ? 10.sp : 11.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 1.1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            constraints: const BoxConstraints(),
                            padding: EdgeInsets.zero,
                            icon: Container(
                              padding: EdgeInsets.all(5.r),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.close_rounded,
                                color: Colors.white,
                                size: isMobile ? 18.sp : 22.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: isMobile ? 10.h : 14.h),
                      Text(
                        project.name,
                        style: GoogleFonts.outfit(
                          fontSize: isMobile ? 18.sp : 24.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.2,
                        ),
                      ),
                      if (project.clientOrPlatform != null) ...[
                        SizedBox(height: 6.h),
                        Row(
                          children: [
                            Icon(Icons.devices_rounded,
                                size: isMobile ? 12.sp : 14.sp, color: Colors.white70),
                            SizedBox(width: 6.w),
                            Text(
                              project.clientOrPlatform!,
                              style: GoogleFonts.outfit(
                                fontSize: isMobile ? 11.sp : 13.sp,
                                color: Colors.white.withValues(alpha: 0.9),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),

                // Body Details
                Padding(
                  padding: EdgeInsets.all(isMobile ? 16.r : 24.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Overview",
                        style: GoogleFonts.outfit(
                          fontSize: isMobile ? 14.sp : 16.sp,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        project.description,
                        style: GoogleFonts.outfit(
                          fontSize: isMobile ? 12.sp : 14.sp,
                          color: isDark ? Colors.white70 : Colors.black87,
                          height: 1.45,
                        ),
                      ),
                      SizedBox(height: isMobile ? 14.h : 20.h),

                      // Key Features Section
                      if (project.keyFeatures != null &&
                          project.keyFeatures!.isNotEmpty) ...[
                        Text(
                          "Key Capabilities & Features",
                          style: GoogleFonts.outfit(
                            fontSize: isMobile ? 14.sp : 16.sp,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        ...project.keyFeatures!.map((feature) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: isMobile ? 6.h : 8.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 2.h),
                                  padding: EdgeInsets.all(3.r),
                                  decoration: BoxDecoration(
                                    color: AppTheme.primaryColor
                                        .withValues(alpha: 0.15),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.check_rounded,
                                    size: isMobile ? 10.sp : 12.sp,
                                    color: AppTheme.primaryColor,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Text(
                                    feature,
                                    style: GoogleFonts.outfit(
                                      fontSize: isMobile ? 12.sp : 13.sp,
                                      color: isDark
                                          ? Colors.white.withValues(alpha: 0.85)
                                          : Colors.black87,
                                      height: 1.35,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                        SizedBox(height: isMobile ? 14.h : 18.h),
                      ],

                      // Technologies Used Section
                      Text(
                        "Technologies & Tools",
                        style: GoogleFonts.outfit(
                          fontSize: isMobile ? 14.sp : 16.sp,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Wrap(
                        spacing: 6.w,
                        runSpacing: 6.h,
                        children: project.technologies.map((tech) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: isMobile ? 10.w : 12.w,
                                vertical: isMobile ? 4.h : 6.h),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? AppTheme.primaryColor
                                      .withValues(alpha: 0.12)
                                  : const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(
                                color: AppTheme.primaryColor
                                    .withValues(alpha: 0.3),
                              ),
                            ),
                            child: Text(
                              tech,
                              style: GoogleFonts.outfit(
                                fontSize: isMobile ? 11.sp : 12.sp,
                                fontWeight: FontWeight.w600,
                                color: isDark
                                    ? AppTheme.primaryColor
                                    : const Color(0xFF0F172A),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      // Dialog Action Button (if liveUrl exists)
                      if (project.liveUrl != null) ...[
                        SizedBox(height: isMobile ? 16.h : 24.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () => launchUrl(Uri.parse(project.liveUrl!)),
                              icon: Icon(Icons.launch_rounded, size: isMobile ? 14.sp : 16.sp),
                              label: Text(
                                "Live Demo",
                                style: GoogleFonts.outfit(
                                  fontSize: isMobile ? 12.sp : 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primaryColor,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(
                                    horizontal: isMobile ? 16.w : 20.w,
                                    vertical: isMobile ? 8.h : 12.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ).animate().scale(duration: 250.ms, curve: Curves.easeOutCubic),
    );
  }
}
