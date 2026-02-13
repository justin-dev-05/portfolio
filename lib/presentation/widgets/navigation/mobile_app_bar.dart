import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portfolio/core/constants/portfolio_data.dart';
import 'package:flutter_portfolio/core/theme/app_theme.dart';
import 'package:flutter_portfolio/presentation/blocs/navigation/navigation_bloc.dart';

class MobileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MobileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        PortfolioData.name,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      actions: [
        BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            return IconButton(
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Icon(
                  state.isMobileMenuOpen ? Icons.close : Icons.menu,
                  key: ValueKey<bool>(state.isMobileMenuOpen),
                ),
              ),
              onPressed: () {
                context
                    .read<NavigationBloc>()
                    .add(const ToggleMobileMenuEvent());
              },
            );
          },
        ),
        const SizedBox(width: 8),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: state.isMobileMenuOpen ? 240 : 0,
              child: state.isMobileMenuOpen
                  ? Container(
                      color: Theme.of(context).colorScheme.surface,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 8),
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
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                            selected: isSelected,
                            onTap: () {
                              context
                                  .read<NavigationBloc>()
                                  .add(NavigateToSectionEvent(index));
                            },
                          );
                        },
                      ),
                    )
                  : const SizedBox.shrink(),
            );
          },
        ),
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

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1);
}
