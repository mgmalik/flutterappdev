import 'package:flutter/material.dart';

enum ActivityType {
  stopped,
  walking,
  running;

  String get displayName {
    switch (this) {
      case ActivityType.stopped:
        return 'Stopped';
      case ActivityType.walking:
        return 'Walking';
      case ActivityType.running:
        return 'Running';
    }
  }

  IconData get icon {
    switch (this) {
      case ActivityType.stopped:
        return Icons.pause_circle_filled;
      case ActivityType.walking:
        return Icons.directions_walk;
      case ActivityType.running:
        return Icons.directions_run;
    }
  }

  Color get color {
    switch (this) {
      case ActivityType.stopped:
        return Colors.grey;
      case ActivityType.walking:
        return Colors.green;
      case ActivityType.running:
        return Colors.orange;
    }
  }
}

class StepData {
  final int stepCount;
  final double distance; // in km
  final double calories;
  final DateTime timestamp;
  final ActivityType activityType;

  StepData({
    required this.stepCount,
    required this.distance,
    required this.calories,
    required this.timestamp,
    required this.activityType,
  });

  // Calculate calories based on weight if available
  static double calculateCalories(int steps, double? weight) {
    // Rough estimation: steps * 0.04 * (weight/70) if weight available
    if (weight != null && weight > 0) {
      return steps * 0.04 * (weight / 70);
    }
    return steps * 0.04;
  }

  // Calculate distance based on height if available
  static double calculateDistance(int steps, double? height) {
    // Average step length = height * 0.415 (for adults)
    if (height != null && height > 0) {
      final stepLength = height * 0.415 / 100; // in meters
      return (steps * stepLength) / 1000; // in km
    }
    return steps * 0.000762; // default 0.762m per step
  }

  Map<String, dynamic> toJson() {
    return {
      'stepCount': stepCount,
      'distance': distance,
      'calories': calories,
      'timestamp': timestamp.toIso8601String(),
      'activityType': activityType.index,
    };
  }

  factory StepData.fromJson(Map<String, dynamic> json) {
    return StepData(
      stepCount: json['stepCount'],
      distance: json['distance'].toDouble(),
      calories: json['calories'].toDouble(),
      timestamp: DateTime.parse(json['timestamp']),
      activityType: ActivityType.values[json['activityType']],
    );
  }
}
