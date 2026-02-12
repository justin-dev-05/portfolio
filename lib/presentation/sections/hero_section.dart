import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_portfolio/core/constants/portfolio_data.dart';
import 'package:flutter_portfolio/core/responsive/responsive_utils.dart';
import 'package:flutter_portfolio/core/theme/app_theme.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Responsive.sectionHeight(context),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.surface,
            AppTheme.primaryColor.withValues(alpha: 0.05),
          ],
        ),
      ),
      child: ResponsiveBuilder(
        mobile: _buildMobileLayout(context),
        tablet: _buildTabletLayout(context),
        desktop: _buildDesktopLayout(context),
        largeDesktop: _buildLargeDesktopLayout(context),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return ResponsiveContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildAvatar(context, size: 140),
          const SizedBox(height: 32),
          _buildGreeting(context),
          const SizedBox(height: 16),
          _buildName(context, fontSize: 36),
          const SizedBox(height: 16),
          _buildAnimatedTitle(context, fontSize: 20),
          const SizedBox(height: 24),
          _buildDescription(context),
          const SizedBox(height: 32),
          _buildCTAButtons(context, isVertical: true),
          const SizedBox(height: 32),
          _buildSocialLinks(context),
        ],
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return ResponsiveContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildAvatar(context, size: 160),
          const SizedBox(height: 40),
          _buildGreeting(context),
          const SizedBox(height: 16),
          _buildName(context, fontSize: 48),
          const SizedBox(height: 16),
          _buildAnimatedTitle(context, fontSize: 24),
          const SizedBox(height: 24),
          _buildDescription(context, maxWidth: 500),
          const SizedBox(height: 40),
          _buildCTAButtons(context),
          const SizedBox(height: 40),
          _buildSocialLinks(context),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return ResponsiveContainer(
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildGreeting(context),
                const SizedBox(height: 16),
                _buildName(context, fontSize: 56),
                const SizedBox(height: 16),
                _buildAnimatedTitle(context, fontSize: 28),
                const SizedBox(height: 24),
                _buildDescription(context, maxWidth: 500),
                const SizedBox(height: 40),
                _buildCTAButtons(context),
                const SizedBox(height: 40),
                _buildSocialLinks(context),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: _buildAvatar(context, size: 280),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLargeDesktopLayout(BuildContext context) {
    return ResponsiveContainer(
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildGreeting(context),
                const SizedBox(height: 20),
                _buildName(context, fontSize: 72),
                const SizedBox(height: 20),
                _buildAnimatedTitle(context, fontSize: 32),
                const SizedBox(height: 32),
                _buildDescription(context, maxWidth: 600),
                const SizedBox(height: 48),
                _buildCTAButtons(context),
                const SizedBox(height: 48),
                _buildSocialLinks(context),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: _buildAvatar(context, size: 350),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(BuildContext context, {required double size}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(size * 0.2),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withValues(alpha: 0.3),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Center(
        child: Text(
          'JM',
          style: TextStyle(
            fontSize: size * 0.4,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 800.ms)
        .scale(begin: const Offset(0.8, 0.8), duration: 800.ms);
  }

  Widget _buildGreeting(BuildContext context) {
    return Text(
      'Hello, I\'m',
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppTheme.primaryColor,
            fontWeight: FontWeight.w600,
          ),
    )
        .animate()
        .fadeIn(duration: 600.ms, delay: 200.ms)
        .slideX(begin: -0.2, end: 0);
  }

  Widget _buildName(BuildContext context, {required double fontSize}) {
    return Text(
      PortfolioData.name,
      style: Theme.of(context).textTheme.displaySmall?.copyWith(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
      textAlign: TextAlign.center,
    )
        .animate()
        .fadeIn(duration: 800.ms, delay: 400.ms)
        .slideY(begin: 0.2, end: 0);
  }

  Widget _buildAnimatedTitle(BuildContext context, {required double fontSize}) {
    return AnimatedTextKit(
      animatedTexts: [
        TypewriterAnimatedText(
          'App Developer',
          textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontSize: fontSize,
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.7),
              ),
          speed: const Duration(milliseconds: 100),
        ),
        TypewriterAnimatedText(
          'Mobile App Developer',
          textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontSize: fontSize,
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.7),
              ),
          speed: const Duration(milliseconds: 100),
        ),
        TypewriterAnimatedText(
          'UI/UX Enthusiast',
          textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontSize: fontSize,
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.7),
              ),
          speed: const Duration(milliseconds: 100),
        ),
      ],
      repeatForever: true,
      pause: const Duration(seconds: 2),
    );
  }

  Widget _buildDescription(BuildContext context, {double? maxWidth}) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth ?? double.infinity),
      child: Text(
        PortfolioData.tagline,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.7),
            ),
        textAlign: maxWidth != null ? TextAlign.left : TextAlign.center,
      ),
    )
        .animate()
        .fadeIn(duration: 800.ms, delay: 600.ms)
        .slideY(begin: 0.2, end: 0);
  }

  Widget _buildCTAButtons(BuildContext context, {bool isVertical = false}) {
    final buttons = [
      ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.work_outline),
        label: const Text('View My Work'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        ),
      ),
      const SizedBox(width: 16, height: 16),
      OutlinedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.download),
        label: const Text('Download CV'),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        ),
      ),
    ];

    return isVertical
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: buttons,
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: buttons,
          )
            .animate()
            .fadeIn(duration: 800.ms, delay: 800.ms)
            .slideY(begin: 0.2, end: 0);
  }

  Widget _buildSocialLinks(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _SocialButton(
          icon: FontAwesomeIcons.github,
          url: PortfolioData.socialLinks['github']!,
        ),
        const SizedBox(width: 16),
        _SocialButton(
          icon: FontAwesomeIcons.linkedin,
          url: PortfolioData.socialLinks['linkedin']!,
        ),
        const SizedBox(width: 16),
        _SocialButton(
          icon: FontAwesomeIcons.twitter,
          url: PortfolioData.socialLinks['twitter']!,
        ),
        const SizedBox(width: 16),
        _SocialButton(
          icon: FontAwesomeIcons.dribbble,
          url: PortfolioData.socialLinks['dribbble']!,
        ),
      ],
    )
        .animate()
        .fadeIn(duration: 800.ms, delay: 1000.ms)
        .slideY(begin: 0.2, end: 0);
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String url;

  const _SocialButton({
    required this.icon,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).dividerTheme.color ?? Colors.transparent,
          ),
        ),
        child: FaIcon(
          icon,
          size: 20,
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
        ),
      ),
    );
  }
}
