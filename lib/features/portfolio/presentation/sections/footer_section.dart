import 'package:flutter/material.dart';
import 'package:flutter_portfolio/core/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../blocs/portfolio_bloc.dart';
import '../../../../core/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PortfolioBloc, PortfolioState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 40.h),
          decoration: BoxDecoration(
            color: state.isDark ? AppTheme.backgroundColor : Colors.white,
            border: Border(
                top: BorderSide(
                    color: (state.isDark ? Colors.white : Colors.black)
                        .withAlpha(10))),
          ),
          child: Column(
            children: [
              Text(
                "© ${DateTime.now().year} ${PortfolioConstants.name}. Built with Flutter.",
                style: GoogleFonts.outfit(
                  fontSize: 14.sp,
                  color: state.isDark ? Colors.white54 : Colors.black54,
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const _SocialIcon(icon: FontAwesomeIcons.linkedin),
                  SizedBox(width: 24.w),
                  const _SocialIcon(icon: FontAwesomeIcons.github),
                  SizedBox(width: 24.w),
                  const _SocialIcon(icon: FontAwesomeIcons.twitter),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  const _SocialIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PortfolioBloc, PortfolioState>(
      builder: (context, state) {
        return IconButton(
          onPressed: () {},
          icon: FaIcon(icon, size: 20.sp),
          color: state.isDark ? Colors.white70 : Colors.black54,
        );
      },
    );
  }
}
