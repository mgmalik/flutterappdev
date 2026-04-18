import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_lec08_stepcount_photo/models/user_profile.dart';
import 'package:flutter_lec08_stepcount_photo/providers/step_provider.dart';
import 'package:flutter_lec08_stepcount_photo/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

class StepCounterScreen extends ConsumerStatefulWidget {
  const StepCounterScreen({super.key});

  @override
  ConsumerState<StepCounterScreen> createState() => _StepCounterScreenState();
}

class _StepCounterScreenState extends ConsumerState<StepCounterScreen> {
  bool _hasPermission = false;

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    final status = await Permission.activityRecognition.status;
    setState(() {
      _hasPermission = status.isGranted;
    });

    if (_hasPermission) {
      ref.read(stepProvider.notifier).startMonitoring();
    }
  }

  Future<void> _requestPermission() async {
    final status = await Permission.activityRecognition.request();
    setState(() {
      _hasPermission = status.isGranted;
    });

    if (_hasPermission) {
      ref.read(stepProvider.notifier).startMonitoring();
    }
  }

  @override
  Widget build(BuildContext context) {
    final stepState = ref.watch(stepProvider);
    final userProfile = ref.watch(userProfileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Step Counter'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/home');
            }
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(stepProvider.notifier).resetDailySteps();
            },
            tooltip: 'Reset Today',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Permission warning
            if (!_hasPermission) _buildPermissionWarning(),

            // Activity Status Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: stepState.value!.currentActivity.color
                                .withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            stepState.value!.currentActivity.icon,
                            size: 40,
                            color: stepState.value!.currentActivity.color,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              stepState.value!.currentActivity.displayName,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: stepState.value!.currentActivity.color,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              stepState.value!.activityMessage,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Step Count Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const Text(
                      'Today\'s Steps',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${stepState.value!.stepCount}',
                      style: const TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildMetricColumn(
                          'Distance',
                          '${stepState.value!.distance.toStringAsFixed(2)} km',
                          Icons.straighten,
                        ),
                        _buildMetricColumn(
                          'Calories',
                          '${stepState.value!.calories.toStringAsFixed(0)} cal',
                          Icons.local_fire_department,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Profile Info Card (if available)
            if (ref.read(userProfileProvider.notifier).hasProfile) ...[
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.blue.shade100,
                        backgroundImage:
                            userProfile.value!.profileImagePath.isNotEmpty
                            ? FileImage(
                                File(userProfile.value!.profileImagePath),
                              )
                            : null,
                        child: userProfile.value!.profileImagePath.isEmpty
                            ? Text(
                                userProfile.value!.name.isNotEmpty
                                    ? userProfile.value!.name[0].toUpperCase()
                                    : '?',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : null,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userProfile.value!.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${userProfile.value!.gender.displayName}, ${userProfile.value!.age} years',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            if (userProfile.value!.bmi != null) ...[
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    'BMI: ${userProfile.value!.bmi!.toStringAsFixed(1)}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: userProfile.value!.bmiColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: userProfile.value!.bmiColor
                                          .withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      userProfile.value!.bmiCategory,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: userProfile.value!.bmiColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],

            // Control Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: !_hasPermission || stepState.value!.isMonitoring
                        ? null
                        : () {
                            ref.read(stepProvider.notifier).startMonitoring();
                          },
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Start'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: stepState.value!.isMonitoring
                        ? () {
                            ref.read(stepProvider.notifier).stopMonitoring();
                          }
                        : null,
                    icon: const Icon(Icons.stop),
                    label: const Text('Stop'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: stepState.value!.stepCount > 0
                    ? () {
                        ref.read(stepProvider.notifier).saveCurrentStepData();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Step data saved successfully'),
                          ),
                        );
                      }
                    : null,
                icon: const Icon(Icons.save),
                label: const Text('Save Current Data'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // History Section
            if (stepState.value!.stepHistory.isNotEmpty) ...[
              const Divider(),
              const SizedBox(height: 10),
              const Text(
                'Recent History',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ...stepState.value!.stepHistory.reversed
                  .take(5)
                  .map(
                    (data) => Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: data.activityType.color.withValues(
                            alpha: 0.2,
                          ),
                          child: Icon(
                            data.activityType.icon,
                            color: data.activityType.color,
                            size: 20,
                          ),
                        ),
                        title: Text('${data.stepCount} steps'),
                        subtitle: Text(
                          '${data.distance.toStringAsFixed(2)} km • '
                          '${data.calories.toStringAsFixed(0)} cal',
                        ),
                        trailing: Text(
                          '${data.timestamp.hour.toString().padLeft(2, '0')}:'
                          '${data.timestamp.minute.toString().padLeft(2, '0')}',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
            ],

            if (stepState.error != null) ...[
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error, color: Colors.red.shade700),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        stepState.value!.error!,
                        style: TextStyle(color: Colors.red.shade700),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionWarning() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.warning, color: Colors.orange.shade700),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Permission Required',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Activity recognition permission is needed to count steps',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          TextButton(onPressed: _requestPermission, child: const Text('Grant')),
        ],
      ),
    );
  }

  Widget _buildMetricColumn(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }

  @override
  void dispose() {
    // ref.read(stepProvider.notifier).stopMonitoring();
    super.dispose();
  }
}
