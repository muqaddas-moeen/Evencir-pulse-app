import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_style.dart';
import '../../../../core/utils/image_strings.dart';
import '../controllers/nutritions_controller.dart';

class NutritionWorkouts extends StatelessWidget {
  final NutritionsController controller;

  const NutritionWorkouts({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Workouts',
                style: AppStyle.mulishTextStyle(
                    fontSize: 24, fontWeight: FontWeight.w600)),
            const Spacer(),
            Obx(() {
              final isDay = controller.weatherService.isDay.value;
              final temp = controller.weatherService.temperature.value;
              return Row(
                children: [
                  SvgPicture.asset(isDay ? sunIcon : moonIcon,
                      width: 24.w, height: 24.h),
                  SizedBox(width: 5.w),
                  Text('$temp°',
                      style: AppStyle.mulishTextStyle(
                          fontSize: 24, fontWeight: FontWeight.w500)),
                ],
              );
            }),
          ],
        ),
        const SizedBox(height: 12),
        Obx(() {
          final workout = controller.dailyWorkout.value;
          if (workout == null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'No workout scheduled for this day',
                  style: AppStyle.mulishTextStyle(
                      c: AppColors.kGreyColor, fontSize: 14),
                ),
              ),
            );
          }
          return Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            decoration: BoxDecoration(
              color: AppColors.kBlack3Color,
              borderRadius: BorderRadius.circular(8.r),
              border: Border(
                left: BorderSide(
                  color: AppColors.kGreenColor,
                  width: 7.w,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${workout.date} - ${workout.duration}",
                        style: AppStyle.mulishTextStyle(
                            c: AppColors.kOffWhiteColor.withOpacity(0.7),
                            fontSize: 12,
                            fontWeight: FontWeight.w700)),
                    SizedBox(height: 8.h),
                    Text(workout.title,
                        style: AppStyle.mulishTextStyle(
                            c: AppColors.kOffWhiteColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w700)),
                  ],
                ),
                GestureDetector(
                  onTap: () => controller.navigateToWorkoutPlan(workout),
                  child: const Icon(Icons.arrow_forward,
                      size: 24, color: Colors.white),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
