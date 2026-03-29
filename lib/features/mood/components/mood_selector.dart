import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_style.dart';
import '../../../../core/utils/image_strings.dart';
import '../controllers/mood_controller.dart';

class MoodSelector extends StatelessWidget {
  final MoodController controller;

  const MoodSelector({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return GestureDetector(
                onPanStart: (details) {
                  final box = context.findRenderObject() as RenderBox;
                  final center = box.size.center(Offset.zero);
                  final pos = details.localPosition;
                  final angle = atan2(pos.dy - center.dy, pos.dx - center.dx);
                  controller.updateMoodFromAngle(angle);
                },
                onPanUpdate: (details) {
                  final box = context.findRenderObject() as RenderBox;
                  final center = box.size.center(Offset.zero);
                  final pos = details.localPosition;
                  final angle = atan2(pos.dy - center.dy, pos.dx - center.dx);
                  controller.updateMoodFromAngle(angle);
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      ringIcon,
                      width: 281.w,
                      height: 281.h,
                    ),
                    SvgPicture.asset(
                      controller.moodIconAsset,
                      width: 110.w,
                      height: 110.h,
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Center(
                        child: Transform.rotate(
                          angle:
                              _getAngleFromMood(controller.selectedMood.value),
                          child: Transform.translate(
                            offset: Offset(120.w, 0),
                            child: Container(
                              width: 57.5.w,
                              height: 57.5.h,
                              decoration: BoxDecoration(
                                color: AppColors.kLightGreyColor,
                                border: Border.all(
                                    color: AppColors.kBorderColor, width: 3.w),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      offset: const Offset(0, 2),
                                      blurRadius: 4,
                                      color: const Color(0xFF000000)
                                          .withOpacity(0.10)),
                                  BoxShadow(
                                      offset: const Offset(0, 7),
                                      blurRadius: 7,
                                      color: const Color(0xFF000000)
                                          .withOpacity(0.09)),
                                  BoxShadow(
                                      offset: const Offset(0, 17),
                                      blurRadius: 10,
                                      color: const Color(0xFF000000)
                                          .withOpacity(0.05)),
                                  BoxShadow(
                                      offset: const Offset(0, 30),
                                      blurRadius: 12,
                                      color: const Color(0xFF000000)
                                          .withOpacity(0.01)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: 40.h),
          Text(
            controller.moodName,
            style: AppStyle.mulishTextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w500,
                c: AppColors.kOffWhiteColor),
          ),
        ],
      );
    });
  }

  double _getAngleFromMood(MoodType mood) {
    switch (mood) {
      case MoodType.content:
        return pi / 4;
      case MoodType.peaceful:
        return 3 * pi / 4;
      case MoodType.happy:
        return 5 * pi / 4;
      case MoodType.calm:
        return 7 * pi / 4;
    }
  }
}
