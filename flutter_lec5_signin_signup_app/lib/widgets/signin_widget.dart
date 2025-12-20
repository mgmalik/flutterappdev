import 'package:flutter/material.dart';
import 'package:flutter_lec5_signin_signup_app/model/state_provider.dart';
import 'package:flutter_lec5_signin_signup_app/widgets/textfield_widget.dart';
import 'package:provider/provider.dart';

class SigninWidget extends StatelessWidget {
  const SigninWidget({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextfieldWidget(
          hintText: 'Email',
          prefixIconData: Icons.mail_outline,
          suffixIconData: context.watch<StateProvider>().isValid
              ? Icons.check
              : null,
          obscureText: false,
          onChanged: (value) {
            context.read<StateProvider>().verifyEmail(value);
          },
          color: Colors.indigo,
          controller: emailController,
          isValid: context.watch<StateProvider>().isValidEmail,
        ),
        SizedBox(height: 10.0),
        TextfieldWidget(
          hintText: 'Password',
          prefixIconData: Icons.lock_outline,
          suffixIconData: context.watch<StateProvider>().isVisible
              ? Icons.visibility
              : Icons.visibility_off,
          obscureText: !context.watch<StateProvider>().isVisible,
          onChanged: (value) {
            context.read<StateProvider>().verifyPassword(value);
          },
          color: Colors.indigo,
          controller: passwordController,
          isValid: context.watch<StateProvider>().isValidPassword,
        ),
      ],
    );
  }
}
