import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:evencir_pulse_app/core/utils/app_colors.dart';
import 'package:evencir_pulse_app/core/utils/app_style.dart';

class WeeklyHeader extends StatelessWidget {
  final int weekNum;
  final String dateRange;
  final String total;

  const WeeklyHeader({
    super.key,
    required this.weekNum,
    required this.dateRange,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.kBlack2Color,
        border: Border(
          top: BorderSide(
            color: weekNum % 2 == 0 ? AppColors.kGreenColor : AppColors.kBlueColor,
            width: 3.w,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Week $weekNum',
                  style: AppStyle.mulishTextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              Text(dateRange,
                  style: AppStyle.mulishTextStyle(
                      c: AppColors.kDarkGreyColor, fontSize: 16)),
            ],
          ),
          Text('Total: $total',
              style: AppStyle.mulishTextStyle(
                  c: AppColors.kDarkGreyColor, fontSize: 16)),
        ],
      ),
    );
  }
}
