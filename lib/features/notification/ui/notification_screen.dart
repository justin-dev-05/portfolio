import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdi_dost/core/constants/app_colors.dart';
import 'package:pdi_dost/core/widgets/common_scaffold.dart';
import 'package:pdi_dost/core/widgets/shimmer_widgets.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: "Notifications",
      body: _isLoading ? const NotificationShimmer() : _buildNotificationList(),
    );
  }

  Widget _buildNotificationList() {
    final notifications = [
      {
        "title": "New Inspection Assigned",
        "description":
            "A new car inspection for Honda City has been assigned to you.",
        "time": "2 mins ago",
        "type": "assignment",
        "isRead": false,
      },
      {
        "title": "Inspection Approved",
        "description":
            "Your report for Toyota Fortuner (GJ01XX1234) has been approved.",
        "time": "1 hour ago",
        "type": "approval",
        "isRead": true,
      },
      {
        "title": "System Update",
        "description":
            "PDI Dost version 1.0.1 is now available with new features.",
        "time": "5 hours ago",
        "type": "system",
        "isRead": true,
      },
      {
        "title": "New Message",
        "description":
            "Administrator sent you a message regarding the recent report.",
        "time": "Yesterday",
        "type": "message",
        "isRead": true,
      },
    ];

    return ListView.builder(
      itemCount: notifications.length,
      padding: EdgeInsets.all(16.r),
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return FadeInUp(
          delay: Duration(milliseconds: index * 100),
          child: _NotificationItem(
            title: notification["title"] as String,
            description: notification["description"] as String,
            time: notification["time"] as String,
            type: notification["type"] as String,
            isRead: notification["isRead"] as bool,
          ),
        );
      },
    );
  }
}

class _NotificationItem extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final String type;
  final bool isRead;

  const _NotificationItem({
    required this.title,
    required this.description,
    required this.time,
    required this.type,
    required this.isRead,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    IconData getIcon() {
      switch (type) {
        case 'assignment':
          return Icons.assignment_rounded;
        case 'approval':
          return Icons.check_circle_rounded;
        case 'system':
          return Icons.system_update_rounded;
        default:
          return Icons.notifications_rounded;
      }
    }

    Color getIconColor() {
      switch (type) {
        case 'assignment':
          return Colors.blue;
        case 'approval':
          return Colors.green;
        case 'system':
          return Colors.orange;
        default:
          return AppColors.primaryLight;
      }
    }

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: isRead
              ? Colors.transparent
              : AppColors.primaryLight.withValues(alpha: 0.3),
          width: 1,
        ),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: getIconColor().withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(getIcon(), color: getIconColor(), size: 24.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: isRead
                              ? FontWeight.w600
                              : FontWeight.w800,
                          color: isDark
                              ? Colors.white
                              : AppColors.backgroundDark,
                        ),
                      ),
                    ),
                    if (!isRead)
                      Container(
                        width: 8.r,
                        height: 8.r,
                        decoration: const BoxDecoration(
                          color: AppColors.primaryLight,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: isDark ? Colors.white70 : Colors.grey[600],
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
