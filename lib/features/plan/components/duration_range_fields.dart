import 'package:flutter/material.dart';
import 'package:evencir_pulse_app/core/utils/app_colors.dart';
import 'package:evencir_pulse_app/core/utils/app_style.dart';
import 'package:evencir_pulse_app/features/plan/views/ediable_text_field.dart';
import 'package:evencir_pulse_app/models/workout_model.dart';

class DurationRangeFields extends StatelessWidget {
  final Workout workout;
  final DateTime date;
  final Function(String? start, String? end) onSave;

  const DurationRangeFields({
    super.key,
    required this.workout,
    required this.date,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    String startTime = "00m";
    String endTime = "00m";
    if (workout.duration.contains('-')) {
      var parts = workout.duration.split('-');
      startTime = parts[0].trim();
      if (parts.length > 1) {
        endTime = parts[1].trim();
      }
    } else {
      startTime = workout.duration.trim();
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IntrinsicWidth(
          child: EditableTextField(
            key: Key('start-${date.toIso8601String()}'),
            initialValue: startTime,
            onSave: (val) => onSave(val, null),
            isDuration: true,
          ),
        ),
        Text(' - ',
            style: AppStyle.mulishTextStyle(
                c: AppColors.kOffWhiteColor,
                fontSize: 14,
                fontWeight: FontWeight.w400)),
        IntrinsicWidth(
          child: EditableTextField(
            key: Key('end-${date.toIso8601String()}'),
            initialValue: endTime,
            onSave: (val) => onSave(null, val),
            isDuration: true,
          ),
        ),
      ],
    );
  }
}
