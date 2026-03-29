import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum MoodType { calm, content, peaceful, happy }

class MoodController extends GetxController {
  final selectedMood = MoodType.calm.obs;

  String get moodName {
    switch (selectedMood.value) {
      case MoodType.calm:
        return 'Calm';
      case MoodType.content:
        return 'Content';
      case MoodType.peaceful:
        return 'Peaceful';
      case MoodType.happy:
        return 'Happy';
    }
  }

  String get moodEmoji {
    switch (selectedMood.value) {
      case MoodType.calm:
        return '😌';
      case MoodType.content:
        return '😊';
      case MoodType.peaceful:
        return '😇';
      case MoodType.happy:
        return '😁';
    }
  }

  Color get moodColor {
    switch (selectedMood.value) {
      case MoodType.calm:
        return Colors.orangeAccent;
      case MoodType.content:
        return Colors.yellowAccent;
      case MoodType.peaceful:
        return Colors.lightBlueAccent;
      case MoodType.happy:
        return Colors.pinkAccent;
    }
  }

  void setMood(MoodType mood) {
    selectedMood.value = mood;
  }

  String get moodIconAsset {
    switch (selectedMood.value) {
      case MoodType.calm:
        return 'assets/images/calm.svg';
      case MoodType.content:
        return 'assets/images/content.svg';
      case MoodType.peaceful:
        return 'assets/images/peaceful.svg';
      case MoodType.happy:
        return 'assets/images/happy.svg';
    }
  }

  void updateMoodFromAngle(double angle) {
    // Normalize angle to 0 to 2*pi
    double normalized = angle;
    while (normalized < 0) {
      normalized += 2 * pi;
    }
    while (normalized >= 2 * pi) {
      normalized -= 2 * pi;
    }

    if (normalized < pi / 2) {
      selectedMood.value = MoodType.content;
    } else if (normalized < pi) {
      selectedMood.value = MoodType.peaceful;
    } else if (normalized < 3 * pi / 2) {
      selectedMood.value = MoodType.happy;
    } else {
      selectedMood.value = MoodType.calm;
    }
  }
}
