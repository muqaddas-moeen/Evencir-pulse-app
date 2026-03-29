import 'package:evencir_pulse_app/models/workout_model.dart';

class TrainingDay {
  final DateTime date;
  final Workout? workout;

  TrainingDay({required this.date, this.workout});
}

class TrainingWeek {
  final int weekNumber;
  final List<TrainingDay> days;
  final String totalDuration;

  TrainingWeek({
    required this.weekNumber,
    required this.days,
    required this.totalDuration,
  });
}
