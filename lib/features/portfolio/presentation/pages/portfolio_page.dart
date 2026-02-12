import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../blocs/portfolio_bloc.dart';
import '../sections/hero_section.dart';
import '../sections/projects_section.dart';
import '../sections/skills_section.dart';
import '../sections/experience_section.dart';
import '../sections/contact_section.dart';
import '../sections/footer_section.dart';
import '../widgets/nav_bar.dart';
import '../widgets/side_bar.dart';
import '../widgets/scroll_to_top_button.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();

  final List<Widget> _sections = [
    const HeroSection(),
    const ProjectsSection(),
    const SkillsSection(),
    const ExperienceSection(),
    const ContactSection(),
    const FooterSection(),
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
    if (positions.isEmpty) return;

    int? mostVisibleIndex;
    double minDistance = 1.0; // Max distance in normalized coordinates

    for (var position in positions) {
      // Preference: the section closest to the top of the viewport
      // itemLeadingEdge is 0.0 when it's exactly at the top
      double distance = position.itemLeadingEdge.abs();

      // If an item is covering a significant part of the viewport and is closer to top than current best
      if (distance < minDistance) {
        minDistance = distance;
        mostVisibleIndex = position.index;
      }
    }

    if (mostVisibleIndex != null) {
      // Map footer (index 5) or anything beyond back to Contact (index 4)
      // so the navigation highlight stays on Contact at the bottom
      final activeNavIndex = mostVisibleIndex >= 4 ? 4 : mostVisibleIndex;

      final currentActive = context.read<PortfolioBloc>().state.activeIndex;
      if (currentActive != activeNavIndex) {
        context.read<PortfolioBloc>().add(SectionChanged(activeNavIndex));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PortfolioBloc, PortfolioState>(
      listenWhen: (previous, current) => current.scrollToSectionIndex != -1,
      listener: (context, state) {
        _itemScrollController
            .scrollTo(
          index: state.scrollToSectionIndex,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutCubic,
        )
            .then((_) {
          // Add a small delay for safety before enabling SectionChanged events again
          Future.delayed(const Duration(milliseconds: 100), () {
            if (mounted) {
              context.read<PortfolioBloc>().add(ResetAutoScroll());
            }
          });
        });
      },
      child: Scaffold(
        appBar: const NavBar(),
        drawer: const SideBar(),
        body: Container(
          color: Theme.of(context).colorScheme.surface,
          child: ScrollablePositionedList.builder(
            itemCount: _sections.length,
            itemScrollController: _itemScrollController,
            itemPositionsListener: _itemPositionsListener,
            itemBuilder: (context, index) {
              return VisibilityDetector(
                key: Key('section-$index'),
                onVisibilityChanged: (info) {},
                child: _sections[index],
              );
            },
          ),
        ),
        floatingActionButton: const ScrollToTopButton(),
      ),
    );
  }
}
