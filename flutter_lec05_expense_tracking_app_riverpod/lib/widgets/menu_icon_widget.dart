import 'package:flutter/material.dart';
import 'package:flutter_lec05_expense_tracking_app_riverpod/constants.dart';

class MenuIconWidget extends StatelessWidget {
  const MenuIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Scaffold.of(context).openDrawer();
      },
      child: Icon(Icons.menu, color: Constants.textColorWithBackground),
    );
  }
}
