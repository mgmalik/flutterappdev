import 'package:flutter/material.dart';
import 'package:flutter_lec08_stepcount_photo/providers/camera_provider.dart';
import 'package:flutter_lec08_stepcount_photo/providers/step_provider.dart';
import 'package:flutter_lec08_stepcount_photo/providers/user_provider.dart';
import 'package:flutter_lec08_stepcount_photo/widgets/bottom_nav_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  final Widget child;

  const HomeScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasProfile = ref.watch(userProfileProvider.notifier).hasProfile;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Step Counter'),
        actions: [
          if (hasProfile)
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                context.push('/profile');
              },
              tooltip: 'Profile',
            )
          else
            ElevatedButton(
              onPressed: () {
                context.push('/profile');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue,
              ),
              child: const Text('Create Profile'),
            ),
        ],
      ),
      body: child,
      bottomNavigationBar: BottomNavBarWidget(),
    );
  }
}

class HomeContent extends ConsumerWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(userProfileProvider);
    final cameraState = ref.watch(cameraProvider);
    final stepData = ref.watch(stepProvider).value;
    final hasProfile = ref.watch(userProfileProvider.notifier).hasProfile;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue.shade50, Colors.white],
        ),
      ),
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.directions_walk, size: 100, color: Colors.blue),
              const SizedBox(height: 20),
              const Text(
                'Step Counter App',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Track your steps and create your profile',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 40),

              // Features
              _buildFeatureCard(
                context,
                'Step Counter',
                'Track your daily steps and activity status',
                Icons.directions_walk,
                Colors.green,
                '/step-counter',
              ),
              const SizedBox(height: 16),

              _buildFeatureCard(
                context,
                hasProfile ? 'Profile' : 'Create Profile',
                hasProfile
                    ? 'View and edit your profile information'
                    : 'Add your name, age, gender and photo',
                Icons.person,
                Colors.blue,
                '/profile',
              ),
              const SizedBox(height: 16),

              _buildFeatureCard(
                context,
                'Camera',
                'Take photos for your profile',
                Icons.camera_alt,
                Colors.orange,
                '/camera',
              ),

              if (!ref.watch(userProfileProvider.notifier).hasProfile) ...[
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.orange.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info, color: Colors.orange.shade700),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Create your profile to get personalized step metrics based on your height and weight',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    Color color,
    String route,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () => context.push(route),
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 30, color: color),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.grey.shade400),
            ],
          ),
        ),
      ),
    );
  }
}
