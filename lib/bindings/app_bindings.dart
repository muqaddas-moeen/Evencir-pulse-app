import 'package:evencir_pulse_app/features/auth/controllers/storage_controller.dart';
import 'package:evencir_pulse_app/services/firebase/auth_service.dart';
import 'package:evencir_pulse_app/services/firestore/workout_service.dart';
import 'package:evencir_pulse_app/services/weather_service.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(StorageController(), permanent: true);
    Get.put(FirebaseAuthService(), permanent: true);
    Get.put(WorkoutService(), permanent: true);
    Get.put(WeatherService(), permanent: true);
  }
}
