import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_portfolio/core/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/portfolio_bloc.dart';
import '../../../../core/utils/responsive.dart';

class ExperienceSection extends StatefulWidget {
  const ExperienceSection({super.key});

  @override
  State<ExperienceSection> createState() => _ExperienceSectionState();
}

class _ExperienceSectionState extends State<ExperienceSection> {
  int activeTab = 0; // 0: Experience, 1: Education, 2: Languages Known

  final List<Map<String, dynamic>> workExperiences = [
    {
      'company': 'Senior Mobile Application Engineer',
      'role': 'Flutter & Android Development Specialist',
      'period': '5+ Years Experience (2019 - Present)',
      'location': 'Ahmedabad, India',
      'isCurrent': true,
      'highlights': [
        'Architected & maintained scalable Flutter and native Android applications across e-commerce, enterprise sales, healthcare, streaming, field-service, and POS industries.',
        'Owned end-to-end mobile development: architecture, state management (BLoC/Provider), API integration, testing, and production app store releases.',
        'Integrated advanced AI & hardware features: Google Gemini AI, ML Kit OCR, TensorFlow face recognition, Pine Labs POS hardware, and FFmpeg video processing.',
        'Engineered payment & streaming modules: Razorpay, Stripe, Google Play In-App Billing, UPI/card workflows, HLS/DASH streaming, and PDF printing engines.',
        'Built real-time & offline-first systems using Cloud Firestore, FCM, WebSockets, Dio/Retrofit, and local SQLite/Hive databases.',
        'Mentored junior developers, performed code reviews, and optimized app performance across low-, mid-, and high-end mobile devices.'
      ],
      'technologies': [
        'Flutter',
        'Dart',
        'Android (Kotlin/Java)',
        'BLoC',
        'Clean MVVM',
        'Firebase',
        'Google Gemini AI',
        'ML Kit OCR',
        'Pine Labs POS',
        'Razorpay/Stripe'
      ],
    },
  ];

  final List<Map<String, dynamic>> educationList = [
    {
      'degree': 'B. E. in Computer Engineering',
      'institution': 'Government Engineering College (GEC), Modasa',
      'period': '2018 - 2021',
      'grade': 'First Class with Distinction',
      'description':
          'Specialized in Software Engineering, Data Structures, Mobile Computing, Operating Systems, and Database Management Systems.',
    },
    {
      'degree': 'Diploma in Computer Engineering',
      'institution': 'R. C. Technical Institute, Ahmedabad',
      'period': '2015 - 2018',
      'grade': 'First Class with Distinction',
      'description':
          'Comprehensive technical foundation in Computer Programming, Object-Oriented Design, Java, C++, and Web Engineering.',
    },
  ];


  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return BlocBuilder<PortfolioBloc, PortfolioState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          color: state.isDark
              ? AppTheme.backgroundColor
              : const Color(0xFFF8FAFC),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20.w : 80.w,
              vertical: isMobile ? 40.h : 70.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Top Category Pill
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
                        Icons.work_history_rounded,
                        size: 14.sp,
                        color: AppTheme.primaryColor,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        "CV HIGHLIGHTS & BACKGROUND",
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

                // Main Heading
                ShaderMask(
                  shaderCallback: (bounds) =>
                      AppTheme.primaryGradient.createShader(bounds),
                  child: Text(
                    "Experience & Credentials",
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
                  "5+ Years of Proven Senior Mobile Application Engineering in Flutter & Android",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    fontSize: isMobile ? 14.sp : 16.sp,
                    color: state.isDark ? Colors.white70 : Colors.black54,
                  ),
                ).animate().fadeIn(delay: 150.ms),
                SizedBox(height: 32.h),

                // Interactive Tab Switcher
                Container(
                  padding: EdgeInsets.all(6.r),
                  decoration: BoxDecoration(
                    color: state.isDark
                        ? const Color(0xFF1E293B)
                        : const Color(0xFFE2E8F0),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildTabButton(0, "Work Experience (5+ Yrs)", Icons.business_center_rounded, isMobile),
                      _buildTabButton(1, "Education", Icons.school_rounded, isMobile),
                    ],
                  ),
                ).animate().fadeIn(delay: 200.ms),
                SizedBox(height: 36.h),

                // Tab Content View
                if (activeTab == 0)
                  _buildWorkExperienceTab(state.isDark, isMobile)
                else
                  _buildEducationTab(state.isDark, isMobile),

              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTabButton(int index, String title, IconData icon, bool isMobile) {
    final isSelected = activeTab == index;
    return GestureDetector(
      onTap: () => setState(() => activeTab = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 12.w : 20.w,
          vertical: isMobile ? 8.h : 12.h,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppTheme.primaryColor.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  )
                ]
              : [],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 16.sp,
              color: isSelected ? Colors.white : Colors.grey[600],
            ),
            SizedBox(width: 8.w),
            Text(
              title,
              style: GoogleFonts.outfit(
                fontSize: isMobile ? 11.sp : 13.sp,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? Colors.white : Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkExperienceTab(bool isDark, bool isMobile) {
    return Column(
      children: workExperiences.map((exp) {
        return Container(
          constraints: BoxConstraints(maxWidth: 900.w),
          padding: EdgeInsets.all(isMobile ? 20.r : 32.r),

          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E293B) : Colors.white,
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(
              color: AppTheme.primaryColor.withValues(alpha: 0.3),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryColor.withValues(alpha: 0.1),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isMobile) ...[

                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(
                        color: AppTheme.primaryColor.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Text(
                      exp['period'] as String,
                      style: GoogleFonts.outfit(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  exp['company'] as String,
                  style: GoogleFonts.outfit(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  exp['role'] as String,
                  style: GoogleFonts.outfit(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ] else ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            exp['company'] as String,
                            style: GoogleFonts.outfit(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            exp['role'] as String,
                            style: GoogleFonts.outfit(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(
                          color: AppTheme.primaryColor.withValues(alpha: 0.4),
                        ),
                      ),
                      child: Text(
                        exp['period'] as String,
                        style: GoogleFonts.outfit(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],

              SizedBox(height: 20.h),

              Text(
                "Key Responsibilities & Engineering Highlights",
                style: GoogleFonts.outfit(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              SizedBox(height: 12.h),

              ...((exp['highlights'] as List<String>).map((highlight) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 4.h),
                        padding: EdgeInsets.all(3.r),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check_rounded,
                          size: 10.sp,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          highlight,
                          style: GoogleFonts.outfit(
                            fontSize: 13.sp,
                            color: isDark ? Colors.white70 : Colors.black87,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              })),

              SizedBox(height: 16.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: (exp['technologies'] as List<String>).map((tech) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.08)
                          : const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      tech,
                      style: GoogleFonts.outfit(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white70 : Colors.black87,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ).animate().fadeIn().slideY(begin: 0.1);
      }).cast<Widget>().toList(),
    );
  }

  Widget _buildEducationTab(bool isDark, bool isMobile) {
    return Container(
      constraints: BoxConstraints(maxWidth: 900.w),
      child: Column(

        children: educationList.map((edu) {
          return Container(
            margin: EdgeInsets.only(bottom: 20.h),
            padding: EdgeInsets.all(isMobile ? 20.r : 28.r),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E293B) : Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : Colors.black.withValues(alpha: 0.08),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.school_rounded,
                    size: 24.sp,
                    color: AppTheme.primaryColor,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isMobile) ...[
                        Text(
                          edu['degree'] as String,
                          style: GoogleFonts.outfit(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          edu['period'] as String,
                          style: GoogleFonts.outfit(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ] else ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                edu['degree'] as String,
                                style: GoogleFonts.outfit(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.white : Colors.black87,
                                ),
                              ),
                            ),
                            Text(
                              edu['period'] as String,
                              style: GoogleFonts.outfit(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],

                      SizedBox(height: 4.h),
                      Text(
                        edu['institution'] as String,
                        style: GoogleFonts.outfit(
                          fontSize: 13.sp,
                          color: AppTheme.secondaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        edu['description'] as String,
                        style: GoogleFonts.outfit(
                          fontSize: 13.sp,
                          color: isDark ? Colors.white70 : Colors.black54,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ).animate().fadeIn().slideX(begin: 0.05);
        }).toList(),
      ),
    );
  }
}

