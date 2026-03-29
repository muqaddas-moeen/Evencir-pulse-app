import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_style.dart';

class MoodHeader extends StatelessWidget {
  const MoodHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Mood',
            style: AppStyle.mulishTextStyle(
                fontSize: 32, c: AppColors.kOffWhiteColor)),
        SizedBox(height: 20.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text('Start your day',
              style: AppStyle.mulishTextStyle(
                  fontSize: 18, c: AppColors.kOffWhiteColor)),
        ),
        SizedBox(height: 10.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text('How are you feeling at the Moment?',
              style: AppStyle.mulishTextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  c: AppColors.kOffWhiteColor)),
        ),
      ],
    );
  }
}
