import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portfolio/core/constants/portfolio_data.dart';
import 'package:flutter_portfolio/core/theme/app_theme.dart';
import 'package:flutter_portfolio/presentation/blocs/navigation/navigation_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Header
          _buildHeader(context),

          // Navigation Items
          Expanded(
            child: _buildNavigationItems(context),
          ),

          // Social Links
          _buildSocialLinks(context),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        gradient: AppTheme.primaryGradient,
      ),
      child: Column(
        children: [
          // Avatar
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: Text(
                'JM',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Name
          const Text(
            PortfolioData.name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 4),

          // Title
          Text(
            PortfolioData.title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationItems(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemCount: PortfolioData.navItems.length,
          itemBuilder: (context, index) {
            final item = PortfolioData.navItems[index];
            final isSelected = state.selectedIndex == index;

            return ListTile(
              leading: Icon(
                _getIconData(item['icon'] as String),
                color: isSelected
                    ? AppTheme.primaryColor
                    : Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.6),
              ),
              title: Text(
                item['label'] as String,
                style: TextStyle(
                  color: isSelected
                      ? AppTheme.primaryColor
                      : Theme.of(context).colorScheme.onSurface,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              selected: isSelected,
              selectedTileColor: AppTheme.primaryColor.withValues(alpha: 0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              onTap: () {
                context
                    .read<NavigationBloc>()
                    .add(NavigateToSectionEvent(index));
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }

  Widget _buildSocialLinks(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _SocialIcon(
            icon: FontAwesomeIcons.github,
            url: PortfolioData.socialLinks['github']!,
          ),
          const SizedBox(width: 16),
          _SocialIcon(
            icon: FontAwesomeIcons.linkedin,
            url: PortfolioData.socialLinks['linkedin']!,
          ),
          const SizedBox(width: 16),
          _SocialIcon(
            icon: FontAwesomeIcons.twitter,
            url: PortfolioData.socialLinks['twitter']!,
          ),
          const SizedBox(width: 16),
          _SocialIcon(
            icon: FontAwesomeIcons.dribbble,
            url: PortfolioData.socialLinks['dribbble']!,
          ),
        ],
      ),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'home':
        return Icons.home_outlined;
      case 'person':
        return Icons.person_outlined;
      case 'work':
        return Icons.work_outline;
      case 'code':
        return Icons.code_outlined;
      case 'mail':
        return Icons.mail_outline;
      default:
        return Icons.circle_outlined;
    }
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final String url;

  const _SocialIcon({
    required this.icon,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Launch URL
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Theme.of(context).dividerTheme.color ?? Colors.transparent,
          ),
        ),
        child: FaIcon(
          icon,
          size: 18,
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
        ),
      ),
    );
  }
}
