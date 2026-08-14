import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portfolio/core/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/utils/responsive.dart';
import '../blocs/portfolio_bloc.dart';
import '../widgets/modern_cta.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isLoading = false;

  void _sendEmail() async {
    final String name = _nameController.text.trim();
    final String email = _emailController.text.trim();
    final String phone = _phoneController.text.trim();
    final String message = _messageController.text.trim();

    if (name.isEmpty || email.isEmpty || message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in all required fields"),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    await Future.delayed(const Duration(seconds: 1));

    final String phoneDetails =
        phone.isNotEmpty ? "Phone: $phone" : "Phone: Not provided";

    final Uri emailUrl = Uri.parse(
      'mailto:justin1998.qf@gmail.com?subject=Portfolio Inquiry from $name&body=--- CONTACT DETAILS ---\n\n'
      'Name: $name\n'
      'Email: $email\n'
      '$phoneDetails\n\n'
      '--- MESSAGE ---\n\n'
      '$message',
    );

    setState(() => _isLoading = false);

    if (await canLaunchUrl(emailUrl)) {
      await launchUrl(emailUrl);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Email client opened! Thank you for reaching out."),
            backgroundColor: Colors.green,
          ),
        );
        _nameController.clear();
        _emailController.clear();
        _phoneController.clear();
        _messageController.clear();
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Could not launch email application")),
        );
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isDesktop = Responsive.isDesktop(context);

    return BlocBuilder<PortfolioBloc, PortfolioState>(
      builder: (context, state) {
        final isDark = state.isDark;

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20.w : 60.w,
              vertical: isMobile ? 50.h : 80.h,
            ),
            child: Column(
              children: [
                // Header Badge Tag
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: AppTheme.primaryColor.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(FontAwesomeIcons.paperPlane,
                            size: 13.sp, color: AppTheme.primaryColor),
                        SizedBox(width: 8.w),
                        Text(
                          "LET'S CONNECT & COLLABORATE",
                          style: GoogleFonts.outfit(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor,
                            letterSpacing: 1.1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ).animate().fadeIn(),

                SizedBox(height: 16.h),

                // Main Title
                ShaderMask(
                  shaderCallback: (bounds) =>
                      AppTheme.primaryGradient.createShader(bounds),
                  child: Text(
                    "GET IN TOUCH",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontSize: isMobile ? 32.sp : 50.sp,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ).animate().fadeIn(delay: 150.ms).slideY(begin: 0.1),

                SizedBox(height: 12.h),

                // Subtitle
                Text(
                  "Have a project in mind, an app idea, or an opportunity? Send me a message below!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    fontSize: isMobile ? 14.sp : 17.sp,
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                ).animate().fadeIn(delay: 250.ms),

                SizedBox(height: 40.h),

                // Main Content Card (Two Column Desktop / Single Column Mobile)
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1150),
                  child: isDesktop
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Left Column: Direct Info Cards & Status
                            Expanded(
                              flex: 5,
                              child: _buildInfoSpotlight(isMobile: false, isDark: isDark),
                            ),
                            SizedBox(width: 40.w),
                            // Right Column: Interactive Form
                            Expanded(
                              flex: 7,
                              child: _buildFormCard(isMobile: false, isDark: isDark),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            _buildInfoSpotlight(isMobile: true, isDark: isDark),
                            SizedBox(height: 30.h),
                            _buildFormCard(isMobile: true, isDark: isDark),
                          ],
                        ),
                ).animate().fadeIn(delay: 350.ms).slideY(begin: 0.05),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoSpotlight({required bool isMobile, required bool isDark}) {
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Availability Status Pill
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E293B) : Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: const Color(0xFF10B981).withValues(alpha: 0.4),
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF10B981).withValues(alpha: 0.1),
                blurRadius: 16,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 10.r,
                height: 10.r,
                decoration: const BoxDecoration(
                  color: Color(0xFF10B981),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 10.w),
              Text(
                "Available for Full-time & Contract Roles",
                style: GoogleFonts.outfit(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 24.h),

        // Quick Contact Cards
        _buildContactCard(
          icon: FontAwesomeIcons.phone,
          title: "Phone & WhatsApp",
          subtitle: "+91 7359792115",
          onTap: () => launchUrl(Uri.parse("tel:+917359792115")),
          isDark: isDark,
          isMobile: isMobile,
        ),

        SizedBox(height: 16.h),

        _buildContactCard(
          icon: FontAwesomeIcons.envelope,
          title: "Email Address",
          subtitle: "justin1998.qf@gmail.com",
          onTap: () => launchUrl(Uri.parse("mailto:justin1998.qf@gmail.com")),
          isDark: isDark,
          isMobile: isMobile,
        ),

        SizedBox(height: 16.h),

        _buildContactCard(
          icon: FontAwesomeIcons.locationDot,
          title: "Location",
          subtitle: "Vastral, Ahmedabad, Gujarat, India",
          onTap: null,
          isDark: isDark,
          isMobile: isMobile,
        ),
      ],
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback? onTap,
    required bool isDark,
    required bool isMobile,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.all(isMobile ? 16.r : 20.r),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E293B) : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.08),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Icon(icon, size: 18.sp, color: AppTheme.primaryColor),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.outfit(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white60 : Colors.black54,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: GoogleFonts.outfit(
                      fontSize: isMobile ? 13.sp : 15.sp,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            if (onTap != null)
              Icon(Icons.arrow_forward_ios_rounded,
                  size: 14.sp, color: AppTheme.primaryColor.withValues(alpha: 0.6)),
          ],
        ),
      ),
    );
  }

  Widget _buildFormCard({required bool isMobile, required bool isDark}) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 20.r : 36.r),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(28.r),
        border: Border.all(
          color: AppTheme.primaryColor.withValues(alpha: 0.25),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withValues(alpha: 0.1),
            blurRadius: 40,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Send a Direct Message",
            style: GoogleFonts.outfit(
              fontSize: isMobile ? 18.sp : 22.sp,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          SizedBox(height: 20.h),
          ContactField(
            label: "Your Name *",
            hint: "Enter your full name",
            icon: FontAwesomeIcons.user,
            controller: _nameController,
            isDark: isDark,
          ),
          SizedBox(height: 16.h),
          ContactField(
            label: "Email Address *",
            hint: "hello@domain.com",
            icon: FontAwesomeIcons.envelope,
            controller: _emailController,
            isDark: isDark,
          ),
          SizedBox(height: 16.h),
          ContactField(
            label: "Phone Number (Optional)",
            hint: "+91 98765 43210",
            icon: FontAwesomeIcons.phone,
            controller: _phoneController,
            isDark: isDark,
          ),
          SizedBox(height: 16.h),
          ContactField(
            label: "Your Message *",
            hint: "Tell me about your project or opportunity...",
            icon: FontAwesomeIcons.commentDots,
            maxLines: 4,
            controller: _messageController,
            isDark: isDark,
          ),
          SizedBox(height: 28.h),
          Center(
            child: ModernCTA(
              label: "🚀 Send Message",
              onTap: _sendEmail,
              isPrimary: true,
              isLoading: _isLoading,
            ),
          ),
        ],
      ),
    );
  }
}

class ContactField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final int maxLines;
  final TextEditingController controller;
  final bool isDark;

  const ContactField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    required this.controller,
    required this.isDark,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 13.sp,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white70 : Colors.black87,
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: GoogleFonts.outfit(
            fontSize: 13.sp,
            color: isDark ? Colors.white : Colors.black87,
          ),
          decoration: InputDecoration(
            prefixIcon: maxLines == 1
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Icon(icon, size: 14.sp, color: AppTheme.primaryColor),
                  )
                : null,
            prefixIconConstraints: BoxConstraints(minWidth: 40.w),
            hintText: hint,
            hintStyle: GoogleFonts.outfit(
              fontSize: 12.sp,
              color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.35),
            ),
            filled: true,
            fillColor: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.04),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: BorderSide(
                color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.08),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: BorderSide(
                color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.08),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: const BorderSide(color: AppTheme.primaryColor, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
