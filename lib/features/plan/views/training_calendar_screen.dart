import 'package:evencir_pulse_app/core/utils/app_colors.dart';
import 'package:evencir_pulse_app/core/utils/app_style.dart';
import 'package:evencir_pulse_app/features/plan/components/week_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/training_controller.dart';

class TrainingCalendarScreen extends GetView<TrainingController> {
  const TrainingCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Text('Training Calendar ',
                    style: AppStyle.mulishTextStyle(
                        fontSize: 24, fontWeight: FontWeight.w400)),
                const Spacer(),
                Obx(() => controller.isLoading.value
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.kWhiteColor,
                        ),
                      )
                    : TextButton(
                        onPressed: () async {
                          FocusScope.of(context).unfocus();

                          await Future.delayed(
                              const Duration(milliseconds: 100));
                          controller.saveAllToFirebase();
                        },
                        child: Text('Save',
                            style: AppStyle.mulishTextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700)),
                      )),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              return ListView.builder(
                controller: controller.scrollController,
                itemCount: controller.weeks.length,
                itemBuilder: (context, index) {
                  final week = controller.weeks[index];
                  return WeekSection(
                    week: week,
                    targetDate: controller.targetDate.value,
                    onMoveWorkout: controller.moveWorkout,
                    onAddWorkout: controller.addWorkoutToDay,
                    onUpdateWorkout: controller.updateWorkoutInDay,
                    onUpdateDurationPart: controller.updateWorkoutDurationPart,
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
