import 'package:flutter/material.dart';
import 'package:flutter_lec05_expense_tracking_app_riverpod/constants.dart';
import 'package:flutter_lec05_expense_tracking_app_riverpod/pages/manage_categories_page.dart';
import 'package:flutter_lec05_expense_tracking_app_riverpod/pages/manage_tags_page.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Constants.appColor),
            child: Center(
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Constants.textColorWithBackground,
                  fontSize: 30.0,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.category),
            title: Text('Manage Categories'),
            onTap: () {
              Scaffold.of(context).closeDrawer();
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ManageCategoriesPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.tag),
            title: Text('Manage Tags'),
            onTap: () {
              Scaffold.of(context).closeDrawer();
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => ManageTagsPage()));
            },
          ),
        ],
      ),
    );
  }
}
