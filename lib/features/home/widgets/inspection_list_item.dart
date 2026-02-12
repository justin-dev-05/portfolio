import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../data/models/inspection_model.dart';

class InspectionListItem extends StatelessWidget {
  final InspectionModel inspection;

  const InspectionListItem({super.key, required this.inspection});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (inspection.status.toLowerCase()) {
      case 'completed':
        statusColor = Colors.green;
        break;
      case 'pending':
        statusColor = Theme.of(context).colorScheme.secondary;
        break;
      case 'upcoming':
        statusColor = Colors.blue;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Left status bar
              Container(width: 6.w, color: statusColor),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              inspection.vehicleModel,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Text(
                              inspection.status.toUpperCase(),
                              style: TextStyle(
                                color: statusColor,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "${inspection.inspectionType} • ${inspection.vehicleNumber}",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      _buildInfoRow(Icons.person_outline, inspection.customerName),
                      SizedBox(height: 4.h),
                      _buildInfoRow(Icons.location_on_outlined, inspection.address),
                      SizedBox(height: 4.h),
                      _buildInfoRow(
                        Icons.calendar_month_outlined,
                        inspection.date,
                        phone: inspection.phone,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, {String? phone}) {
    return Row(
      children: [
        Icon(icon, size: 16.sp, color: Colors.grey),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 13.sp, color: Colors.grey[700]),
          ),
        ),
        if (phone != null) ...[
          Container(
            height: 4.h,
            width: 4.w,
            decoration:
                const BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
          ),
          SizedBox(width: 8.w),
          Icon(Icons.phone_outlined, size: 14.sp, color: Colors.grey),
          SizedBox(width: 4.w),
          Text(
            phone,
            style: TextStyle(fontSize: 13.sp, color: Colors.grey[700]),
          ),
        ],
      ],
    );
  }
}
