import 'package:flutter/material.dart';
import 'package:flutter_lec08_navigation_router/routes/app_routes.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Check if we can pop before popping
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          _buildHeader(),
          _buildSection('Navigation Settings', [
            _buildTile(
              context,
              'Navigation Stack',
              Icons.stacked_line_chart,
              _showNavigationStack,
            ),
            _buildTile(context, 'Clear Stack & Go Home', Icons.clear_all, (
              ctx,
            ) {
              Navigator.popUntil(ctx, ModalRoute.withName(AppRoutes.home));
            }),
            _buildTile(context, 'Push Replacement Example', Icons.swap_horiz, (
              ctx,
            ) {
              Navigator.pushReplacementNamed(ctx, AppRoutes.profile);
            }),
          ]),
          _buildSection('Route Management', [
            _buildTile(context, 'Check Current Route', Icons.route, (ctx) {
              final currentRoute =
                  ModalRoute.of(ctx)?.settings.name ?? 'unknown';
              ScaffoldMessenger.of(ctx).showSnackBar(
                SnackBar(
                  content: Text('Current route: $currentRoute'),
                  duration: const Duration(seconds: 2),
                ),
              );
            }),
            _buildTile(
              context,
              'PushNamed and Remove Until',
              Icons.layers_clear,
              (ctx) {
                // Push new route and remove all until home
                Navigator.pushNamedAndRemoveUntil(
                  ctx,
                  AppRoutes.profile,
                  ModalRoute.withName(AppRoutes.home),
                );
              },
            ),
          ]),
          _buildSection('Data Passing', [
            _buildTile(context, 'Pass Data to Profile', Icons.send, (ctx) {
              Navigator.pushNamed(
                ctx,
                AppRoutes.profile,
                arguments: {
                  'message': 'Hello from Settings',
                  'timestamp': DateTime.now().toString(),
                },
              );
            }),
            _buildTile(context, 'Get Pop Result', Icons.reply, (ctx) async {
              // Navigate to profile and wait for result
              final result = await Navigator.pushNamed(ctx, AppRoutes.profile);

              if (result != null) {
                ScaffoldMessenger.of(
                  ctx,
                ).showSnackBar(SnackBar(content: Text('Received: $result')));
              }
            }),
          ]),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Icon(Icons.settings, size: 80, color: Colors.blue),
          const SizedBox(height: 10),
          const Text(
            'Settings',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            'Explore navigation options',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ...children,
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildTile(
    BuildContext context,
    String title,
    IconData icon,
    Function(BuildContext) onTap,
  ) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.blue, size: 20),
      ),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () => onTap(context),
    );
  }

  void _showNavigationStack(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Navigation Stack Info',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const ListTile(
              leading: Icon(Icons.circle, size: 8, color: Colors.blue),
              title: Text('Can pop: Yes (if not at root)'),
            ),
            const ListTile(
              leading: Icon(Icons.circle, size: 8, color: Colors.blue),
              title: Text('Current route: Settings'),
            ),
            const ListTile(
              leading: Icon(Icons.circle, size: 8, color: Colors.blue),
              title: Text('Previous routes: Home, Products, Profile'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}
