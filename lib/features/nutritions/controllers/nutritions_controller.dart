import 'package:evencir_pulse_app/features/bottom_nav_bar/controllers/bottom_nav_bar_controller.dart';
import 'package:evencir_pulse_app/features/auth/controllers/storage_controller.dart';
import 'package:evencir_pulse_app/features/plan/controllers/training_controller.dart';
import 'package:evencir_pulse_app/models/workout_model.dart';
import 'package:evencir_pulse_app/services/firestore/workout_service.dart';
import 'package:evencir_pulse_app/services/weather_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NutritionsController extends GetxController {
  final _workoutService = Get.find<WorkoutService>();
  final _storageController = Get.find<StorageController>();
  final weatherService = Get.find<WeatherService>();

  final selectedDate = DateTime.now().obs;
  final dailyWorkout = Rxn<Workout>();
  final _lastWorkoutMap = <String, Workout>{}.obs;

  // Insights Data
  final caloriesConsumed = 550.obs;
  final caloriesGoal = 2500.obs;
  final currentWeight = 75.0.obs;
  final weightChange = 1.6.obs;

  // Hydration Data
  final hydrationPercentage = 0.obs;
  final hydrationCurrentLiters = 0.0.obs;
  final hydrationGoalLiters = 2.0.obs;

  String get currentWeekText {
    int day = selectedDate.value.day;
    int weekNum = ((day - 1) / 7).floor() + 1;
    if (weekNum > 4) weekNum = 4;

    return 'Week $weekNum/4';
  }

  @override
  void onInit() {
    super.onInit();
    _listenToWorkouts();
    weatherService.fetchWeather();
  }

  void _listenToWorkouts() {
    _workoutService
        .getWorkouts(_storageController.userId.value)
        .listen((workoutMap) {
      _lastWorkoutMap.value = workoutMap;
      _updateWorkoutForSelectedDate();
    });
  }

  void updateSelectedDate(DateTime date) {
    selectedDate.value = date;
    _updateWorkoutForSelectedDate();
  }

  void _updateWorkoutForSelectedDate() {
    String dateId = DateFormat('yyyy-MM-dd').format(selectedDate.value);
    dailyWorkout.value = _lastWorkoutMap[dateId];
  }

  void navigateToWorkoutPlan(Workout workout) {
    final trainingController = Get.find<TrainingController>();

    trainingController.targetDate.value = selectedDate.value;

    Get.find<BottomNavBarController>().onTabTapped(1);

    // Call scrollToDate after tab switching
    trainingController.scrollToDate(selectedDate.value);
  }
}
