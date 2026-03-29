import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:evencir_pulse_app/core/utils/app_colors.dart';
import 'package:evencir_pulse_app/core/utils/image_strings.dart';
import 'package:evencir_pulse_app/models/workout_model.dart';
import 'package:evencir_pulse_app/theme/app_theme.dart';
import 'package:evencir_pulse_app/features/plan/components/workout_type_dropdown.dart';
import 'package:evencir_pulse_app/features/plan/components/duration_range_fields.dart';
import 'package:evencir_pulse_app/features/plan/views/ediable_text_field.dart';

class WorkoutCard extends StatelessWidget {
  final Workout workout;
  final DateTime date;
  final bool isFeedback;
  final Function(String? type, String? title, String? duration) onUpdate;
  final Function(String? start, String? end) onUpdateDurationPart;

  const WorkoutCard({
    super.key,
    required this.workout,
    required this.date,
    this.isFeedback = false,
    required this.onUpdate,
    required this.onUpdateDurationPart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: AppColors.kBlack3Color,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: isFeedback
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                  )
                ]
              : null,
          border: Border(
            left: BorderSide(
              color: workout.isCompleted
                  ? AppTheme.primaryColor
                  : AppColors.kWhiteColor,
              width: 7.w,
            ),
          )),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: SvgPicture.asset(dragIcon, width: 15.w, height: 15.h),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WorkoutTypeDropdown(
                  workout: workout,
                  date: date,
                  onChanged: (val) => onUpdate(val, null, null),
                ),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    Expanded(
                      child: EditableTextField(
                        key: Key('title-${date.toIso8601String()}'),
                        initialValue: workout.title,
                        onSave: (val) => onUpdate(null, val, null),
                      ),
                    ),
                    SizedBox(width: 5.w),
                    DurationRangeFields(
                      workout: workout,
                      date: date,
                      onSave: onUpdateDurationPart,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
