import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_style.dart';
import '../controllers/profile_controller.dart';

class ProfileInfo extends StatelessWidget {
  final ProfileController controller;

  const ProfileInfo({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Obx(() => CircleAvatar(
                radius: 40.r,
                backgroundColor: AppColors.kBlack3Color,
                backgroundImage: controller.userProfilePic.value.isNotEmpty
                    ? NetworkImage(controller.userProfilePic.value)
                    : null,
                child: controller.userProfilePic.value.isEmpty &&
                        controller.userName.value.isNotEmpty
                    ? Text(
                        controller.userName.value[0].toUpperCase(),
                        style: AppStyle.mulishTextStyle(
                            fontSize: 32, fontWeight: FontWeight.w700),
                      )
                    : null,
              )),
          SizedBox(height: 16.h),
          Obx(() => Text(
                controller.userName.value.isEmpty
                    ? 'Loading...'
                    : controller.userName.value,
                style: AppStyle.mulishTextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  c: AppColors.kOffWhiteColor,
                ),
              )),
          Obx(() => Text(
                controller.userEmail.value,
                style: AppStyle.mulishTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  c: AppColors.kDarkGreyColor,
                ),
              )),
        ],
      ),
    );
  }
}
