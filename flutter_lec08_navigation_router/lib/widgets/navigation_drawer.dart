import 'package:flutter/material.dart';
import 'package:flutter_lec08_navigation_router/routes/app_routes.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blue, Colors.blue.shade700],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.navigation, size: 40, color: Colors.blue),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Navigation Demo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Built-in Router',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(context, 'Home', Icons.home, AppRoutes.home),
            _buildDrawerItem(
              context,
              'Products',
              Icons.shopping_bag,
              AppRoutes.products,
            ),
            _buildDrawerItem(
              context,
              'Profile',
              Icons.person,
              AppRoutes.profile,
            ),
            _buildDrawerItem(
              context,
              'Settings',
              Icons.settings,
              AppRoutes.settings,
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Navigation Methods:',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
              child: Row(
                children: [
                  Icon(Icons.circle, size: 6, color: Colors.blue),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'pushNamed - Add to stack',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
              child: Row(
                children: [
                  Icon(Icons.circle, size: 6, color: Colors.blue),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'pop - Go back',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
              child: Row(
                children: [
                  Icon(Icons.circle, size: 6, color: Colors.blue),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'pushReplacementNamed - Replace current',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
              child: Row(
                children: [
                  Icon(Icons.circle, size: 6, color: Colors.blue),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'popUntil - Go back multiple',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context,
    String title,
    IconData icon,
    String route,
  ) {
    final isCurrentRoute = ModalRoute.of(context)?.settings.name == route;

    return ListTile(
      leading: Icon(
        icon,
        color: isCurrentRoute ? Colors.blue : Colors.grey.shade700,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isCurrentRoute ? Colors.blue : Colors.grey.shade700,
          fontWeight: isCurrentRoute ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isCurrentRoute,
      selectedTileColor: Colors.blue.shade50,
      onTap: () {
        Navigator.pop(context); // Close drawer
        if (!isCurrentRoute) {
          // Navigate to selected route
          Navigator.pushNamed(context, route);
        }
      },
    );
  }
}
