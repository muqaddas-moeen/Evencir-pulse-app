import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_style.dart';
import '../controllers/nutritions_controller.dart';

class NutritionInsights extends StatelessWidget {
  final NutritionsController controller;

  const NutritionInsights({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('My Insights',
            style: AppStyle.mulishTextStyle(
                fontSize: 24, fontWeight: FontWeight.w600)),
        SizedBox(height: 12.h),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _buildCaloriesCard(),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: _buildWeightCard(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCaloriesCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: AppColors.kBlack3Color,
        borderRadius: BorderRadius.circular(6.89.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => RichText(
                textAlign: TextAlign.start,
                text: TextSpan(children: [
                  TextSpan(
                      text: '${controller.caloriesConsumed.value} ',
                      style: AppStyle.mulishTextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                          c: AppColors.kOffWhiteColor)),
                  TextSpan(
                      text: 'Calories',
                      style: AppStyle.mulishTextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          c: AppColors.kOffWhiteColor)),
                ]),
              )),
          SizedBox(height: 4.h),
          Obx(() => Text(
              '${controller.caloriesGoal.value - controller.caloriesConsumed.value} Remaining',
              style: AppStyle.mulishTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  c: AppColors.kOffWhiteColor.withOpacity(0.5)))),
          SizedBox(height: 25.h),
       
          Obx(() {
            final percent = (controller.caloriesConsumed.value /
                    controller.caloriesGoal.value)
                .clamp(0.0, 1.0);
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('0',
                        style: AppStyle.mulishTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            c: AppColors.kOffWhiteColor.withOpacity(0.5))),
                    Text('${controller.caloriesGoal.value}',
                        style: AppStyle.mulishTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            c: AppColors.kOffWhiteColor.withOpacity(0.5))),
                  ],
                ),
                SizedBox(height: 4.h),
                LinearProgressIndicator(
                  value: percent,
                  backgroundColor: AppColors.kGreyColor.withOpacity(0.3),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.kGreenColor),
                  minHeight: 6.h,
                  borderRadius: BorderRadius.circular(3.r),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildWeightCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: AppColors.kBlack3Color,
        borderRadius: BorderRadius.circular(6.89.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('${controller.currentWeight.value} ',
                    style: AppStyle.mulishTextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        c: AppColors.kOffWhiteColor)),
                Padding(
                  padding: EdgeInsets.only(bottom: 6.h),
                  child: Text('kg',
                      style: AppStyle.mulishTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          c: AppColors.kOffWhiteColor)),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(4.w),
                decoration: const BoxDecoration(
                  color: Color(0xFF154124),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.arrow_outward,
                    color: const Color(0xFF01A53C), size: 12.sp),
              ),
              SizedBox(width: 4.w),
              Text('+${controller.weightChange.value}kg',
                  style: AppStyle.mulishTextStyle(
                      fontSize: 14,
                      c: AppColors.kOffWhiteColor.withOpacity(0.7),
                      fontWeight: FontWeight.w600)),
            ],
          ),
        SizedBox(height: 30.h),
          Text('Weight',
              style: AppStyle.mulishTextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  c: AppColors.kOffWhiteColor)),
        ],
      ),
    );
  }
}
