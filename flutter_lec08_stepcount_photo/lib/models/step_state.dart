import 'package:flutter_lec08_stepcount_photo/models/step_data.dart';

class StepState {
  final int stepCount;
  final double distance;
  final double calories;
  final ActivityType currentActivity;
  final List<StepData> stepHistory;
  final bool isMonitoring;
  final String? error;

  StepState({
    required this.stepCount,
    required this.distance,
    required this.calories,
    required this.currentActivity,
    required this.stepHistory,
    required this.isMonitoring,
    this.error,
  });

  factory StepState.initial() {
    return StepState(
      stepCount: 0,
      distance: 0.0,
      calories: 0.0,
      currentActivity: ActivityType.stopped,
      stepHistory: [],
      isMonitoring: false,
      error: null,
    );
  }

  StepState copyWith({
    int? stepCount,
    double? distance,
    double? calories,
    ActivityType? currentActivity,
    List<StepData>? stepHistory,
    bool? isMonitoring,
    String? error,
  }) {
    return StepState(
      stepCount: stepCount ?? this.stepCount,
      distance: distance ?? this.distance,
      calories: calories ?? this.calories,
      currentActivity: currentActivity ?? this.currentActivity,
      stepHistory: stepHistory ?? this.stepHistory,
      isMonitoring: isMonitoring ?? this.isMonitoring,
      error: error,
    );
  }

  String get activityMessage {
    switch (currentActivity) {
      case ActivityType.stopped:
        return 'You are currently stationary';
      case ActivityType.walking:
        return 'You are walking - Keep moving!';
      case ActivityType.running:
        return 'Great pace! You are running';
    }
  }
}
