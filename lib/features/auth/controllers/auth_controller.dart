import 'package:evencir_pulse_app/core/utils/extensions.dart';
import 'package:evencir_pulse_app/features/auth/controllers/storage_controller.dart';
import 'package:evencir_pulse_app/models/user_model.dart';
import 'package:evencir_pulse_app/services/firebase/auth_service.dart';
import 'package:evencir_pulse_app/services/firestore/user_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../routes/app_pages.dart';

class AuthController extends GetxController {
  final FirebaseAuthService _authService = Get.find<FirebaseAuthService>();
  final UserService _userService = UserService();
  final StorageController storageController = Get.find<StorageController>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();

  final authSignupKey = GlobalKey<FormState>();
  final authSigninKey = GlobalKey<FormState>();

  final isLoading = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
    super.onClose();
  }

  void resetFieldsValues() {
    emailController.clear();
    passwordController.clear();
    fullNameController.clear();
  }

  Future<void> createAccount() async {
    try {
      if (!authSignupKey.currentState!.validate()) {
        return;
      }
      isLoading(true);
      var response = await _authService.signUp(
          password: passwordController.text,
          email: emailController.text.toLowerCase().trim());

      if (response != null) {
        UserModel userData = UserModel(
          id: response.uid,
          fullName: fullNameController.text,
          email: emailController.text,
          userType: 'user',
          createdAt: DateTime.now(),
        );

        await _userService.createUser(userData: userData);
        resetFieldsValues();
        storageController.userId.value = response.uid;

        Get.offNamed(Routes.LOGIN);
      }
    } catch (e) {
      Extensions().showSnackBar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> loginToAccount() async {
    try {
      if (!authSigninKey.currentState!.validate()) {
        return;
      }
      isLoading(true);
      var response = await _authService.signIn(
        email: emailController.text,
        password: passwordController.text,
      );

      if (response != null) {
        var userModel = await _userService.fetchUserData(response.uid);
        if (userModel != null) {
          storageController.setUser(userModel, userModel.id!);
          Get.offAllNamed(Routes.BOTTOM_NAV_BAR);
          resetFieldsValues();
        } else {
          _authService.signOut();
          Extensions().showSnackBar(
              "Error", "Login failed. Please check your credentials.");
        }
      }
    } catch (e) {
      Extensions().showSnackBar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> signOut() async {
    try {
      isLoading(true);
      await _authService.signOut();
      storageController.clearUserData();
      Get.offAllNamed(Routes.STARTER);
    } catch (e) {
      Get.log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  void goToRegister() {
    resetFieldsValues();
    Get.toNamed(Routes.REGISTER);
  }

  void goToLogin() {
    resetFieldsValues();
    Get.back();
  }
}
