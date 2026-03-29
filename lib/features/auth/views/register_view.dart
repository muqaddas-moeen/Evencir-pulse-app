import 'package:evencir_pulse_app/core/utils/app_colors.dart';
import 'package:evencir_pulse_app/core/utils/app_style.dart';
import 'package:evencir_pulse_app/core/utils/form_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class RegisterView extends GetView<AuthController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBlackColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: controller.authSignupKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 60.h),
                Text(
                  'Create Account',
                  style: AppStyle.mulishTextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    c: AppColors.kOffWhiteColor,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Sign up to get started',
                  style: AppStyle.mulishTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    c: AppColors.kDarkGreyColor,
                  ),
                ),
                SizedBox(height: 48.h),
                _buildLabel('Full Name'),
                _buildTextField(
                  controller: controller.fullNameController,
                  hintText: 'Enter your full name',
                  keyboardType: TextInputType.name,
                  validator: FormValidators.validateName,
                ),
                SizedBox(height: 24.h),
                _buildLabel('Email Address'),
                _buildTextField(
                  controller: controller.emailController,
                  hintText: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  validator: FormValidators.validateEmail,
                ),
                SizedBox(height: 24.h),
                _buildLabel('Password'),
                _buildTextField(
                  controller: controller.passwordController,
                  hintText: 'Enter your password',
                  isPassword: true,
                  validator: FormValidators.validatePassword,
                ),
                SizedBox(height: 48.h),
                Obx(() => SizedBox(
                      width: double.infinity,
                      height: 56.h,
                      child: ElevatedButton(
                        onPressed: controller.isLoading.value
                            ? null
                            : () => controller.createAccount(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.kGreenColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: controller.isLoading.value
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : Text(
                                'Register',
                                style: AppStyle.mulishTextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  c: Colors.white,
                                ),
                              ),
                      ),
                    )),
                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: AppStyle.mulishTextStyle(
                        fontSize: 14,
                        c: AppColors.kDarkGreyColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () => controller.goToLogin(),
                      child: Text(
                        'Login Now',
                        style: AppStyle.mulishTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          c: AppColors.kGreenColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        label,
        style: AppStyle.mulishTextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          c: AppColors.kOffWhiteColor.withOpacity(0.8),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool isPassword = false,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.kBlack3Color,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        validator: validator,
        style: AppStyle.mulishTextStyle(c: AppColors.kOffWhiteColor),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppStyle.mulishTextStyle(c: AppColors.kDarkGreyColor),
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        ),
      ),
    );
  }
}
