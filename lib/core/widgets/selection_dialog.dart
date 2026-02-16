import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdi_dost/core/constants/app_colors.dart';
import 'package:pdi_dost/core/widgets/app_text_field.dart';

class SelectionDialog extends StatefulWidget {
  final String title;
  final List<String> items;
  final String? selectedItem;
  final Function(String) onSelected;

  const SelectionDialog({
    super.key,
    required this.title,
    required this.items,
    this.selectedItem,
    required this.onSelected,
  });

  @override
  State<SelectionDialog> createState() => _SelectionDialogState();

  static Future<String?> show(
    BuildContext context, {
    required String title,
    required List<String> items,
    String? selectedItem,
  }) {
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SelectionDialog(
        title: title,
        items: items,
        selectedItem: selectedItem,
        onSelected: (value) => Navigator.pop(context, value),
      ),
    );
  }
}

class _SelectionDialogState extends State<SelectionDialog> {
  late List<String> _filteredItems;
  final _searchController = TextEditingController();
  final _searchFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      _filteredItems = widget.items
          .where(
            (item) => item.toLowerCase().contains(
              _searchController.text.toLowerCase(),
            ),
          )
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      height: 0.75.sh,
      decoration: BoxDecoration(
        color: isDark ? AppColors.backgroundDark : Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 13.h),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
            ),
            child: Row(
              children: [
                // const SizedBox(
                //   width: 40,
                // ),
                Expanded(
                  child: Text(
                    'Select ${widget.title}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close_rounded,
                      size: 20.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15.h),
          // Search
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: AppTextField(
              controller: _searchController,
              focusNode: _searchFocus,
              hint: 'Search ${widget.title.toLowerCase()}...',
              variant: FieldVariant.search,
              prefix: Icon(
                Icons.search_rounded,
                color: isDark ? Colors.white38 : Colors.grey.shade400,
                size: 24.sp,
              ),
              suffix: _searchController.text.isNotEmpty
                  ? GestureDetector(
                      onTap: () {
                        _searchController.clear();
                        setState(() {
                          _filteredItems = widget.items;
                        });
                      },
                      child: Icon(
                        Icons.cancel_rounded,
                        color: isDark ? Colors.white38 : Colors.black,
                        size: 25.sp,
                      ),
                    )
                  : null,
            ),
          ),
          SizedBox(height: 15.h),

          // List
          Expanded(
            child: _filteredItems.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off_rounded,
                          size: 64.sp,
                          color: isDark
                              ? Colors.white10
                              : Colors.grey.withValues(alpha: 0.1),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'No items found',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: isDark
                                ? Colors.white38
                                : Colors.grey.shade400,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.only(
                      left: 20.w,
                      right: 20.w,
                      bottom: 32.h,
                    ),
                    physics: const BouncingScrollPhysics(),
                    itemCount: _filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = _filteredItems[index];
                      final isSelected = item == widget.selectedItem;

                      return GestureDetector(
                        onTap: () => widget.onSelected(item),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: EdgeInsets.only(bottom: 12.h),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 18.h,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primaryLight.withValues(alpha: 0.08)
                                : isDark
                                ? Colors.white.withValues(alpha: 0.03)
                                : Colors.grey.withValues(alpha: 0.03),
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primaryLight.withValues(
                                      alpha: 0.3,
                                    )
                                  : Colors.transparent,
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: isSelected
                                        ? AppColors.primaryLight
                                        : (isDark
                                              ? Colors.white.withValues(
                                                  alpha: 0.8,
                                                )
                                              : AppColors.textPrimaryLight),
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                                  ),
                                ),
                              ),
                              if (isSelected)
                                Icon(
                                  Icons.check_circle_rounded,
                                  color: AppColors.primaryLight,
                                  size: 20.sp,
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
