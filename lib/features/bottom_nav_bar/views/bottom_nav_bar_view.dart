import 'package:evencir_pulse_app/core/utils/app_colors.dart';
import 'package:evencir_pulse_app/core/utils/app_style.dart';
import 'package:evencir_pulse_app/core/utils/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../controllers/bottom_nav_bar_controller.dart';
import '../../nutritions/views/nutritions_screen.dart';
import '../../plan/views/training_calendar_screen.dart';
import '../../mood/views/mood_screen.dart';
import '../../profile/views/profile_screen.dart';

class BottomNavBarView extends GetView<BottomNavBarController> {
  const BottomNavBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return IndexedStack(
          index: controller.currentIndex.value,
          children: const [
            NutritionsScreen(),
            TrainingCalendarScreen(),
            MoodScreen(),
            ProfileScreen(),
          ],
        );
      }),
      bottomNavigationBar: Obx(() {
        return Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: Color(0xFF404040), width: 0.5),
            ),
          ),
          child: BottomNavigationBar(
            elevation: 0,
            currentIndex: controller.currentIndex.value,
            type: BottomNavigationBarType.fixed,
            backgroundColor: const Color(0xFF0D0D0D),
            selectedItemColor: AppColors.kWhiteColor,
            unselectedItemColor: AppColors.kGreyColor,
            selectedIconTheme:
                const IconThemeData(color: AppColors.kWhiteColor),
            unselectedIconTheme:
                const IconThemeData(color: AppColors.kGreyColor),
            selectedLabelStyle: AppStyle.mulishTextStyle(
              fontSize: 14,
            ),
            unselectedLabelStyle:
                AppStyle.mulishTextStyle(fontSize: 14, c: AppColors.kGreyColor),
            items: [
              BottomNavigationBarItem(
                icon: controller.currentIndex.value == 0
                    ? SvgPicture.asset(selectedNutritionIcon)
                    : SvgPicture.asset(unselectedNutritionIcon),
                label: 'Nutrition',
              ),
              BottomNavigationBarItem(
                  icon: controller.currentIndex.value == 1
                      ? SvgPicture.asset(selectedPlanIcon)
                      : SvgPicture.asset(unselectedPlanIcon),
                  label: 'Plan'),
              BottomNavigationBarItem(
                  icon: controller.currentIndex.value == 2
                      ? SvgPicture.asset(selectedMoodIcon)
                      : SvgPicture.asset(unselectedMoodIcon),
                  label: 'Mood'),
              BottomNavigationBarItem(
                  icon: controller.currentIndex.value == 3
                      ? SvgPicture.asset(selectedProfileIcon)
                      : SvgPicture.asset(unselectedProfileIcon),
                  label: 'Profile'),
            ],
            onTap: (index) => controller.onTabTapped(index),
          ),
        );
      }),
    );
  }
}
