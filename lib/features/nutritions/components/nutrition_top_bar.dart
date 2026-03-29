import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_style.dart';
import '../../../../core/utils/image_strings.dart';
import '../../../core/utils/theme/app_theme.dart';
import '../controllers/nutritions_controller.dart';

class NutritionTopBar extends StatelessWidget {
  final NutritionsController controller;

  const NutritionTopBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(notificationIcon, width: 24.w, height: 24.h),
        GestureDetector(
          onTap: () => _showCalendarBottomSheet(context),
          child: Row(
            children: [
              SvgPicture.asset(headerIcon, width: 20.w, height: 20.h),
              SizedBox(width: 5.w),
              Obx(() => Text(
                    controller.currentWeekText,
                    style: AppStyle.mulishTextStyle(
                        fontWeight: FontWeight.w400, fontSize: 14),
                  )),
              const Icon(Icons.arrow_drop_down, color: Colors.grey),
            ],
          ),
        ),
        const SizedBox(width: 24),
      ],
    );
  }

  void _showCalendarBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        height: 450,
        decoration: const BoxDecoration(
          color: AppTheme.cardBackgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Obx(() => TableCalendar(
                  focusedDay: controller.selectedDate.value,
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  selectedDayPredicate: (day) =>
                      isSameDay(controller.selectedDate.value, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    controller.updateSelectedDate(selectedDay);
                    Get.back();
                  },
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  calendarStyle: CalendarStyle(
                    isTodayHighlighted: true,
                    selectedDecoration: const BoxDecoration(
                      color: AppColors.kGreenColor,
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: AppColors.kGreenColor.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                  ),
                )),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}
