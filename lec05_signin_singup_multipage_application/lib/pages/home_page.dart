import 'package:flutter/material.dart';
import 'package:lec05_signin_singup_multipage_application/models/user_model.dart';
import 'package:lec05_signin_singup_multipage_application/widgets/button_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(userModel.name),
            Text(userModel.email),
            Text(userModel.password),
            ButtonWidget(
              title: 'Signout',
              onPressed: () {
                Navigator.of(context).pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
