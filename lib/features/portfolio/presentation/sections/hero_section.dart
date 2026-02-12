import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portfolio/core/theme/app_theme.dart';
import 'package:flutter_portfolio/features/portfolio/presentation/blocs/portfolio_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/modern_cta.dart';
import '../../../../core/utils/responsive.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return BlocBuilder<PortfolioBloc, PortfolioState>(
      builder: (context, state) {
        final theme = Theme.of(context);
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            gradient: RadialGradient(
              center: const Alignment(0, -0.5),
              radius: 1.5,
              colors: [
                state.isDark
                    ? const Color(0xFF1E293B).withValues(alpha: 0.5)
                    : Colors.white,
                theme.scaffoldBackgroundColor,
              ],
            ),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24.w : 40,
                vertical: isMobile ? 100.h : 120,
              ),
              child: _buildContent(context, isMobile, state.isDark),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, bool isMobile, bool isDark) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // mascot & Hii Animation
        SizedBox(
          height: (isMobile ? 200 : 300).h,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Large background indicator
              // Opacity(
              //   opacity: 0.05,
              //   child: Text(
              //     "DASH",
              //     style: GoogleFonts.outfit(
              //       fontSize: (isMobile ? 120 : 200).sp,
              //       fontWeight: FontWeight.bold,
              //       color: isDark ? Colors.white : Colors.black,
              //     ),
              //   ),
              // )
              //     .animate()
              //     .fadeIn(duration: 1.seconds)
              //     .scale(begin: const Offset(0.8, 0.8)),

              // The Mascot (GIF/Static)
              Image.asset(
                "assets/images/logo.png",
                height: (isMobile ? 160 : 350).h,
              ).animate().fadeIn(duration: 1.seconds),

              // "Hii!" Bubble
              Positioned(
                right: (isMobile ? 20 : 60).w,
                top: (isMobile ? 20 : 40).h,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryColor.withValues(alpha: 0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      )
                    ],
                  ),
                  child: Text(
                    "Hii! 👋",
                    style: GoogleFonts.outfit(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                )
                    .animate(
                        onPlay: (controller) =>
                            controller.repeat(reverse: true))
                    .scale(
                        duration: 1.seconds,
                        begin: const Offset(0.9, 0.9),
                        end: const Offset(1.1, 1.1))
                    .shake(hz: 2, curve: Curves.easeInOut),
              ),
            ],
          ),
        ),

        // Main Title
        ShaderMask(
          shaderCallback: (bounds) =>
              AppTheme.primaryGradient.createShader(bounds),
          child: Text(
            "FLUTTER DEVELOPER",
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: (isMobile ? 36 : 72).sp,
              fontWeight: FontWeight.bold,
              height: 1.1,
              color: Colors.white,
            ),
          ),
        ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.2),

        SizedBox(height: 20.h),

        // Catchy Subtitle
        Text(
          "I build beautiful, high-performance mobile experiences.",
          textAlign: TextAlign.center,
          style: GoogleFonts.outfit(
            fontSize: (isMobile ? 18 : 24).sp,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.white70 : Colors.black54,
          ),
        ).animate().fadeIn(delay: 800.ms),

        SizedBox(height: 48.h),

        // Actions
        Wrap(
          spacing: 20.w,
          runSpacing: 20.h,
          alignment: WrapAlignment.center,
          children: [
            ModernCTA(
              label: "Explore Work",
              onTap: () {
                context.read<PortfolioBloc>().add(ScrollToSectionRequested(1));
              },
              isPrimary: true,
            ).animate().scale(delay: 1.seconds, curve: Curves.easeOutBack),
            ModernCTA(
              label: "Contact Me",
              onTap: () {
                context.read<PortfolioBloc>().add(ScrollToSectionRequested(4));
              },
              isPrimary: false,
            ).animate().scale(delay: 1.1.seconds, curve: Curves.easeOutBack),
          ],
        ),
      ],
    );
  }
}
