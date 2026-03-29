import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evencir_pulse_app/models/workout_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class WorkoutService extends GetxService {
  bool get _isFirebaseInitialized {
    try {
      Firebase.app();
      return true;
    } catch (_) {
      return false;
    }
  }

  FirebaseFirestore get _firestore {
    if (_isFirebaseInitialized) {
      return FirebaseFirestore.instance;
    }
    throw FirebaseException(
        plugin: 'cloud_firestore', message: 'Firebase not initialized');
  }

  Future<void> saveWorkout(
      Workout workout, DateTime date, String userId) async {
    await saveMultipleWorkouts({DateFormat('yyyy-MM-dd').format(date): workout},
        {DateFormat('yyyy-MM-dd').format(date): date}, userId);
  }

  Future<void> saveMultipleWorkouts(Map<String, Workout> workouts,
      Map<String, DateTime> dates, String userId) async {
    if (!_isFirebaseInitialized) {
      if (kDebugMode) {
        print("Firebase not initialized, cannot save workouts");
      }
      return;
    }
    try {
      WriteBatch batch = _firestore.batch();
      workouts.forEach((dateId, workout) {
        DocumentReference docRef = _firestore
            .collection('users')
            .doc(userId)
            .collection('workouts')
            .doc(dateId);
        batch.set(docRef, {
          'type': workout.type,
          'title': workout.title,
          'duration': workout.duration,
          'isCompleted': workout.isCompleted,
          'date': workout.date,
          'timestamp': FieldValue.serverTimestamp(),
          'userId': userId,
        });
      });
      await batch.commit();
      if (kDebugMode) {
        print("Workouts saved successfully via Batch!");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Firestore Batch Save Error: $e");
      }
    }
  }

  Stream<Map<String, Workout>> getWorkouts(String userId) {
    if (!_isFirebaseInitialized || userId.isEmpty) return Stream.value({});
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('workouts')
        .snapshots()
        .map((snapshot) {
      Map<String, Workout> workoutMap = {};
      for (var doc in snapshot.docs) {
        final data = doc.data();
        workoutMap[doc.id] = Workout(
          date: data['date'] ?? '',
          type: data['type'] ?? '',
          title: data['title'] ?? '',
          duration: data['duration'] ?? '',
          isCompleted: data['isCompleted'] ?? false,
        );
      }
      return workoutMap;
    });
  }
}
