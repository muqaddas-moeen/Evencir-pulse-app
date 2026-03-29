import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:evencir_pulse_app/core/utils/app_colors.dart';
import 'package:evencir_pulse_app/core/utils/app_style.dart';
import 'package:evencir_pulse_app/features/plan/models/training_models.dart';
import 'package:evencir_pulse_app/features/plan/components/workout_card.dart';
import 'package:evencir_pulse_app/models/workout_model.dart';

class DayRow extends StatelessWidget {
  final TrainingDay trainingDay;
  final DateTime? targetDate;
  final Function(Workout, DateTime, DateTime) onMoveWorkout;
  final Function(DateTime) onAddWorkout;
  final Function(DateTime, {String? type, String? title, String? duration}) onUpdateWorkout;
  final Function(DateTime, {String? start, String? end}) onUpdateDurationPart;

  const DayRow({
    super.key,
    required this.trainingDay,
    this.targetDate,
    required this.onMoveWorkout,
    required this.onAddWorkout,
    required this.onUpdateWorkout,
    required this.onUpdateDurationPart,
  });

  @override
  Widget build(BuildContext context) {
    final workout = trainingDay.workout;
    final dayName = DateFormat('E').format(trainingDay.date);
    final dayNum = DateFormat('d').format(trainingDay.date);

    return DragTarget<Map<String, dynamic>>(
      onWillAccept: (data) =>
          data != null && data['date'] != trainingDay.date && workout == null,
      onAccept: (data) {
        onMoveWorkout(data['workout'], data['date'], trainingDay.date);
      },
      builder: (context, candidateData, rejectedData) {
        bool isHovered = candidateData.isNotEmpty;
        bool isTargeted = targetDate != null && isSameDay(targetDate!, trainingDay.date);

        return Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isTargeted ? AppColors.kGreenColor : AppColors.kGreyColor,
                width: isTargeted ? 2.w : 1.w,
              ),
            ),
            color: isHovered
                ? AppColors.kBlueColor.withOpacity(0.1)
                : (isTargeted ? AppColors.kGreenColor.withOpacity(0.05) : null),
          ),
          padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 8.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 40.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(dayName,
                        style: AppStyle.mulishTextStyle(
                            c: workout == null && !isTargeted
                                ? AppColors.kGreyColor
                                : AppColors.kOffWhiteColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w700)),
                    SizedBox(height: 10.h),
                    Text(dayNum,
                        style: AppStyle.mulishTextStyle(
                            c: workout == null && !isTargeted
                                ? AppColors.kGreyColor
                                : AppColors.kOffWhiteColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: workout == null
                    ? GestureDetector(
                        onTap: () => onAddWorkout(trainingDay.date),
                        child: SizedBox(
                          height: 50.h,
                          child: Icon(Icons.add,
                              color: AppColors.kDarkGreyColor.withOpacity(0.5)),
                        ),
                      )
                    : LongPressDraggable<Map<String, dynamic>>(
                        delay: const Duration(milliseconds: 200),
                        data: {'workout': workout, 'date': trainingDay.date},
                        feedback: Material(
                          color: Colors.transparent,
                          child: SizedBox(
                            width: Get.width - 100.w,
                            child: WorkoutCard(
                              workout: workout,
                              date: trainingDay.date,
                              isFeedback: true,
                              onUpdate: (type, title, duration) => onUpdateWorkout(trainingDay.date, type: type, title: title, duration: duration),
                              onUpdateDurationPart: (start, end) => onUpdateDurationPart(trainingDay.date, start: start, end: end),
                            ),
                          ),
                        ),
                        childWhenDragging: Opacity(
                          opacity: 0.3,
                          child: WorkoutCard(
                            workout: workout,
                            date: trainingDay.date,
                            onUpdate: (type, title, duration) => onUpdateWorkout(trainingDay.date, type: type, title: title, duration: duration),
                            onUpdateDurationPart: (start, end) => onUpdateDurationPart(trainingDay.date, start: start, end: end),
                          ),
                        ),
                        child: WorkoutCard(
                          workout: workout,
                          date: trainingDay.date,
                          onUpdate: (type, title, duration) => onUpdateWorkout(trainingDay.date, type: type, title: title, duration: duration),
                          onUpdateDurationPart: (start, end) => onUpdateDurationPart(trainingDay.date, start: start, end: end),
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
