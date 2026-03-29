import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_style.dart';
import '../controllers/nutritions_controller.dart';

class NutritionHydration extends StatelessWidget {
  final NutritionsController controller;

  const NutritionHydration({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColors.kBlack3Color,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.r), topRight: Radius.circular(8.r)),
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() => Text('${controller.hydrationPercentage.value}%',
                          style: AppStyle.mulishTextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w600,
                              c: AppColors.kBlue2Color))),
                      SizedBox(height: 24.h),
                      Text('Hydration',
                          style: AppStyle.mulishTextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              c: AppColors.kOffWhiteColor)),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text('Log Now',
                            style: AppStyle.mulishTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              c: AppColors.kOffWhiteColor.withOpacity(0.7),
                            )),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('2 L',
                              style: AppStyle.mulishTextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  c: AppColors.kOffWhiteColor)),
                          SizedBox(width: 8.w),
                          Container(
                            width: 14.w,
                            height: 4.h,
                            decoration: BoxDecoration(
                              color: AppColors.kBlue2Color,
                              borderRadius: BorderRadius.circular(2.r),
                            ),
                          ),
                          SizedBox(width: 60.w),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      ...List.generate(
                        3,
                        (index) => Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 25.w),
                            Container(
                              width: 8.w,
                              height: 2.h,
                              margin: EdgeInsets.symmetric(vertical: 4.h),
                              decoration: BoxDecoration(
                                color: AppColors.kGreyColor.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(1.r),
                              ),
                            ),
                            SizedBox(width: 66.w),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 25.w),
                          Container(
                            width: 14.w,
                            height: 4.h,
                            decoration: BoxDecoration(
                              color: AppColors.kBlue2Color,
                              borderRadius: BorderRadius.circular(2.r),
                            ),
                          ),
                          SizedBox(width: 60.w),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      ...List.generate(
                        3,
                        (index) => Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 25.w),
                            Container(
                              width: 8.w,
                              height: 2.h,
                              margin: EdgeInsets.symmetric(vertical: 4.h),
                              decoration: BoxDecoration(
                                color: AppColors.kGreyColor.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(1.r),
                              ),
                            ),
                            SizedBox(width: 66.w),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('0 L',
                              style: AppStyle.mulishTextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  c: AppColors.kOffWhiteColor)),
                          SizedBox(width: 8.w),
                          Container(
                            width: 14.w,
                            height: 4.h,
                            decoration: BoxDecoration(
                              color: AppColors.kBlue2Color,
                              borderRadius: BorderRadius.circular(2.r),
                            ),
                          ),
                          Container(
                            width: 50.w,
                            height: 1.h,
                            color: AppColors.kGreyColor.withOpacity(0.3),
                          ),
                          Text('0ml',
                              style: AppStyle.mulishTextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  c: AppColors.kOffWhiteColor)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: const Color(0xFF1A3A3A),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8.r),
                bottomRight: Radius.circular(8.r)),
          ),
          child: Center(
            child: Text('500 ml added to water log',
                style: AppStyle.mulishTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    c: AppColors.kOffWhiteColor.withOpacity(0.9))),
          ),
        ),
      ],
    );
  }
}
