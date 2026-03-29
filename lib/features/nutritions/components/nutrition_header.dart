import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/app_style.dart';
import '../controllers/nutritions_controller.dart';

class NutritionHeader extends StatelessWidget {
  final NutritionsController controller;

  const NutritionHeader({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => Text(
              'Today, ${DateFormat('d MMM yyyy').format(controller.selectedDate.value)}',
              style: AppStyle.mulishTextStyle(
                  fontSize: 16, fontWeight: FontWeight.w700),
            )),
      ],
    );
  }
}
