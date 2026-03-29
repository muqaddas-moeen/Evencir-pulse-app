import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:evencir_pulse_app/features/plan/models/training_models.dart';
import 'package:evencir_pulse_app/features/plan/components/weekly_header.dart';
import 'package:evencir_pulse_app/features/plan/components/day_row.dart';
import 'package:evencir_pulse_app/models/workout_model.dart';

class WeekSection extends StatelessWidget {
  final TrainingWeek week;
  final DateTime? targetDate;
  final Function(Workout, DateTime, DateTime) onMoveWorkout;
  final Function(DateTime) onAddWorkout;
  final Function(DateTime, {String? type, String? title, String? duration}) onUpdateWorkout;
  final Function(DateTime, {String? start, String? end}) onUpdateDurationPart;

  const WeekSection({
    super.key,
    required this.week,
    this.targetDate,
    required this.onMoveWorkout,
    required this.onAddWorkout,
    required this.onUpdateWorkout,
    required this.onUpdateDurationPart,
  });

  @override
  Widget build(BuildContext context) {
    DateTime firstDay = week.days.first.date;
    DateTime lastDay = week.days.last.date;

    String monthName = DateFormat('MMMM').format(firstDay);
    String endMonthName = DateFormat('MMMM').format(lastDay);

    String dateRange;
    if (monthName == endMonthName) {
      dateRange = "$monthName ${firstDay.day}-${lastDay.day}";
    } else {
      dateRange = "$monthName ${firstDay.day} - $endMonthName ${lastDay.day}";
    }

    return Column(
      children: [
        WeeklyHeader(
          weekNum: week.weekNumber,
          dateRange: dateRange,
          total: week.totalDuration,
        ),
        ...week.days.map((day) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: DayRow(
                trainingDay: day,
                targetDate: targetDate,
                onMoveWorkout: onMoveWorkout,
                onAddWorkout: onAddWorkout,
                onUpdateWorkout: onUpdateWorkout,
                onUpdateDurationPart: onUpdateDurationPart,
              ),
            )),
      ],
    );
  }
}
