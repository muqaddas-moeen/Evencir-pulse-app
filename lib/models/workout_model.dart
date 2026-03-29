class Workout {
  final String date;
  final String type;
  final String title;
  final String duration;
  final bool isCompleted;

  Workout({
    required this.date,
    required this.type,
    required this.title,
    required this.duration,
    this.isCompleted = false,
  });
}
