import 'dart:async';
import 'package:flutter_lec08_stepcount_photo/models/step_data.dart';
import 'package:flutter_lec08_stepcount_photo/models/step_state.dart';
import 'package:flutter_lec08_stepcount_photo/models/user_profile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedometer/pedometer.dart';

class StepNotifier extends AsyncNotifier<StepState> {
  UserProfile? userProfile;
  Stream<StepCount>? _stepCountStream;
  Stream<PedestrianStatus>? _pedestrianStatusStream;
  StreamSubscription<StepCount>? _stepSubscription;
  StreamSubscription<PedestrianStatus>? _statusSubscription;

  @override
  FutureOr<StepState> build() async {
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

  // StepNotifier({this.userProfile}) : super(StepState.initial());

  Future<void> startMonitoring() async {
    // state = const AsyncLoading();
    if (state.value!.isMonitoring) return;
    try {
      _stepCountStream = Pedometer.stepCountStream;
      _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
      _stepSubscription = _stepCountStream!.listen(
        _onStepCount,
        onError: _onStepError,
      );
      _statusSubscription = _pedestrianStatusStream!.listen(
        _onStatusChange,
        onError: _onStatusError,
      );
      state = AsyncData(state.value!.copyWith(isMonitoring: true, error: null));
    } catch (error) {
      state = AsyncData(
        state.value!.copyWith(error: 'Error initializing pedometer: $error'),
      );
    }
  }

  void _onStepCount(StepCount event) {
    // state = const AsyncLoading();
    final newStepCount = event.steps;
    // Calculate metrics based on user profile if available
    final newDistance = StepData.calculateDistance(
      newStepCount,
      userProfile?.height,
    );
    final newCalories = StepData.calculateCalories(
      newStepCount,
      userProfile?.weight,
    );
    state = AsyncData(
      state.value!.copyWith(
        stepCount: newStepCount,
        distance: newDistance,
        calories: newCalories,
      ),
    );
  }

  void _onStatusChange(PedestrianStatus event) {
    // state = const AsyncLoading();
    ActivityType activity;
    switch (event.status) {
      case 'walking':
        activity = ActivityType.walking;
        break;
      case 'running':
        activity = ActivityType.running;
        break;
      default:
        activity = ActivityType.stopped;
    }
    state = AsyncData(state.value!.copyWith(currentActivity: activity));
  }

  void _onStepError(error) {
    // state = const AsyncLoading();
    state = AsyncData(state.value!.copyWith(error: 'Step count error: $error'));
  }

  void _onStatusError(error) {
    // state = const AsyncLoading();
    state = AsyncData(
      state.value!.copyWith(error: 'Pedestrian status error: $error'),
    );
  }

  void stopMonitoring() {
    // state = const AsyncLoading();
    _stepSubscription?.cancel();
    _statusSubscription?.cancel();
    state = AsyncData(state.value!.copyWith(isMonitoring: false));
  }

  void saveCurrentStepData() {
    final stepData = StepData(
      stepCount: state.value!.stepCount,
      distance: state.value!.distance,
      calories: state.value!.calories,
      timestamp: DateTime.now(),
      activityType: state.value!.currentActivity,
    );

    final updatedHistory = List<StepData>.from(state.value!.stepHistory)
      ..add(stepData);

    // Keep only last 100 entries
    if (updatedHistory.length > 100) {
      updatedHistory.removeAt(0);
    }

    state = AsyncData(state.value!.copyWith(stepHistory: updatedHistory));
  }

  void resetDailySteps() {
    state = AsyncData(
      state.value!.copyWith(stepCount: 0, distance: 0.0, calories: 0.0),
    );
  }

  void updateUserProfile(UserProfile newProfile) {
    // Recalculate metrics with new profile data
    userProfile = newProfile;
    final newDistance = StepData.calculateDistance(
      state.value!.stepCount,
      newProfile.height,
    );
    final newCalories = StepData.calculateCalories(
      state.value!.stepCount,
      newProfile.weight,
    );

    state = AsyncData(
      state.value!.copyWith(distance: newDistance, calories: newCalories),
    );
  }

  void dispose() {
    _stepSubscription?.cancel();
    _statusSubscription?.cancel();
  }
}

final stepProvider = AsyncNotifierProvider<StepNotifier, StepState>(
  StepNotifier.new,
);
