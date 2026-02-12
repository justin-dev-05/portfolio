import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portfolio/core/responsive/responsive_utils.dart';
import 'package:flutter_portfolio/presentation/blocs/navigation/navigation_bloc.dart';
import 'package:flutter_portfolio/presentation/sections/about_section.dart';
import 'package:flutter_portfolio/presentation/sections/contact_section.dart';
import 'package:flutter_portfolio/presentation/sections/hero_section.dart';
import 'package:flutter_portfolio/presentation/sections/projects_section.dart';
import 'package:flutter_portfolio/presentation/sections/skills_section.dart';
import 'package:flutter_portfolio/presentation/widgets/navigation/desktop_sidebar.dart';
import 'package:flutter_portfolio/presentation/widgets/navigation/mobile_app_bar.dart';
import 'package:flutter_portfolio/presentation/widgets/navigation/responsive_nav_bar.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();

  final List<Widget> _sections = const [
    HeroSection(),
    AboutSection(),
    ProjectsSection(),
    SkillsSection(),
    ContactSection(),
  ];

  @override
  void initState() {
    super.initState();
    _itemPositionsListener.itemPositions.addListener(_onScroll);
  }

  @override
  void dispose() {
    _itemPositionsListener.itemPositions.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    final positions = _itemPositionsListener.itemPositions.value;
    if (positions.isNotEmpty) {
      final visibleSection = positions
          .where((position) => position.itemLeadingEdge < 0.5)
          .toList()
        ..sort((a, b) => a.itemLeadingEdge.compareTo(b.itemLeadingEdge));

      if (visibleSection.isNotEmpty) {
        final currentIndex = visibleSection.last.index;
        context
            .read<NavigationBloc>()
            .add(UpdateCurrentSectionEvent(currentIndex));
      }
    }
  }

  void _scrollToSection(int index) {
    _itemScrollController.scrollTo(
      index: index,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NavigationBloc, NavigationState>(
      listenWhen: (previous, current) =>
          previous.selectedIndex != current.selectedIndex,
      listener: (context, state) {
        _scrollToSection(state.selectedIndex);
      },
      child: Scaffold(
        appBar: const MobileAppBar(),
        body: ResponsiveBuilder(
          // Mobile Layout
          mobile: _buildMobileLayout(),
          // Tablet Layout
          tablet: _buildTabletLayout(),
          // Desktop Layout
          desktop: _buildDesktopLayout(),
          // Large Desktop Layout
          largeDesktop: _buildLargeDesktopLayout(),
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        Expanded(
          child: _buildScrollableContent(),
        ),
      ],
    );
  }

  Widget _buildTabletLayout() {
    return Column(
      children: [
        const ResponsiveNavBar(),
        Expanded(
          child: _buildScrollableContent(),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        const DesktopSidebar(),
        Expanded(
          child: _buildScrollableContent(),
        ),
      ],
    );
  }

  Widget _buildLargeDesktopLayout() {
    return Row(
      children: [
        const DesktopSidebar(width: 300),
        Expanded(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1440),
              child: _buildScrollableContent(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildScrollableContent() {
    return ScrollablePositionedList.builder(
      shrinkWrap: true,
      itemScrollController: _itemScrollController,
      itemPositionsListener: _itemPositionsListener,
      itemCount: _sections.length,
      itemBuilder: (context, index) => _sections[index],
    );
  }
}
