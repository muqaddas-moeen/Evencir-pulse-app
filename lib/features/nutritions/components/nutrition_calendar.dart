import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_style.dart';
import '../controllers/nutritions_controller.dart';

class NutritionCalendar extends StatelessWidget {
  final NutritionsController controller;

  const NutritionCalendar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => TableCalendar(
              focusedDay: controller.selectedDate.value,
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              calendarFormat: CalendarFormat.week,
              headerVisible: false,
              selectedDayPredicate: (day) =>
                  isSameDay(controller.selectedDate.value, day),
              onDaySelected: (selectedDay, focusedDay) {
                controller.updateSelectedDate(selectedDay);
              },
              calendarStyle: CalendarStyle(
                isTodayHighlighted: true,
                selectedDecoration: BoxDecoration(
                  border: Border.all(color: AppColors.kGreenColor),
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  shape: BoxShape.circle,
                ),
                defaultTextStyle: AppStyle.mulishTextStyle(
                    fontSize: 14, fontWeight: FontWeight.w700),
                weekendTextStyle: AppStyle.mulishTextStyle(
                    fontSize: 14, fontWeight: FontWeight.w700),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: AppStyle.mulishTextStyle(
                    fontSize: 14, fontWeight: FontWeight.w700),
                weekendStyle: AppStyle.mulishTextStyle(
                    fontSize: 14, fontWeight: FontWeight.w700),
              ),
            )),
        const SizedBox(height: 8),
        Center(
          child: Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ],
    );
  }
}
