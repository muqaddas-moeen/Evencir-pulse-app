import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/nutritions_controller.dart';
import '../components/nutrition_top_bar.dart';
import '../components/nutrition_header.dart';
import '../components/nutrition_calendar.dart';
import '../components/nutrition_workouts.dart';
import '../components/nutrition_insights.dart';
import '../components/nutrition_hydration.dart';

class NutritionsScreen extends GetView<NutritionsController> {
  const NutritionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NutritionTopBar(controller: controller),
            SizedBox(height: 24.h),
            NutritionHeader(controller: controller),
            SizedBox(height: 16.h),
            NutritionCalendar(controller: controller),
            SizedBox(height: 24.h),
            NutritionWorkouts(controller: controller),
            SizedBox(height: 24.h),
            NutritionInsights(controller: controller),
            SizedBox(height: 10.h),
            NutritionHydration(controller: controller),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
