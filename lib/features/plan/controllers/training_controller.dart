import 'package:evencir_pulse_app/features/auth/controllers/storage_controller.dart';
import 'package:evencir_pulse_app/features/plan/models/training_models.dart';
import 'package:evencir_pulse_app/models/workout_model.dart';
import 'package:evencir_pulse_app/services/firestore/workout_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class TrainingController extends GetxController {
  final weeks = <TrainingWeek>[].obs;
  final _workoutService = Get.find<WorkoutService>();
  final _storageController = Get.find<StorageController>();
  final isLoading = false.obs;
  final scrollController = ScrollController();
  final hasUnsavedChanges = false.obs;

  final targetDate = Rxn<DateTime>();

  @override
  void onInit() {
    super.onInit();
    _loadInitialWorkouts();
    _listenToWorkouts();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void scrollToDate(DateTime date) {
    int weekIndex = -1;
    int dayIndexInWeek = -1;

    for (int i = 0; i < weeks.length; i++) {
      int dIdx = weeks[i].days.indexWhere((d) => isSameDay(d.date, date));
      if (dIdx != -1) {
        weekIndex = i;
        dayIndexInWeek = dIdx;
        break;
      }
    }

    if (weekIndex != -1) {
      double offset = 0;
      // Estimate heights based on screen resolution
      double headerHeight = 65.h;
      double dayRowNoWorkoutHeight = 70.h;
      double dayRowWithWorkoutHeight = 110.h;

      for (int i = 0; i < weekIndex; i++) {
        offset += headerHeight;
        for (var day in weeks[i].days) {
          offset += (day.workout == null)
              ? dayRowNoWorkoutHeight
              : dayRowWithWorkoutHeight;
        }
      }

      // Add the current week's header
      offset += headerHeight;
      // Add days in the current week up to the target day
      for (int j = 0; j < dayIndexInWeek; j++) {
        offset += (weeks[weekIndex].days[j].workout == null)
            ? dayRowNoWorkoutHeight
            : dayRowWithWorkoutHeight;
      }

      // Reset targetDate highlight after a few seconds
      Future.delayed(const Duration(seconds: 3), () {
        targetDate.value = null;
      });

      Future.delayed(const Duration(milliseconds: 300), () {
        if (scrollController.hasClients) {
          scrollController.animateTo(
            offset,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOutCubic,
          );
        }
      });
    }
  }

  void _listenToWorkouts() {
    _workoutService
        .getWorkouts(_storageController.userId.value)
        .listen((workoutMap) {
      _mergeWorkouts(workoutMap);
    });
  }

  void _mergeWorkouts(Map<String, Workout> workoutMap) {
    if (hasUnsavedChanges.value || isLoading.value) {
      print(
          "🕵️ Skipping Firestore merge because of local unsaved changes or saving in progress");
      return;
    }
    for (int i = 0; i < weeks.length; i++) {
      var week = weeks[i];
      var newDays = week.days.map((day) {
        String dateId = DateFormat('yyyy-MM-dd').format(day.date);
        if (workoutMap.containsKey(dateId)) {
          return TrainingDay(date: day.date, workout: workoutMap[dateId]);
        }
        return day;
      }).toList();

      weeks[i] = TrainingWeek(
        weekNumber: week.weekNumber,
        days: newDays,
        totalDuration: _calculateWeekDuration(newDays),
      );
    }
  }

  void _loadInitialWorkouts() {
    DateTime now = DateTime.now();
    List<TrainingWeek> allWeeks = [];

    // Generate for current month and next 2 months
    for (int i = 0; i < 3; i++) {
      DateTime targetMonth = DateTime(now.year, now.month + i, 1);
      allWeeks
          .addAll(_generateWeeksForMonth(targetMonth.year, targetMonth.month));
    }

    weeks.assignAll(allWeeks);
  }

  List<TrainingWeek> _generateWeeksForMonth(int year, int month) {
    List<TrainingWeek> monthWeeks = [];

    // Get total days in month
    int lastDayOfMonth = DateTime(year, month + 1, 0).day;

    int currentDay = 1;
    int weekNum = 1;

    while (currentDay <= lastDayOfMonth && weekNum <= 4) {
      List<TrainingDay> daysInWeek = [];
      int weekEnd = currentDay + 6;
      if (weekEnd > lastDayOfMonth || weekNum == 4) weekEnd = lastDayOfMonth;

      for (int day = currentDay; day <= weekEnd; day++) {
        DateTime date = DateTime(year, month, day);
        daysInWeek.add(TrainingDay(date: date, workout: null));
      }

      monthWeeks.add(TrainingWeek(
        weekNumber: weekNum,
        days: daysInWeek,
        totalDuration: _calculateWeekDuration(daysInWeek),
      ));

      currentDay = weekEnd + 1;
      weekNum++;
    }

    return monthWeeks;
  }

  String _calculateWeekDuration(List<TrainingDay> days) {
    int totalMinutes = 0;

    for (var d in days) {
      if (d.workout != null) {
        String duration = d.workout!.duration;
        if (duration.contains('-')) {
          var parts = duration.split('-');
          // Use the end part (max time) for the total calculation
          String endPart = parts.length > 1 ? parts[1].trim() : parts[0].trim();

          if (endPart.contains('m')) {
            totalMinutes += int.tryParse(endPart.split('m').first.trim()) ?? 0;
          } else {
            totalMinutes += int.tryParse(endPart) ?? 0;
          }
        } else if (duration.contains('m')) {
          totalMinutes += int.tryParse(duration.split('m').first.trim()) ?? 0;
        } else {
          totalMinutes += int.tryParse(duration.trim()) ?? 0;
        }
      }
    }

    return '${totalMinutes}min';
  }

  void moveWorkout(Workout workout, DateTime oldDate, DateTime newDate) {
    hasUnsavedChanges.value = true;
    // 1. Remove from old date
    for (int i = 0; i < weeks.length; i++) {
      var week = weeks[i];
      int dayIndex = week.days.indexWhere((d) =>
          d.date.year == oldDate.year &&
          d.date.month == oldDate.month &&
          d.date.day == oldDate.day);

      if (dayIndex != -1 && week.days[dayIndex].workout == workout) {
        var newDays = List<TrainingDay>.from(week.days);
        newDays[dayIndex] = TrainingDay(date: oldDate, workout: null);
        weeks[i] = TrainingWeek(
          weekNumber: week.weekNumber,
          days: newDays,
          totalDuration: _calculateWeekDuration(newDays),
        );
        break;
      }
    }

    // 2. Add to new date
    for (int i = 0; i < weeks.length; i++) {
      var week = weeks[i];
      int dayIndex = week.days.indexWhere((d) =>
          d.date.year == newDate.year &&
          d.date.month == newDate.month &&
          d.date.day == newDate.day);

      if (dayIndex != -1) {
        var newDays = List<TrainingDay>.from(week.days);
        newDays[dayIndex] = TrainingDay(date: newDate, workout: workout);
        weeks[i] = TrainingWeek(
          weekNumber: week.weekNumber,
          days: newDays,
          totalDuration: _calculateWeekDuration(newDays),
        );
        break;
      }
    }
  }

  void updateWorkoutInDay(DateTime date,
      {String? type, String? title, String? duration}) {
    for (int i = 0; i < weeks.length; i++) {
      var week = weeks[i];
      int dayIndex = week.days.indexWhere((d) => isSameDay(d.date, date));

      if (dayIndex != -1) {
        var existingDay = week.days[dayIndex];
        var existingWorkout = existingDay.workout;

        if (existingWorkout == null) return;

        hasUnsavedChanges.value = true;
        var newDays = List<TrainingDay>.from(week.days);
        newDays[dayIndex] = TrainingDay(
          date: date,
          workout: Workout(
            date: existingWorkout.date,
            type: type ?? existingWorkout.type,
            title: title ?? existingWorkout.title,
            duration: duration ?? existingWorkout.duration,
            isCompleted: existingWorkout.isCompleted,
          ),
        );
        weeks[i] = TrainingWeek(
          weekNumber: week.weekNumber,
          days: newDays,
          totalDuration: _calculateWeekDuration(newDays),
        );
        break;
      }
    }
  }

  void updateWorkoutDurationPart(DateTime date, {String? start, String? end}) {
    for (int i = 0; i < weeks.length; i++) {
      var week = weeks[i];
      int dayIndex = week.days.indexWhere((d) => isSameDay(d.date, date));

      if (dayIndex != -1 && week.days[dayIndex].workout != null) {
        var workout = week.days[dayIndex].workout!;
        String current = workout.duration;
        String startTime = "00m";
        String endTime = "00m";

        if (current.contains('-')) {
          var parts = current.split('-');
          startTime = parts[0].trim();
          if (parts.length > 1) {
            endTime = parts[1].trim();
          }
        } else {
          startTime = current.trim();
        }

        String newDuration = "${start ?? startTime} - ${end ?? endTime}";
        updateWorkoutInDay(date, duration: newDuration);
        break;
      }
    }
  }

  void addWorkoutToDay(DateTime date) {
    for (int i = 0; i < weeks.length; i++) {
      var week = weeks[i];
      int dayIndex = week.days.indexWhere((d) => isSameDay(d.date, date));

      if (dayIndex != -1 && week.days[dayIndex].workout == null) {
        hasUnsavedChanges.value = true;
        var newDays = List<TrainingDay>.from(week.days);
        newDays[dayIndex] = TrainingDay(
          date: date,
          workout: Workout(
            date: DateFormat('MMM d').format(date),
            type: 'Arms Workout',
            title: 'New Workout',
            duration: '00m - 00m',
          ),
        );
        weeks[i] = TrainingWeek(
          weekNumber: week.weekNumber,
          days: newDays,
          totalDuration: _calculateWeekDuration(newDays),
        );
        break;
      }
    }
  }

  Future<void> saveAllToFirebase() async {
    isLoading.value = true;
    try {
      final workoutsToSave = <String, Workout>{};
      final datesToSave = <String, DateTime>{};

      for (var week in weeks) {
        for (var day in week.days) {
          if (day.workout != null) {
            String dateId = DateFormat('yyyy-MM-dd').format(day.date);

            workoutsToSave[dateId] = day.workout!;
            datesToSave[dateId] = day.date;
          }
        }
      }

      if (workoutsToSave.isNotEmpty) {
        await _workoutService.saveMultipleWorkouts(
            workoutsToSave, datesToSave, _storageController.userId.value);
      }

      hasUnsavedChanges.value = false;

      Get.snackbar('Success', 'Workouts saved to Firebase!',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'Failed to save workouts: $e',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }
}
