import 'package:evencir_pulse_app/core/utils/app_colors.dart';
import 'package:evencir_pulse_app/core/utils/app_style.dart';
import 'package:evencir_pulse_app/core/utils/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/mood_controller.dart';
import '../components/mood_header.dart';
import '../components/mood_selector.dart';

class MoodScreen extends GetView<MoodController> {
  const MoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        image:
            DecorationImage(image: AssetImage(moodBgIcon), fit: BoxFit.cover),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MoodHeader(),
            SizedBox(height: 30.h),
            Center(child: MoodSelector(controller: controller)),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.kWhiteColor,
                  foregroundColor: AppColors.kBlackColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r)),
                ),
                child: Text('Continue',
                    style: AppStyle.mulishTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        c: AppColors.kBlackColor)),
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
