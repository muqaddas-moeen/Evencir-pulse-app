import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_style.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.h),
        Text('Profile',
            style: AppStyle.mulishTextStyle(
                fontSize: 32, c: AppColors.kOffWhiteColor)),
      ],
    );
  }
}
