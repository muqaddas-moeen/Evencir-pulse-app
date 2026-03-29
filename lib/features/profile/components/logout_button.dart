import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/app_style.dart';
import '../controllers/profile_controller.dart';

class LogoutButton extends StatelessWidget {
  final ProfileController controller;

  const LogoutButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(() => controller.isLoading.value
          ? const CircularProgressIndicator(color: Colors.redAccent)
          : TextButton(
              onPressed: () => controller.logout(),
              child: Text(
                'Logout',
                style: AppStyle.mulishTextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  c: Colors.redAccent,
                ),
              ),
            )),
    );
  }
}
