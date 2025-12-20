import 'package:flutter/material.dart';
import 'package:flutter_lec5_signin_signup_app/model/state_provider.dart';
import 'package:provider/provider.dart';

class ChangeWidget extends StatelessWidget {
  const ChangeWidget({super.key, required this.onTap});
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<StateProvider>(context);
    return GestureDetector(
      onTap: onTap,
      child: Text(
        model.isSignup ? 'Login' : 'Signup',
        style: TextStyle(color: Colors.redAccent),
      ),
    );
  }
}
