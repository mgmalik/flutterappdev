import 'package:flutter/material.dart';
import 'package:flutter_lec08_navigation_router/routes/app_routes.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get arguments if any
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final productId = args?['productId'];
    final fromPage = args?['from'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Demonstrate different pop behaviors
            _showPopOptions(context);
          },
        ),
      ),
      body: Container(
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
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.blue.shade100,
                  child: const Icon(Icons.person, size: 70, color: Colors.blue),
                ),
                const SizedBox(height: 20),
                const Text(
                  'John Doe',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  'john.doe@example.com',
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                ),

                // Show received arguments if any
                if (productId != null) ...[
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Received Arguments:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text('Product ID: $productId'),
                        Text('From: $fromPage'),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 40),

                // Navigation options
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const Text(
                          'Navigation Options:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildOptionButton(
                          context,
                          'Go to Settings (Push)',
                          Icons.settings,
                          () {
                            Navigator.pushNamed(context, AppRoutes.settings);
                          },
                        ),
                        const SizedBox(height: 10),
                        _buildOptionButton(
                          context,
                          'Go Home (Replace)',
                          Icons.home,
                          () {
                            Navigator.pushReplacementNamed(
                              context,
                              AppRoutes.home,
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        _buildOptionButton(
                          context,
                          'Pop with Result',
                          Icons.reply,
                          () {
                            // Pop and return data
                            Navigator.pop(context, 'Data from Profile');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton(
    BuildContext context,
    String label,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 18),
        label: Text(label),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  void _showPopOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Choose Pop Method',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.arrow_back),
              title: const Text('Normal Pop'),
              subtitle: const Text('Navigator.pop(context)'),
              onTap: () {
                Navigator.pop(context); // Close bottom sheet
                Navigator.pop(context); // Go back
              },
            ),
            ListTile(
              leading: const Icon(Icons.reply_all),
              title: const Text('Pop with Data'),
              subtitle: const Text('Return data to previous page'),
              onTap: () {
                Navigator.pop(context); // Close bottom sheet
                Navigator.pop(
                  context,
                  'User profile data',
                ); // Go back with data
              },
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Pop Until Home'),
              subtitle: const Text(
                'Navigator.popUntil(context, ModalRoute.withName("/"))',
              ),
              onTap: () {
                Navigator.pop(context); // Close bottom sheet
                Navigator.popUntil(
                  context,
                  ModalRoute.withName(AppRoutes.home),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
