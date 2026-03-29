import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import '../components/profile_header.dart';
import '../components/profile_info.dart';
import '../components/profile_option_item.dart';
import '../components/logout_button.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProfileHeader(),
            SizedBox(height: 30.h),
            ProfileInfo(controller: controller),
            SizedBox(height: 40.h),
            ProfileOptionItem(
              icon: Icons.person_outline,
              title: 'Personal Info',
              onTap: () {},
            ),
            ProfileOptionItem(
              icon: Icons.settings_outlined,
              title: 'Settings',
              onTap: () {},
            ),
            ProfileOptionItem(
              icon: Icons.help_outline,
              title: 'Help Center',
              onTap: () {},
            ),
            SizedBox(height: 40.h),
            LogoutButton(controller: controller),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
