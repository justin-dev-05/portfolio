import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdi_dost/core/constants/app_strings.dart';
import 'package:pdi_dost/core/widgets/common_scaffold.dart';
import 'package:pdi_dost/features/auth/bloc/auth/auth_bloc.dart';
import 'package:pdi_dost/features/dashboard/bloc/bottom_nav/bottom_nav_bloc.dart';
import '../bloc/home/home_bloc.dart';
import 'widgets/inspection_list_item.dart';
import 'package:pdi_dost/core/widgets/toolbar.dart';
import 'package:pdi_dost/core/widgets/shimmer_widgets.dart';
import 'package:pdi_dost/features/notification/ui/notification_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(FetchHomeData());
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<HomeBloc>().add(LoadMoreInspections());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      showAppBar: false,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return const HomeShimmer();
                }

                if (state is HomeLoaded) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<HomeBloc>().add(FetchHomeData());
                    },
                    child: CustomScrollView(
                      controller: _scrollController,
                      slivers: [
                        SliverToBoxAdapter(child: _buildSummaryCards()),
                        SliverPadding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 8.h,
                          ),
                          sliver: SliverToBoxAdapter(
                            child: Text(
                              AppStrings.recentInspections,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              if (index < state.inspections.length) {
                                return InspectionListItem(
                                  inspection: state.inspections[index],
                                );
                              } else {
                                return Padding(
                                  padding: EdgeInsets.all(16.r),
                                  child: const AppShimmer(
                                    child: ShimmerContainer(
                                      height: 100,
                                      borderRadius: 24,
                                    ),
                                  ),
                                );
                              }
                            },
                            childCount:
                                state.inspections.length +
                                (state is HomePaginationLoading ? 1 : 0),
                          ),
                        ),
                        SliverToBoxAdapter(child: SizedBox(height: 20.h)),
                      ],
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        String name = "User";
        if (state is AuthAuthenticated) {
          name = state.username.isNotEmpty ? state.username : "User Name";
        }

        return Toolbar.homeHeader(
          context,
          name: name,
          notificationCount: 3,
          onProfileTap: () {
            context.read<BottomNavBloc>().add(const TabChangedEvent(3));
          },
          onNotificationTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NotificationScreen(),
              ),
            );
          },
          onSearchChanged: (value) {},
        );
      },
    );
  }

  Widget _buildSummaryCards() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      child: Row(
        children: [
          _summaryCard(
            AppStrings.pending,
            "12",
            Theme.of(context).colorScheme.secondary,
          ),
          SizedBox(width: 12.w),
          _summaryCard(AppStrings.upcoming, "05", Colors.blue),
          SizedBox(width: 12.w),
          _summaryCard(AppStrings.total, "48", Colors.green),
        ],
      ),
    );
  }

  Widget _summaryCard(String title, String count, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 17.h),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: color.withValues(alpha: 0.2), width: 1.5),
        ),
        child: Column(
          children: [
            Text(
              count,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
