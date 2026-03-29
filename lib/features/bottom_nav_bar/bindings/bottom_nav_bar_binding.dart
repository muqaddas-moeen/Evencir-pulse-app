import 'package:get/get.dart';
import '../controllers/bottom_nav_bar_controller.dart';
import '../../nutritions/controllers/nutritions_controller.dart';
import '../../plan/controllers/training_controller.dart';
import '../../mood/controllers/mood_controller.dart';
import '../../profile/controllers/profile_controller.dart';

class BottomNavBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavBarController>(() => BottomNavBarController());
    Get.lazyPut<NutritionsController>(() => NutritionsController());
    Get.lazyPut<TrainingController>(() => TrainingController());
    Get.lazyPut<MoodController>(() => MoodController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
