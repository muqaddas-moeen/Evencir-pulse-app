import 'package:evencir_pulse_app/models/user_model.dart';
import 'package:get/get.dart';

class StorageController extends GetxController {
  final userId = ''.obs;
  final user = Rxn<UserModel>();

  void setUser(UserModel userModel, String id) {
    user.value = userModel;
    userId.value = id;
  }

  void clearUserData() {
    user.value = null;
    userId.value = '';
  }
}
