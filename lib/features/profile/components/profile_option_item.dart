import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_style.dart';

class ProfileOptionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ProfileOptionItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: AppColors.kBlack3Color,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: AppColors.kGreenColor),
        title: Text(
          title,
          style: AppStyle.mulishTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            c: AppColors.kOffWhiteColor,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios,
            color: AppColors.kDarkGreyColor, size: 16.sp),
      ),
    );
  }
}
