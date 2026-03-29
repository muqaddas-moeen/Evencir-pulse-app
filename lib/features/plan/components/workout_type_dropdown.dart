import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:evencir_pulse_app/core/utils/app_colors.dart';
import 'package:evencir_pulse_app/core/utils/app_style.dart';
import 'package:evencir_pulse_app/core/utils/image_strings.dart';
import 'package:evencir_pulse_app/models/workout_model.dart';

class WorkoutTypeDropdown extends StatelessWidget {
  final Workout workout;
  final DateTime date;
  final Function(String) onChanged;

  const WorkoutTypeDropdown({
    super.key,
    required this.workout,
    required this.date,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const workoutTypes = ['Arms Workout', 'Legs Workout'];
    const workoutIcons = [armWorkoutIcon, legWorkoutIcon];

    String safeType =
        workoutTypes.contains(workout.type) ? workout.type : workoutTypes.first;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: safeType == 'Arms Workout'
            ? AppColors.kGreen2Color.withOpacity(0.17)
            : AppColors.kBlueColor.withOpacity(0.17),
        borderRadius: BorderRadius.circular(3.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isDense: true,
          padding: EdgeInsets.zero,
          value: safeType,
          icon: const SizedBox.shrink(),
          style: AppStyle.mulishTextStyle(
              fontSize: 10,
              c: safeType == 'Arms Workout'
                  ? AppColors.kGreen2Color
                  : AppColors.kBlueColor,
              fontWeight: FontWeight.w600),
          dropdownColor: AppColors.kBlack3Color,
          items: workoutTypes.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(workoutIcons[workoutTypes.indexOf(value)],
                      width: 10.w, height: 10.h),
                  SizedBox(width: 5.w),
                  Text(
                    value,
                    style: AppStyle.mulishTextStyle(
                        c: value == 'Arms Workout'
                            ? AppColors.kGreen2Color
                            : AppColors.kBlueColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (newValue) {
            if (newValue != null) {
              onChanged(newValue);
            }
          },
        ),
      ),
    );
  }
}
