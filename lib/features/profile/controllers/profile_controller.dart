import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evencir_pulse_app/features/auth/controllers/storage_controller.dart';
import 'package:evencir_pulse_app/core/utils/routes/app_pages.dart';
import 'package:evencir_pulse_app/services/firebase/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final FirebaseAuthService _authService = Get.find<FirebaseAuthService>();
  final StorageController _storageController = Get.find<StorageController>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final userName = ''.obs;
  final userEmail = ''.obs;
  final userProfilePic = ''.obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserProfile();

    ever(_storageController.user, (_) => _loadUserProfile());
  }

  Future<void> _loadUserProfile() async {
    if (_storageController.user.value != null) {
      userName.value = _storageController.user.value?.fullName ?? '';
      userEmail.value = _storageController.user.value?.email ?? '';
      userProfilePic.value = _storageController.user.value?.profilePic ?? '';
      return;
    }

    User? currentUser = _authService.currentUser;
    if (currentUser != null) {
      userEmail.value = currentUser.email ?? '';
      userName.value = currentUser.displayName ?? '';

      try {
        DocumentSnapshot doc =
            await _firestore.collection('users').doc(currentUser.uid).get();
        if (doc.exists) {
          final data = doc.data() as Map<String, dynamic>;
          userName.value = data['fullName'] ?? userName.value;
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error loading profile: $e');
        }
      }
    }
  }

  Future<void> logout() async {
    try {
      isLoading.value = true;
      await _authService.signOut();
      _storageController.clearUserData();
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      Get.snackbar('Logout Failed', 'An error occurred during logout.');
    } finally {
      isLoading.value = false;
    }
  }
}
