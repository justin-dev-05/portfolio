import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_portfolio/core/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/modern_cta.dart';
import '../blocs/portfolio_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/responsive.dart';

import 'package:url_launcher/url_launcher.dart';

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

    // Simulate a network delay (actual sending would happen through a backend API)
    await Future.delayed(const Duration(seconds: 2));

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

      // Show success message and clear form
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Email client opened! Thank you for your message."),
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
          const SnackBar(content: Text("Could not launch email app")),
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
    return BlocBuilder<PortfolioBloc, PortfolioState>(
        builder: (context, state) {
      return Container(
        width: double.infinity,
        color:
            state.isDark ? AppTheme.backgroundColor : const Color(0xFFF1F5F9),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24.w : 100,
            vertical: (isMobile ? 30 : 10).h,
          ),
          child: Column(
            children: [
              ShaderMask(
                shaderCallback: (bounds) =>
                    AppTheme.primaryGradient.createShader(bounds),
                child: Text(
                  "GET IN TOUCH",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    fontSize: (isMobile ? 32 : 54).sp,
                    fontWeight: FontWeight.bold,
                    color: state.isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ).animate().fadeIn(),
              SizedBox(height: 16.h),
              Text(
                "Have a project in mind? Let's build something extraordinary together.",
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: (isMobile ? 16 : 20).sp,
                  color: state.isDark ? Colors.white70 : Colors.black54,
                ),
              ).animate().fadeIn(delay: 200.ms),
              SizedBox(height: 40.h),

              // Form Container
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 800.w),
                child: Container(
                  padding: EdgeInsets.all(isMobile ? 24.w : 48.w),
                  decoration: BoxDecoration(
                    color: (state.isDark ? AppTheme.surfaceColor : Colors.white)
                        .withValues(alpha: state.isDark ? 0.5 : 1.0),
                    borderRadius: BorderRadius.circular(32.r),
                    border: Border.all(
                        color: (state.isDark ? Colors.white : Colors.black)
                            .withValues(alpha: 0.05)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                            .withValues(alpha: state.isDark ? 0.2 : 0.05),
                        blurRadius: 50,
                        offset: const Offset(0, 20),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      ContactField(
                        label: "Name",
                        hint: "Justin Mahida",
                        controller: _nameController,
                      ),
                      SizedBox(height: 24.h),
                      ContactField(
                        label: "Email",
                        hint: "hello@justin.dev",
                        controller: _emailController,
                      ),
                      SizedBox(height: 24.h),
                      ContactField(
                        label: "Phone Number (Optional)",
                        hint: "+1 234 567 8900",
                        controller: _phoneController,
                      ),
                      SizedBox(height: 24.h),
                      ContactField(
                        label: "Message",
                        hint: "Tell me about your project...",
                        maxLines: 5,
                        controller: _messageController,
                      ),
                      SizedBox(height: 48.h),
                      ModernCTA(
                        label: "Send Message",
                        onTap: _sendEmail,
                        isPrimary: true,
                        isLoading: _isLoading,
                      ),
                    ],
                  ),
                ),
              ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),
            ],
          ),
        ),
      );
    });
  }
}

class ContactField extends StatelessWidget {
  final String label;
  final String hint;
  final int maxLines;
  final TextEditingController controller;

  const ContactField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PortfolioBloc, PortfolioState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: state.isDark ? Colors.white : Colors.black87,
              ),
            ),
            SizedBox(height: 8.h),
            TextField(
              controller: controller,
              maxLines: maxLines,
              style: TextStyle(
                  color: state.isDark ? Colors.white : Colors.black87),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                    color: (state.isDark ? Colors.white : Colors.black)
                        .withValues(alpha: 0.3)),
                filled: true,
                fillColor: (state.isDark ? Colors.white : Colors.black)
                    .withValues(alpha: 0.05),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: state.isDark
                      ? BorderSide.none
                      : BorderSide(color: Colors.black.withValues(alpha: 0.05)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: state.isDark
                      ? BorderSide.none
                      : BorderSide(color: Colors.black.withValues(alpha: 0.05)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(color: AppTheme.primaryColor, width: 2),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
